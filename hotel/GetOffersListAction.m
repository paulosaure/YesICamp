//
//  GetCampingsList.m
//  hotel
//
//  Created by Paul Lavoine on 26/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "GetOffersListAction.h"

#define OFFERS_URL     @"get_all_offres.php"

#define OFFERS_LIST_NOTIFICATION @"OFFERS_LIST_NOTIFICATION"

@implementation GetOffersListAction

#pragma mark - Constructor

+ (instancetype)action
{
    GetOffersListAction *action = [[GetOffersListAction alloc] init];
    return action;
}

#pragma mark - Action

- (void)requestServer
{
    NSString *actionTypeNotification = [NSString stringWithFormat:@"%ld", (long)WebServiceGetOffersList];
    [NOTIFICATION_CENTER addObserver:self selector:@selector(handleDownloadedData:) name:actionTypeNotification object:nil];
    [super connectionWithServer:ACTION_URL(OFFERS_URL) action:WebServiceGetOffersList];

}

- (void)handleDownloadedData:(NSNotification *)notif
{
    NSLog(@"test");
}
@end
