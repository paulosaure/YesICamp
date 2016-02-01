//
//  InscriptionUserAction.m
//  hotel
//
//  Created by Paul Lavoine on 20/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "InscriptionUserAction.h"

#define INSCRIPTION_URL @""

@implementation InscriptionUserAction

#pragma mark - Constructor

+ (instancetype)action
{
    InscriptionUserAction *action = [[InscriptionUserAction alloc] initWithUrl:ACTION_URL(INSCRIPTION_URL) service:WebServiceGetOffersList];
    
    [NOTIFICATION_CENTER addObserver:self selector:@selector(handleDownloadedData:) name:[@(WebServiceGetOffersList) stringValue] object:nil];
    
    return action;
}

#pragma mark - Manage Answer

- (void)handleDownloadedData:(NSString *)obj
{
    [super handleDownloadedData:obj];
    
    NSLog(@"Success %@", obj);
}

@end
