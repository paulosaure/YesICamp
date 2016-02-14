//
//  GetCampingsList.h
//  hotel
//
//  Created by Paul Lavoine on 26/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#define OffersListNotification @"OffersListNotification"

@interface GetOffersListAction : HTTPAction

+ (instancetype)action;

+ (instancetype)actionWithCity:(NSString *)city;

@end
