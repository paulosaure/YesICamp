//
//  GetHotsDealsListAction.h
//  Yes I Camp
//
//  Created by Paul Lavoine on 02/02/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "ParamRequestHotDeal.h"

#define HotsDealsListNotification @"HotsDealsListNotification"

@interface GetHotsDealsListAction : HTTPAction

+ (instancetype)action:(ParamRequestHotDeal *)params;

@end
