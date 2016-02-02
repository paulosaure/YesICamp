//
//  GetHotsDealsListAction.m
//  Yes I Camp
//
//  Created by Paul Lavoine on 02/02/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "GetHotsDealsListAction.h"

#define HOTS_DEALS_URL     @"hot_deals"

@implementation GetHotsDealsListAction

#pragma mark - Constructor

+ (instancetype)action
{
    GetHotsDealsListAction *action = [[GetHotsDealsListAction alloc] initWithUrl:ACTION_URL(HOTS_DEALS_URL) service:WebServiceGetHotsDealsList];
    
    return action;
}

#pragma mark - Manage Answer

- (void)handleDownloadedData:(NSString *)obj
{
    [super handleDownloadedData:obj];
    
    NSLog(@"Success %@", obj);
    
    [NOTIFICATION_CENTER postNotificationName:HotsDealsListNotification object:obj];
}

@end