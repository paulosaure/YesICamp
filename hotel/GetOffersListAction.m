//
//  GetCampingsList.m
//  hotel
//
//  Created by Paul Lavoine on 26/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "GetOffersListAction.h"
#import "Offer.h"

#define OFFERS_URL              @"offers"

#define OFFERS_WITH_CITY_URL     @"search/offers/count"
#define OFFERS_WITH_CAMPING      @"search/offers/by_camping"

@implementation GetOffersListAction

#pragma mark - Constructor

+ (instancetype)action
{
    GetOffersListAction *action = [[GetOffersListAction alloc] initWithUrl:ACTION_URL(OFFERS_URL) service:WebServiceGetOffersList];
    
    return action;
}

+ (instancetype)actionWithCity:(NSString *)city count:(NSInteger)count
{
    NSString *urlSuffix = [NSString stringWithFormat:@"%@/%ld/place?name=%@",OFFERS_WITH_CITY_URL, (long)count, city];
    GetOffersListAction *action = [[GetOffersListAction alloc] initWithUrl:ACTION_URL(urlSuffix) service:WebServiceGetOffersList];
    
    return action;
}

+ (instancetype)actionWithCampingId:(NSString *)campingId
{
    NSString *urlSuffix = [NSString stringWithFormat:@"%@/%@",OFFERS_WITH_CAMPING, campingId];
    GetOffersListAction *action = [[GetOffersListAction alloc] initWithUrl:ACTION_URL(urlSuffix) service:WebServiceGetOffersList];
    
    return action;
}

#pragma mark - Manage Answer

- (void)handleDownloadedData:(NSDictionary *)obj
{
    [super handleDownloadedData:obj];
    
    NSMutableArray *offers = [NSMutableArray array];
    NSData *data = [[obj objectForKey:RESPONSE_BODY] dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *offersJson = (NSArray *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    for (NSDictionary *offer in offersJson)
    {
        [offers addObject:[[Offer alloc] initWithDictionnary:offer]];
    }
    
    [NOTIFICATION_CENTER postNotificationName:OffersListNotification object:offers];
}

@end
