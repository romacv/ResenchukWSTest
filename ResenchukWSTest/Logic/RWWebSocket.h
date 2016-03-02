//
//  RWWebSocket.h
//  ResenchukWSTest
//
//  Created by ROMAN RESENCHUK on 16.02.16.
//  Copyright © 2016 ROMAN RESENCHUK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SRWebSocket.h"

@interface RWWebSocket : NSObject

@property (nonatomic) SRWebSocket *socket;

+ (instancetype)sharedSockets;

- (void)connectSocket;
- (void)disconnectSocket;

@end
