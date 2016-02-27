//
//  MakeReservationAction.h
//  Yes I Camp
//
//  Created by Paul Lavoine on 21/02/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#define didBookReservationSuccededNotification @"didBookReservationSuccededNotification"
#define didBookReservationFailedNotification @"didBookReservationFailedNotification"

@interface BookReservationAction : HTTPAction

+ (instancetype)actionWithOfferId:(NSString *)offerId dateBegin:(NSString *)dateBegin dateEnd:(NSString *)dateEnd;

@end