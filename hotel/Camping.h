//
//  Camping.h
//  Camping
//
//  Created by Paul Lavoine on 20/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "CampingImage.h"

typedef NS_ENUM(NSUInteger, CampingCategory) {
    CampingCategoryFun,
    CampingCategoryCharme,
    CampingCategoryLuxe,
    CampingCategoryBasic,
    CampingCategoryGlamping,
    CampingCategoryCalme,
    CampingCategoryEmpty
};

@class Offer;

@interface Camping : NSObject

- (instancetype)initWithDictionnary:(NSDictionary *)dic;

- (Offer *)offerMinPriceWithCamping;
- (CGFloat)minPriceWithCamping;
- (CGFloat)maxPriceWithCamping;

// HotDeal information
@property (nonatomic, strong) NSNumber *uid;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSNumber *longitude;
@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic, strong) NSArray *offers;

// Personnal informations
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSNumber *phoneNumber;
@property (nonatomic, strong) NSNumber *zipCode;
@property (nonatomic, strong) NSString *imageCoverUrl;
@property (nonatomic, strong) UIImage *imageCover;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSArray *informations;

@end
