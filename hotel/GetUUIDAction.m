//
//  GetUUIDAction.m
//  Yes I Camp
//
//  Created by Paul Lavoine on 29/05/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "GetUUIDAction.h"

#define SEND_UUID_URL      @"user/push/subscribe"

@implementation GetUUIDAction

#pragma mark - Constructor
+ (instancetype)action:(NSString *)token name:(NSString *)name;
{
    NSString *postParam = [NSString stringWithFormat:@"token=%@&platform=1&name=%@",token, name];
    GetUUIDAction *action = [[GetUUIDAction alloc] initWithUrl:ACTION_URL(SEND_UUID_URL) service:WebServiceSendUUID param:postParam];
    return action;
}

#pragma mark - Manage Answer

- (void)handleDownloadedData:(NSDictionary *)obj
{
    [super handleDownloadedData:obj];

}

@end
