//
//  Offer.h
//  hotel
//
//  Created by Paul Lavoine on 24/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

@interface Offer : NSObject

- (instancetype)initWithDictionnary:(NSDictionary *)dic;

@property (nonatomic, strong) NSNumber *uid;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) NSNumber *percent;
@property (nonatomic, strong) NSDate *begin;
@property (nonatomic, strong) NSDate *end;
@property (nonatomic, strong) NSNumber *productID;
@property (nonatomic, strong) NSNumber *campingID;
@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSString *offerDescription;
@property (nonatomic, strong) NSString *services;
@property (nonatomic, strong) NSString *details;
@property (nonatomic, strong) NSNumber *places;
@property (nonatomic, strong) NSNumber *active;

@end
