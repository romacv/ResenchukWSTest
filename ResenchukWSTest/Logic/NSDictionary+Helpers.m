//
//  NSDictionary+Helpers.m
//  ResenchukWSTest
//
//  Created by ROMAN RESENCHUK on 17.02.16.
//  Copyright © 2016 ROMAN RESENCHUK. All rights reserved.
//

#import "NSDictionary+Helpers.h"

@implementation NSDictionary (Helpers)

- (NSString *)stringJSONFromDict
{
    NSError *err;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:&err];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
