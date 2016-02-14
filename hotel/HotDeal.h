//
//  HotDeal.h
//  hotel
//
//  Created by Paul Lavoine on 30/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotDeal : NSObject

- (NSDate *)remainingTimeWithRequestDate;


@property (nonatomic, strong) NSNumber *uid;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) NSNumber *percent;
@property (nonatomic, strong) NSDate *begin;
@property (nonatomic, strong) NSDate *end;
@property (nonatomic, strong) NSNumber *productID;
@property (nonatomic, strong) NSNumber *campingID;
@property (nonatomic, strong) NSNumber *places;
@property (nonatomic, strong) NSNumber *active;
@property (nonatomic, strong) NSString *creation;
@property (nonatomic, strong) NSString *update;
@property (nonatomic, strong) NSArray *mainTextInfos;
@property (nonatomic, strong) NSArray *images;

@end
