//
//  GetHotsDealsListAction.m
//  Yes I Camp
//
//  Created by Paul Lavoine on 02/02/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "GetHotsDealsListAction.h"

#define HOTS_DEALS_URL     @"search/offers"

@implementation GetHotsDealsListAction

#pragma mark - Constructor

+ (instancetype)action:(ParamRequestHotDeal *)params
{
    NSString *urlSuffix = [NSString stringWithFormat:@"%@/latitude/%@/longitude/%@/count/%@", HOTS_DEALS_URL, params.latitude, params.longitude, params.locationDisplay];
    
    
    GetHotsDealsListAction *action = [[GetHotsDealsListAction alloc] initWithUrl:ACTION_URL(urlSuffix) service:WebServiceGetHotsDealsList];
    
    return action;
}
                                                                          
#pragma mark - Manage Answer

- (void)handleDownloadedData:(NSString *)obj
{
    [super handleDownloadedData:obj];
    
    NSMutableArray *offers = [NSMutableArray array];
    NSData *data = [obj dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *offersJson = (NSArray *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    for (NSDictionary *offerJson in offersJson)
    {
        [offers addObject:[[Camping alloc] initWithDictionnary:offerJson]];
    }

    
    [NOTIFICATION_CENTER postNotificationName:HotsDealsListNotification object:offers];
}

@end