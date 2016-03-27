//
//  GlobalConfiguration.m
//  Yes I Camp
//
//  Created by Paul Lavoine on 15/02/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "GlobalConfiguration.h"

@implementation GlobalConfiguration

+ (NSString *)cardTypeWithCardIOCreditCardType:(CardIOCreditCardType)cardType
{
    switch (cardType) {
            
        case CardIOCreditCardTypeAmbiguous :
            break;
        case CardIOCreditCardTypeAmex :
            break;
        case CardIOCreditCardTypeJCB :
            break;
        case CardIOCreditCardTypeVisa :
            return @"CB_VISA_MASTERCARD";
        case CardIOCreditCardTypeDiscover :
            break;
        case CardIOCreditCardTypeUnrecognized :
            break;
        case CardIOCreditCardTypeMastercard :
        default:
            return @"CB_VISA_MASTERCARD";
    }
    return @"CB_VISA_MASTERCARD";
}

+ (CampingCategory)categoryWithCategoryString:(NSString *)categoryString
{
    CampingCategory category;
    
    if ([categoryString isEqualToString:@"charme"]) {
        category = CampingCategoryCharme;
    } else if ([categoryString isEqualToString:@"fun"]) {
        category = CampingCategoryFun;
    } else if ([categoryString isEqualToString:@"luxe"]) {
        category = CampingCategoryLuxe;
    } else if ([categoryString isEqualToString:@"glamping"]) {
        category = CampingCategoryGlamping;
    } else if ([categoryString isEqualToString:@"terrain"]) {
        category = CampingCategoryEmpty;
    } else if ([categoryString isEqualToString:@"calme"]) {
        category = CampingCategoryCalme;
    } else if ([categoryString isEqualToString:@"basic"]) {
        category = CampingCategoryBasic;
    } else {
        NSLog(@"Error Category Inconnue : %@", categoryString);
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
        case CampingCategoryBasic :
            return [UIColor colorWithRed:133.0f/255.0f green:109.0f/255.0f blue:77.0f/255.0f alpha:1.0f];
        default:
            return [UIColor colorWithRed:31.0f/255.0f green:133.0f/255.0f blue:132.0f/255.0f alpha:1.0f];
            break;
    }
}

/*
 FUN              rouge  #DE2916
 CHARME      vert   #175732
 LUXE           Noir  #000000
 CALME         Bleu  #357AB7
 BASIC         Bistre  #856D4D
 GLAMPING   violet  #660099
 TERRAIN NU  Orange #ED7F10
 Unknown bleu aqua
 */

+ (UIColor *)colorWithString:(NSString *)categoryString
{
    return [self colorWithCategory:[self categoryWithCategoryString:categoryString]];
}

@end
