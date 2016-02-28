//
//  GlobalConfiguration.h
//  Yes I Camp
//
//  Created by Paul Lavoine on 15/02/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//
#import "Camping.h"
#import <CardIO.h>

@interface GlobalConfiguration : NSObject

+ (CampingCategory)categoryWithCategoryString:(NSString *)categoryString;
+ (UIColor *)colorWithCategory:(CampingCategory)category;
+ (UIColor *)colorWithString:(NSString *)categoryString;

+ (NSString *)cardTypeWithCardIOCreditCardType:(CardIOCreditCardType)cardType;

@end
