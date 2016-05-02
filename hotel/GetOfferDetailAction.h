//
//  GetOfferDetailAction.h
//  Yes I Camp
//
//  Created by Paul Lavoine on 13/02/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#define OfferDetailNotification @"OfferDetailNotification"
#define PushOfferDetailViewNotificiation @"PushOfferDetailViewNotificiation"

@interface GetOfferDetailAction : HTTPAction

+ (instancetype)action:(NSString *)uid;

@end
