//
//  PayReservationAction.m
//  Yes I Camp
//
//  Created by Paul Lavoine on 27/02/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "SendCardRegistrationAction.h"
#import "SendCardDetailAction.h"

#define PAYMENT_FORM_URL   @"/cardregistration"


@interface SendCardRegistrationAction ()

@end

@implementation SendCardRegistrationAction

#pragma mark - Constructor

+ (instancetype)actionSendCardRegistration:(PaymentForm *)paymentForm
{
    SendCardRegistrationAction *action = [[SendCardRegistrationAction alloc] initWithUrl:ACTION_URL(PAYMENT_FORM_URL) service:WebServiceSendCardRegistration param:[self buildPostParamWithPaymentForm:paymentForm]];
    
    return action;
}

+ (NSString *)buildPostParamWithPaymentForm:(PaymentForm *)paymentForm
{
    return [NSString stringWithFormat:@"booking_id=%@&firstname=%@&lastname=%@&email=%@&birthday=%@&nationality=%@&country_of_residence=%@&currency=%@&card_type=%@&",
            paymentForm.bookingId,
            paymentForm.firstname,
            paymentForm.lastname,
            paymentForm.email,
            paymentForm.birthday,
            paymentForm.nationality,
            paymentForm.countryOfResidence,
            paymentForm.currency,
            paymentForm.cardType];
}

#pragma mark - Manage Answer

- (void)handleDownloadedData:(NSDictionary *)obj
{
    [super handleDownloadedData:obj];
    
    NSHTTPURLResponse *header = [obj objectForKey:RESPONSE_HEADER];
    NSData *data = [[obj objectForKey:RESPONSE_BODY] dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *cardRegistrationJson = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    
    if (header.statusCode == 200)
    {
        CardRegistration *cardRegistration = [[CardRegistration alloc] initWithAccessKey:[cardRegistrationJson                  objectForKey:@"AccessKey"]
                                                                     preRegistrationData:[cardRegistrationJson objectForKey:@"PreregistrationData"]
                                                                     cardRegistrationUrl:[cardRegistrationJson objectForKey:@"CardRegistrationURL"]];
        
        [NOTIFICATION_CENTER postNotificationName:didReceiveCardRegistrationSuccededNotification object:cardRegistration];
    }
    else
    {
        [NOTIFICATION_CENTER postNotificationName:didReceiveCardRegistrationFailedNotification object:nil];
        
    }
}

@end
