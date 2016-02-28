//
//  SendCardDetailAction.m
//  Yes I Camp
//
//  Created by Paul Lavoine on 28/02/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "SendCardDetailAction.h"

@implementation SendCardDetailAction

+ (instancetype)actionSendCardDetail:(CardDetail *)cardDetail cardRegistration:(CardRegistration *)cardRegistration
{
    NSString *postCardParam = [NSString stringWithFormat:@"PreRegistrationData=%@&AccessKey=%@cardNumber=%@&expirationDate=%@&cvx=%@",
                               cardRegistration.preRegistrationData,
                               cardRegistration.accessKey,
                               cardDetail.cardNumber,
                               cardDetail.cardExpirationDate,
                               cardDetail.cardCvx];
    
    SendCardDetailAction *action = [[SendCardDetailAction alloc] initWithUrl:cardRegistration.cardRegistrationUrl
                                                                     service:WebServiceSendCardDetail
                                                                       param:postCardParam];
    
    return action;
}

#pragma mark - Manage Answer

- (void)handleDownloadedData:(NSDictionary *)obj
{
    [super handleDownloadedData:obj];
    
    NSHTTPURLResponse *header = [obj objectForKey:RESPONSE_HEADER];
    NSData *data = [[obj objectForKey:RESPONSE_BODY] dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *registrationDataJson = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    if (header.statusCode == 200)
    {
        [NOTIFICATION_CENTER postNotificationName:didReceiveRegistrationDataSuccededNotification object:nil];
    }
    else
    {
        [NOTIFICATION_CENTER postNotificationName:didReceiveRegistrationDataFailedNotification object:nil];
        
    }
}

@end
