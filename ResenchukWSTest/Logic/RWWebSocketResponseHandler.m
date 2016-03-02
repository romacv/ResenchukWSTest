//
//  RWWebSocketResponseHandler.m
//  ResenchukWSTest
//
//  Created by ROMAN RESENCHUK on 17.02.16.
//  Copyright © 2016 ROMAN RESENCHUK. All rights reserved.
//

#import "RWWebSocketResponseHandler.h"

@implementation RWWebSocketResponseHandler

+ (void)handleMessage:(id)message
{
    NSError *error;
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:[message dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
    
    if ([jsonDict[@"type"] isEqualToString:kCustomerError])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:kWSCustomerError object:jsonDict];
    }
    else if ([jsonDict[@"type"] isEqualToString:kCustomerValidationError])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:kWSCustomerValidationError object:jsonDict];
    }
    else if ([jsonDict[@"type"] isEqualToString:kCustomerApiToken])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:kWSCustomerApiToken object:jsonDict];
    }
    
}

@end
