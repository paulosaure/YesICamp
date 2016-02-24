//
//  InscriptionUserAction.m
//  hotel
//
//  Created by Paul Lavoine on 20/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "InscriptionUserAction.h"

#define INSCRIPTION_URL @"auth"

@implementation InscriptionUserAction

#pragma mark - Constructor

+ (instancetype)action:(NSString *)firstName lastName:(NSString *)lastName email:(NSString *)email password:(NSString *)password age:(NSString *)age
{
    NSString *postParam = [NSString stringWithFormat:@"firstName=%@&lastName=%@&email=%@&password=%@&age=%@",firstName, lastName, email, password, age];
    InscriptionUserAction *action = [[InscriptionUserAction alloc] initWithUrl:ACTION_URL(INSCRIPTION_URL) service:WebServiceInscription param:postParam];
    return action;
}

#pragma mark - Manage Answer

- (void)handleDownloadedData:(NSDictionary *)obj
{
    [super handleDownloadedData:obj];
    
    NSHTTPURLResponse *header = [obj objectForKey:RESPONSE_HEADER];
    NSDictionary *body = [obj objectForKey:RESPONSE_BODY];
    [NOTIFICATION_CENTER postNotificationName:InscriptionReponseNotification object:@(header.statusCode)];
}

@end
