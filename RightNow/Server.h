//
//  Server.h
//  Shadal
//
//  Created by Sukwon Choi on 6/25/14.
//  Copyright (c) 2014 Wafflestudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Server : NSObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate>
+ (void)sendRequest:(NSString *)subways status:(int)status;

@end
