//
//  SendCardDetailAction.h
//  Yes I Camp
//
//  Created by Paul Lavoine on 28/02/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "HTTPAction.h"

#define didReceiveRegistrationDataSuccededNotification  @"didReceiveRegistrationDataSuccededNotification"
#define didReceiveRegistrationDataFailedNotification    @"didReceiveRegistrationDataFailedNotification"

@interface SendCardDetailAction : HTTPAction

+ (instancetype)actionSendCardDetail:(CardDetail *)cardDetail cardRegistration:(CardRegistration *)cardRegistration;

@end
