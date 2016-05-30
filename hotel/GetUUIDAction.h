//
//  GetUUIDAction.h
//  Yes I Camp
//
//  Created by Paul Lavoine on 29/05/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#define GetUUIDNotification @"ReservationListNotification"

@interface GetUUIDAction : HTTPAction

+ (instancetype)action:(NSString *)token name:(NSString *)name;
+ (instancetype)actionUnscribe:(NSString *)token;

@end
