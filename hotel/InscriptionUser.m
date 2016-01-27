//
//  InscriptionUser.m
//  hotel
//
//  Created by Paul Lavoine on 20/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "InscriptionUser.h"

#define INSCRIPTION_URL @""

@implementation InscriptionUser

#pragma mark - Constructor

+ (instancetype)action
{
    InscriptionUser *action = [[InscriptionUser alloc] init];
    return action;
}

#pragma mark - Action

- (void)requestServer
{
    [NOTIFICATION_CENTER addObserver:self selector:@selector(handleDownloadedData:) name:[@(WebServiceInscription) stringValue] object:nil];
    [super requestServer:ACTION_URL(INSCRIPTION_URL) action:WebServiceInscription];
}

- (void)handleDownloadedData:(NSNotification *)notif
{
    NSLog(@"Success %@", notif.object);
}

@end
