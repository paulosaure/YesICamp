//
//  Camping.h
//  Camping
//
//  Created by Paul Lavoine on 20/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, Category) {
    CategoryFun,
    CategoryCharme,
    CategoryLuxe,
    CategoryBasic,
    CategoryGlamping,
    CategoryPitchTent
};

@interface Camping : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSNumber *phoneNumber;
@property (nonatomic, strong) NSNumber *zipCode;
@property (nonatomic, strong) NSNumber *longitude;
@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSArray *informations;

@end
