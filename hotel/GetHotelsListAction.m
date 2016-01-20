//
//  GetHotelsListAction.m
//  hotel
//
//  Created by Paul Lavoine on 20/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "GetHotelsListAction.h"
#import <AFHTTPSessionManager.h>

@implementation GetHotelsListAction

- (void)getHotelsListWithName:(NSString *)destination url:(NSString *)url
{
    [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:url parameters:destination error:nil];
}

@end
