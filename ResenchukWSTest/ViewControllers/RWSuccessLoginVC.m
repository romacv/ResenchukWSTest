//
//  RWSuccessLoginVC.m
//  ResenchukWSTest
//
//  Created by ROMAN RESENCHUK on 16.02.16.
//  Copyright © 2016 ROMAN RESENCHUK. All rights reserved.
//

#import "RWSuccessLoginVC.h"
#import "FDKeychain.h"

@interface RWSuccessLoginVC ()

@property (weak, nonatomic) IBOutlet UILabel *expdateLabel;

@end

@implementation RWSuccessLoginVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSError *error = nil;
    NSString *savedTokenExpirationDate = [FDKeychain itemForKey:kApiTokenExpDate
                                                     forService:kKeyChainKey
                                                          error:&error];
    self.expdateLabel.text = savedTokenExpirationDate;
    
}

@end
