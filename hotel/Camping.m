//
//  Camping.m
//  Camping
//
//  Created by Paul Lavoine on 20/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "Camping.h"

@interface Camping ()


@end

@implementation Camping

- (instancetype)initWithDictionnary:(NSDictionary *)dic;
{
    if (self = [super init])
    {
        self.uid = [dic objectForKey:@"camping_id"];
        self.title = [dic objectForKey:@"camping_title"];
        self.longitude = [dic objectForKey:@"longitude"];
        self.latitude = [dic objectForKey:@"latitude"];
        self.offers = [self constructOffers:[dic objectForKey:@"offers"]];
    }
    
    return self;
}

- (NSArray *)constructOffers:(NSArray *)offers
{
    NSMutableArray *constructedOffers = [NSMutableArray array];
    for (NSDictionary *offer in offers)
    {
        Offer *constructedOffer = [[Offer alloc] initWithDictionnary:offer];
        [constructedOffers addObject:constructedOffer];
    }
    
    return constructedOffers;
}

@end
