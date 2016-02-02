//
//  GetCampingsList.m
//  hotel
//
//  Created by Paul Lavoine on 26/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "GetOffersListAction.h"
#import "Offer.h"

#define OFFERS_URL     @"offers"

@implementation GetOffersListAction

#pragma mark - Constructor

+ (instancetype)action
{
    GetOffersListAction *action = [[GetOffersListAction alloc] initWithUrl:ACTION_URL(OFFERS_URL) service:WebServiceGetOffersList];
    
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
    
    [NOTIFICATION_CENTER postNotificationName:OffersListNotification object:offers];
}

@end
