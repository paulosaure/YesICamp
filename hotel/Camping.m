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
        self.uid = [dic objectForKeyOrNil:@"camping_id"];
        self.title = [dic objectForKeyOrNil:@"camping_title"];
        self.longitude = [dic objectForKeyOrNil:@"longitude"];
        self.latitude = [dic objectForKeyOrNil:@"latitude"];
        self.offers = [self constructOffers:[dic objectForKeyOrNil:@"offers"]];
        self.images = [self constructOfferImages:[dic objectForKeyOrNil:@"pictures"]];
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

- (CGFloat)minPriceWithCamping
{
    CGFloat minPrice = [((Offer *)[self.offers firstObject]).price floatValue];
    for (Offer *offer in self.offers)
    {
        if ([offer.price floatValue] <= minPrice)
        {
            minPrice = [offer.price floatValue];
        }
    }
    return minPrice;
}

- (CGFloat)maxPriceWithCamping
{
    CGFloat maxPrice = [((Offer *)[self.offers firstObject]).price floatValue];
    for (Offer *offer in self.offers)
    {
        if ([offer.price floatValue] >= maxPrice)
        {
            maxPrice = [offer.price floatValue];
        }
    }
    return maxPrice;
}

- (NSArray *)constructOfferImages:(NSArray *)arrayJson
{
    NSMutableArray *images = [NSMutableArray array];
    for (NSDictionary *image in arrayJson)
    {
        CampingImage *campingImage = [[CampingImage alloc] init];
        campingImage.uid = [image objectForKeyOrNil:@"id"];
        campingImage.imageUrl = [image objectForKeyOrNil:@"url"];
        [images addObject:campingImage];
    }
    
    return images;
}

@end
