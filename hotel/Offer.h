//
//  Offer.h
//  hotel
//
//  Created by Paul Lavoine on 24/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#define MAIN_INFO_CATEGORY_KEY @"category"
#define MAIN_INFO_DESCRIPTION_KEY @"description"
#define MAIN_INFO_SERVICES_KEY @"services"
#define MAIN_INFO_DETAILS_KEY @"details"

@interface Offer : NSObject

- (instancetype)initWithDictionnary:(NSDictionary *)dic;

@property (nonatomic, strong) NSNumber *uid;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSNumber *oldPrice;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) NSNumber *percent;
@property (nonatomic, strong) NSString *begin;
@property (nonatomic, strong) NSString *end;
@property (nonatomic, strong) NSNumber *productID;
@property (nonatomic, strong) NSNumber *campingID;
@property (nonatomic, strong) NSNumber *places;
@property (nonatomic, strong) NSNumber *active;
@property (nonatomic, strong) NSString *creation;
@property (nonatomic, strong) NSString *update;
@property (nonatomic, strong) NSArray *mainTextInfos;
@property (nonatomic, strong) NSArray *images;

@end
