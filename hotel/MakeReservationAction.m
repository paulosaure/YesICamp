//
//  MakeReservationAction.m
//  Yes I Camp
//
//  Created by Paul Lavoine on 21/02/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "MakeReservationAction.h"

#define RESERVATION_URL @"user/book"

@implementation MakeReservationAction

#pragma mark - Constructor

+ (instancetype)actionWithDateBegin:(NSString *)dateBegin dateEnd:(NSString *)dateEnd redactedCardNumber:(NSString *)redactedCardNumber expiryMonth:(NSString *)expiryMonth expiryYear:(NSString *)expiryYear cvv:(NSString *)cvv
{
    NSString *postCardParam = [NSString stringWithFormat:@"dateBegin=%@&dateEnd=%@&redactedCardNumber=%@&expiryMonth=%@&expiryYear=%@&cvv=%@",dateBegin, dateEnd, redactedCardNumber,expiryYear ,expiryMonth, cvv];
    MakeReservationAction *action = [[MakeReservationAction alloc] initWithUrl:ACTION_URL(RESERVATION_URL) service:WebServiceMakeReservation param:postCardParam];
    
    return action;
}

#pragma mark - Manage Answer

- (void)handleDownloadedData:(NSDictionary *)obj
{
    [super handleDownloadedData:obj];
    
    NSHTTPURLResponse *header = [obj objectForKey:RESPONSE_HEADER];
    NSDictionary *body = [obj objectForKey:RESPONSE_BODY];
    NSString *response = @"";
    
#warning TODO
    if (header.statusCode != 200)
    {

    }
    else
    {
        
    }
    
    [NOTIFICATION_CENTER postNotificationName:didReservationNotification object:response];
}

@end
