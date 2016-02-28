//
//  PayReservationAction.h
//  Yes I Camp
//
//  Created by Paul Lavoine on 27/02/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "HTTPAction.h"

#define didReceiveCardRegistrationSuccededNotification @"didReceiveCardRegistrationSuccededNotification"
#define didReceiveCardRegistrationFailedNotification @"didReceiveCardRegistrationFailedNotification"

@interface SendCardRegistrationAction : HTTPAction

+ (instancetype)actionSendCardRegistration:(PaymentForm *)paymentForm;

@end
