//
//  GetOffersWithCampingAction.m
//  Yes I Camp
//
//  Created by Paul Lavoine on 18/02/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "GetOffersWithCampingAction.h"

#import "GetOffersListAction.h"
#import "Offer.h"

#define OFFERS_URL     @"offers"

@implementation GetOffersWithCampingAction

#pragma mark - Constructor

+ (instancetype)actionWithCampingId:(NSString *)campingId
{
    NSString *urlSuffix = [NSString stringWithFormat:@"%@/%@",OFFERS_URL, campingId];
    GetOffersWithCampingAction *action = [[GetOffersWithCampingAction alloc] initWithUrl:ACTION_URL(urlSuffix) service:WebServiceGetOffersList];
    
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
        [offers addObject:[[Offer alloc] initWithDictionnary:offerJson]];
    }
    
    [NOTIFICATION_CENTER postNotificationName:OffersListWithCampingNotification object:offers];
}

@end
