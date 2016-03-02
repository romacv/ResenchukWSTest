//
//  RWLoginVC.m
//  ResenchukWSTest
//
//  Created by ROMAN RESENCHUK on 16.02.16.
//  Copyright © 2016 ROMAN RESENCHUK. All rights reserved.
//

#import "RWLoginVC.h"
#import "FDKeychain.h"

#import "RWWebSocketResponseHandler.h"
#import "RWWebSocketCommands.h"

@interface RWLoginVC ()

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextfield;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;

@end

@implementation RWLoginVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(webSocketDidReceiveMessage:)
                                                 name:kWSDidReceiveMessage
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(webSocketResponseCustomerError:)
                                                 name:kWSCustomerError
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(webSocketResponseCustomerError:)
                                                 name:kWSCustomerValidationError
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(webSocketResponseCustomerApiToken:)
                                                 name:kWSCustomerApiToken
                                               object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - WebSocket

- (void)webSocketDidReceiveMessage:(NSNotification *)notification
{
    [RWWebSocketResponseHandler handleMessage:notification.object];
}

- (void)webSocketResponseCustomerError:(NSNotification *)notification
{
    NSError *error = nil;
    [FDKeychain saveItem:@""
                  forKey:kApiToken
              forService:kKeyChainKey
                   error:&error];
    
    self.errorLabel.hidden = NO;
    self.errorLabel.text = notification.object[@"data"][kErrorDescription];
    
}

- (void)webSocketResponseCustomerApiToken:(NSNotification *)notification
{
    NSString *api_token = notification.object[@"data"][kApiToken];
    NSString *api_token_expiration_date = notification.object[@"data"][kApiTokenExpDate];
    
    NSError *error = nil;
    [FDKeychain saveItem:api_token
                  forKey:kApiToken
              forService:kKeyChainKey
                   error:&error];
    [FDKeychain saveItem:api_token_expiration_date
                  forKey:kApiTokenExpDate
              forService:kKeyChainKey
                   error:&error];
    
    [self performSegueWithIdentifier:kSegueLoginShowSuccessScreen sender:nil];
    
}

- (IBAction)tapLogin:(id)sender
{
    self.errorLabel.hidden = YES;
    [RWWebSocketCommands loginWithUsername:self.emailTextField.text password:self.passwordTextfield.text];
}
@end
