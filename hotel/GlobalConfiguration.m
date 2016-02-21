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
    } else if ([categoryString isEqualToString:@"glamping"]) {
        category = CampingCategoryGlamping;
    } else if ([categoryString isEqualToString:@"terrainNu"]) {
        category = CampingCategoryEmpty;
    } else if ([categoryString isEqualToString:@"calme"]) {
        category = CampingCategoryCalme;
    } else {
        NSLog(@"Error Category Inconnue");
    }
    
    return category;
}

+ (UIColor *)colorWithCategory:(CampingCategory)campingCategory
{
    switch (campingCategory) {
        case CampingCategoryCharme:
            return [UIColor colorWithRed:23.0f/255.0f green:87.0f/255.0f blue:50.0f/255.0f alpha:1.0f];
        case CampingCategoryFun:
            return [UIColor colorWithRed:222/255.0f green:41.0f/255.0f blue:22.0f/255.0f alpha:1.0f];
        case CampingCategoryLuxe:
            return [UIColor blackColor];
        case CampingCategoryCalme:
            return [UIColor colorWithRed:53.0f/255.0f green:122.0f/255.0f blue:183.0f/255.0f alpha:1.0f];
        case CampingCategoryGlamping:
            return [UIColor colorWithRed:102.0f/255.0f green:0.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
        case CampingCategoryEmpty:
            return [UIColor colorWithRed:237.0f/255.0f green:127.0f/255.0f blue:16.0f/255.0f alpha:1.0f];
        default:
            NSLog(@"Error enum category Inconnue, default color black");
            return [UIColor yellowColor];
            break;
    }
}

+ (UIColor *)colorWithString:(NSString *)categoryString
{
    return [self colorWithCategory:[self categoryWithCategoryString:categoryString]];
}

@end
