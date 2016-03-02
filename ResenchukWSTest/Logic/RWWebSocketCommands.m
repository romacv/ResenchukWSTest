//
//  RWWebSocketCommands.m
//  ResenchukWSTest
//
//  Created by ROMAN RESENCHUK on 17.02.16.
//  Copyright © 2016 ROMAN RESENCHUK. All rights reserved.
//

#import "RWWebSocketCommands.h"
#import "RWWebSocket.h"

#import "NSDictionary+Helpers.h"

@implementation RWWebSocketCommands

+ (void)loginWithUsername:(NSString *)username
                 password:(NSString *)password
{
    NSDictionary *loginMSG = @{
                               @"type":@"LOGIN_CUSTOMER",
                               @"sequence_id":@"a29e4fd0-581d-e06b-c837-4f5f4be7dd18",
                               @"data":@{
                                       @"email": username,
                                       @"password": password}
                               };
    NSString *myString = [loginMSG stringJSONFromDict];
    
    [[RWWebSocket sharedSockets].socket send:myString];
}

@end
