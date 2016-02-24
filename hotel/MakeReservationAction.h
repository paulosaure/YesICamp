//
//  MakeReservationAction.h
//  Yes I Camp
//
//  Created by Paul Lavoine on 21/02/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#define didReservationNotification @"DidReservationNotification"

@interface MakeReservationAction : HTTPAction

+ (instancetype)actionWithOfferId:(NSString *)offerId dateBegin:(NSString *)dateBegin dateEnd:(NSString *)dateEnd redactedCardNumber:(NSString *)redactedCardNumber expiryMonth:(unsigned long)expiryMonth expiryYear:(unsigned long)expiryYear cvv:(NSString *)cvv;

@end