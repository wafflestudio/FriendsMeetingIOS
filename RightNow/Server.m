//
//  Server.m
//  Shadal
//
//  Created by Sukwon Choi on 6/25/14.
//  Copyright (c) 2014 Wafflestudio. All rights reserved.
//

#import "Server.h"

@implementation Server{
#define WEB_BASE_URL @"http://coreahs.iptime.org:11623"
}

static NSMutableData * responseData;

+ (void)sendRequest:(NSString *)subways status:(int)status{
    dispatch_async(dispatch_get_main_queue(), ^(void){
        NSString * path =[NSString stringWithFormat:@"%@/%@/%d", WEB_BASE_URL, subways, status];
        NSString * encodedPath = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:encodedPath];
        
        NSLog(@"%@", [NSString stringWithFormat:@"%@/%@/%d", WEB_BASE_URL, subways, status]);
        NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:5];
        
        NSURLConnection * connection = [NSURLConnection connectionWithRequest:theRequest delegate:self];
        [connection scheduleInRunLoop:[NSRunLoop mainRunLoop]
                              forMode:NSDefaultRunLoopMode];
        
        NSLog(@"Connection Start");
        
        responseData = [[NSMutableData alloc] init];
        [connection start];
    });
}

+ (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"Did receiveResponse");
}
+ (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [responseData appendData:data];
}
+ (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"Failed to receive result");
    [connection start];
}

+ (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSLog(@"Did finish loading");
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
    if(json == NULL){
        NSLog(@"Received json is NULL");
        return;
    }
    // 노티피케이션 전송
    NSNotificationCenter *myNotificationCenter = [NSNotificationCenter defaultCenter];
    [myNotificationCenter postNotificationName:@"resultFromServer" object:self userInfo:json];
}
@end
