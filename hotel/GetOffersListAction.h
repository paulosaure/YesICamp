//
//  GetCampingsList.h
//  hotel
//
//  Created by Paul Lavoine on 26/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#define OffersListWithCampingNotification @"OffersListWithCampingNotification"
#define OffersListNotification @"OffersListNotification"

@interface GetOffersListAction : HTTPAction

+ (instancetype)action;

+ (instancetype)actionWithCity:(NSString *)city count:(NSInteger)count;

+ (instancetype)actionWithCampingId:(NSString *)campingId;

@end
