//
//  RWWebSocket.m
//  ResenchukWSTest
//
//  Created by ROMAN RESENCHUK on 16.02.16.
//  Copyright © 2016 ROMAN RESENCHUK. All rights reserved.
//

#import "RWWebSocket.h"
#import "SRWebSocket.h"

static RWWebSocket *sharedSockets = nil;

@interface RWWebSocket () <SRWebSocketDelegate>

@end

@implementation RWWebSocket

#pragma mark - Singleton
+ (instancetype)sharedSockets
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSockets = [RWWebSocket new];
    });
    return sharedSockets;
}

#pragma mark - Public
- (void)connectSocket
{
    NSURL *url = [NSURL URLWithString:kUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    self.socket = [[SRWebSocket alloc] initWithURLRequest:request];
    self.socket.delegate = self;
    [self.socket open];
}

- (void)disconnectSocket
{
    [self.socket close];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kWSClose object:nil];
}

#pragma mark - Delegate

- (void)webSocketDidOpen:(SRWebSocket *)webSocket
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kWSDidOpen object:nil];
}


- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kWSDidReceiveMessage object:message];

}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error
{
    // Try to reconnect socket after delay
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self connectSocket];
    });
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kWSDidFailWithError object:error];
}

@end
