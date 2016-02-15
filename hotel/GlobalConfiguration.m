//
//  GlobalConfiguration.m
//  Yes I Camp
//
//  Created by Paul Lavoine on 15/02/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "GlobalConfiguration.h"

@implementation GlobalConfiguration

+ (CampingCategory)categoryWithCategoryString:(NSString *)categoryString
{
    CampingCategory category;
    
    if ([categoryString isEqualToString:@"charme"]) {
        category = CampingCategoryCharme;
    } else if ([categoryString isEqualToString:@"fun"]) {
        category = CampingCategoryFun;
    } else if ([categoryString isEqualToString:@"lux"]) {
        category = CampingCategoryLuxe;
    } else if ([categoryString isEqualToString:@"confort"]) {
        category = CampingCategoryConfort;
    } else {
        NSLog(@"Error Category Inconnue");
    }
    
    return category;
}

+ (UIColor *)colorWithCategory:(CampingCategory)campingCategory
{
    switch (campingCategory) {
        case CampingCategoryCharme:
            return [UIColor greenColor];
        case CampingCategoryFun:
            return [UIColor redColor];
        case CampingCategoryLuxe:
            return [UIColor grayColor];
        case CampingCategoryConfort:
            return [UIColor blueColor];
        default:
            NSLog(@"Error enum category Inconnue, default color black");
            return [UIColor blackColor];
            break;
    }
}

+ (UIColor *)colorWithString:(NSString *)categoryString
{
    return [self colorWithCategory:[self categoryWithCategoryString:categoryString]];
}

@end
