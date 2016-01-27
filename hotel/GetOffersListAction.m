//
//  GetCampingsList.m
//  hotel
//
//  Created by Paul Lavoine on 26/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "GetOffersListAction.h"

#define OFFERS_URL     @"get_all_offres.php"

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
    [NOTIFICATION_CENTER addObserver:self selector:@selector(handleDownloadedData:) name:[@(WebServiceGetOffersList) stringValue] object:nil];
    [super requestServer:ACTION_URL(OFFERS_URL) action:WebServiceGetOffersList];
}

- (void)handleDownloadedData:(NSNotification *)notif
{
    NSLog(@"Success %@", notif.object);
}
@end
