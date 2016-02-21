//
//  ConnectionUser.m
//  hotel
//
//  Created by Paul Lavoine on 20/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//
#import "ConnectionUserAction.h"

#define CONNECTION_URL @"auth/sign_in"

@implementation ConnectionUserAction

#pragma mark - Constructor

+ (instancetype)action:(NSString *)userName password:(NSString *)password
{
    NSString *postParam = [NSString stringWithFormat:@"Username=%@&Password=%@",userName,password];
    ConnectionUserAction *action = [[ConnectionUserAction alloc] initWithUrl:ACTION_URL(CONNECTION_URL) service:WebServiceGetOffersList param:postParam];
    
    return action;
}

#pragma mark - Manage Answer

- (void)handleDownloadedData:(NSDictionary *)obj
{
    [super handleDownloadedData:obj];
    
    NSHTTPURLResponse *header = [obj objectForKey:RESPONSE_HEADER];
    NSDictionary *body = [obj objectForKey:RESPONSE_BODY];
    NSString *response = @"";
    
    if (header.statusCode != 200)
    {
        response = LOCALIZED_STRING(@"globals.error");
    }
    else
    {
        [[User sharedInstance] didConnectionSucceded:@"" lastName:@"" email:@"" password:@"" age:@""];
    }
    
    [NOTIFICATION_CENTER postNotificationName:ConnectionReponseNotification object:response];
}

@end
