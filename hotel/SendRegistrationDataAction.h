//
//  SendRegistrationDataAction.h
//  Yes I Camp
//
//  Created by Paul Lavoine on 28/02/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "HTTPAction.h"

#define didPaymentSuccededNotification @"didPaymentSuccededNotification"
#define didPaymentFailedNotification @"didPaymentFailedNotification"

@interface SendRegistrationDataAction : HTTPAction

+ (instancetype)actionSendRegistrationData:(NSString *)registrationData bookingId:(NSString *)bookingId;

@end
