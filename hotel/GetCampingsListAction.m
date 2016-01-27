//
//  GetCampingsListAction.m
//  hotel
//
//  Created by Paul Lavoine on 20/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "GetCampingsListAction.h"
#import <AFHTTPSessionManager.h>

#define CAMPINGS_URL      @"get_all_campings.php"

@implementation GetCampingsListAction

#pragma mark - Constructor

+ (instancetype)action
{
    GetCampingsListAction *action = [[GetCampingsListAction alloc] init];
    return action;
}

#pragma mark - Action

- (void)requestServer
{
    [NOTIFICATION_CENTER addObserver:self selector:@selector(handleDownloadedData:) name:[@(WebServiceGetCampingsList) stringValue] object:nil];
    [super requestServer:ACTION_URL(CAMPINGS_URL) action:WebServiceGetCampingsList];
}

- (void)handleDownloadedData:(NSNotification *)notif
{
    NSLog(@"Success %@", notif.object);
}

@end
