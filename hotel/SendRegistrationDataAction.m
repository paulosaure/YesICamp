//
//  SendRegistrationDataAction.m
//  Yes I Camp
//
//  Created by Paul Lavoine on 28/02/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "SendRegistrationDataAction.h"

#define PAYMENT_URL        @"/pay"

@implementation SendRegistrationDataAction

+ (instancetype)actionSendRegistrationData:(CardRegistration *)cardRegistration bookingId:(NSString *)bookingId
{
    NSString *postCardParam = [NSString stringWithFormat:@"booking_id=%@&registration_data=%@",bookingId, cardRegistration.preRegistrationData];
    SendRegistrationDataAction *action = [[SendRegistrationDataAction alloc] initWithUrl:ACTION_URL(PAYMENT_URL) service:WebServiceSendRegistrationData param:postCardParam];
    
    return action;
}

#pragma mark - Manage Answer

- (void)handleDownloadedData:(NSDictionary *)obj
{
    [super handleDownloadedData:obj];
    
    NSHTTPURLResponse *header = [obj objectForKey:RESPONSE_HEADER];
    NSData *data = [[obj objectForKey:RESPONSE_BODY] dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *registrationResultDataJson = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    if (header.statusCode == 200)
    {
        [NOTIFICATION_CENTER postNotificationName:didPaymentSuccededNotification object:nil];
    }
    else
    {
        [NOTIFICATION_CENTER postNotificationName:didPaymentFailedNotification object:nil];
        
    }
}

@end
