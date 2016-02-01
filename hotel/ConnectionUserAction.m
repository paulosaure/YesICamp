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
    ConnectionUserAction *action = [[ConnectionUserAction alloc] initWithUrl:ACTION_URL(CONNECTION_URL) service:WebServiceGetOffersList];
    
    return action;
}

#pragma mark - Manage Answer

- (void)handleDownloadedData:(NSString *)obj
{
    [super handleDownloadedData:obj];
    
    NSLog(@"Success %@", obj);
}

@end
