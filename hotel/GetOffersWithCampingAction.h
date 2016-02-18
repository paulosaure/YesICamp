//
//  GetOffersWithCampingAction.h
//  Yes I Camp
//
//  Created by Paul Lavoine on 18/02/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#define OffersListWithCampingNotification @"OffersListWithCampingNotification"

@interface GetOffersWithCampingAction : HTTPAction

+ (instancetype)actionWithCampingId:(NSString *)campingId;

@end
