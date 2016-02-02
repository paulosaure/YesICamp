//
//  Offer.m
//  hotel
//
//  Created by Paul Lavoine on 24/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "Offer.h"

@interface Offer ()

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


@implementation Offer

- (instancetype)initWithDictionnary:(NSDictionary *)dic;
{
    if (self = [super init])
    {
        self.uid = [dic objectForKey:@"id"];
        self.title = [dic objectForKey:@"title"];
        self.price = [dic objectForKey:@"price"];
        self.percent = [dic objectForKey:@"percent"];
        self.begin = [dic objectForKey:@"begin"];
        self.end = [dic objectForKey:@"end"];
        self.productID = [dic objectForKey:@"product_id"];
        self.campingID = [dic objectForKey:@"camping_id"];
        self.category = [dic objectForKey:@"category"];
        self.offerDescription = [dic objectForKey:@"description"];
        self.services =[ dic objectForKey:@"services"];
        self.details = [dic objectForKey:@"details"];
        self.places =[ dic objectForKey:@"places"];
        self.active = [dic objectForKey:@"active"];
    }
    
    return self;
}

@end
