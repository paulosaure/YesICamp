//
//  DeconnectionUserAction.m
//  Yes I Camp
//
//  Created by Paul Lavoine on 29/02/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "DeconnectionUserAction.h"

#define DECONNECTION_URL @"auth/sign_out"

@implementation DeconnectionUserAction

#pragma mark - Constructor

+ (instancetype)action
{
    DeconnectionUserAction *action = [[DeconnectionUserAction alloc] initWithUrl:ACTION_URL(DECONNECTION_URL) service:WebServiceDeconnection];
    
    return action;
}

#pragma mark - Manage Answer

- (void)handleDownloadedData:(NSDictionary *)obj
{
    [super handleDownloadedData:obj];
    
    NSHTTPURLResponse *header = [obj objectForKey:RESPONSE_HEADER];
//    NSData *data = [[obj objectForKey:RESPONSE_BODY] dataUsingEncoding:NSUTF8StringEncoding];
//    NSDictionary *body = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];

    
    [NOTIFICATION_CENTER postNotificationName:DeconnectionReponseNotification object:@(header.statusCode)];
}

@end
