//
//  GetCampingsList.m
//  hotel
//
//  Created by Paul Lavoine on 26/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "GetOffersListAction.h"

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
    
    NSLog(@"Success %@", obj);
}

@end
