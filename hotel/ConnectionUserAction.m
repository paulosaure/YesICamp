//
//  ConnectionUser.m
//  hotel
//
//  Created by Paul Lavoine on 20/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//
#import "ConnectionUserAction.h"

#define CONNECTION_URL @""

@implementation ConnectionUserAction

#pragma mark - Constructor

+ (instancetype)action
{
    ConnectionUserAction *action = [[ConnectionUserAction alloc] init];
    return action;
}

#pragma mark - Action

- (void)requestServer
{
    [NOTIFICATION_CENTER addObserver:self selector:@selector(handleDownloadedData:) name:[@(WebServiceConnection) stringValue] object:nil];
    [super requestServer:ACTION_URL(CONNECTION_URL) action:WebServiceConnection];
}

- (void)handleDownloadedData:(NSNotification *)notif
{
    NSLog(@"Success %@", notif.object);
}

@end
