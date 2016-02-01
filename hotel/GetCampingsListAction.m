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
    GetCampingsListAction *action = [[GetCampingsListAction alloc] initWithUrl:ACTION_URL(CAMPINGS_URL) service:WebServiceGetOffersList];
    
    return action;
}

#pragma mark - Manage Answer

- (void)handleDownloadedData:(NSString *)obj
{
    [super handleDownloadedData:obj];
    
    NSLog(@"Success %@", obj);
}

@end
