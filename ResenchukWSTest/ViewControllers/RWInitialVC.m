//
//  RWInitialVC.m
//  ResenchukWSTest
//
//  Created by ROMAN RESENCHUK on 16.02.16.
//  Copyright © 2016 ROMAN RESENCHUK. All rights reserved.
//

#import "RWInitialVC.h"

#import "RWWebSocket.h"
#import "RWWebSocketCommands.h"
#import "RWWebSocketResponseHandler.h"

#import "FDKeychain.h"

@interface RWInitialVC ()

@end

@implementation RWInitialVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(webSocketDidOpen)
                                                 name:kWSDidOpen
                                               object:nil];
    [[RWWebSocket sharedSockets] connectSocket];
    
    
}

#pragma mark - WebSocket

- (void)webSocketDidOpen
{
    NSError *error = nil;
    NSString *savedToken = [FDKeychain itemForKey:kApiToken
                                       forService:kKeyChainKey
                                            error:&error];
    NSString *savedTokenExpirationDate = [FDKeychain itemForKey:kApiTokenExpDate
                                       forService:kKeyChainKey
                                            error: &error];
    
    // Process date
    NSDateFormatter *df = [NSDateFormatter new];
    [df setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZ"];
    NSDate *tokenExpDate = [df dateFromString:savedTokenExpirationDate];
    
    // Find date difference
    NSTimeInterval timeInterval = [tokenExpDate timeIntervalSinceDate:[NSDate date]];
    
    if (savedToken.length > 0 && timeInterval > 0)
    {
        [self performSegueWithIdentifier:kSegueShowSuccessScreen sender:nil];
    }
    else
    {
        [self performSegueWithIdentifier:kSegueShowLoginScreen sender:nil];
    }
}

@end
