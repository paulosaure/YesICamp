//
//  Offer.m
//  hotel
//
//  Created by Paul Lavoine on 24/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "Offer.h"
#import "OfferImage.h"

@interface Offer ()

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
        self.creation = [dic objectForKey:@"created_at"];
        self.update = [dic objectForKey:@"updated_at"];
        self.places =  [dic objectForKey:@"places"];
        self.active = [dic objectForKey:@"active"];
        self.mainTextInfos = [self constructMainTextInfos:[dic objectForKey:@"main_text_infos"]];
        self.images = [self constructOfferImages:[dic objectForKey:@"pictures"]];
    }
    
    return self;
}

- (NSArray *)constructMainTextInfos:(NSDictionary *)arrayJson
{
    NSMutableArray *informations = [NSMutableArray array];
    for (NSString *key in arrayJson)
    {
        NSDictionary *value = @{key : [arrayJson objectForKey:key]};
        [informations addObject:value];
    }
    
    return informations;
}

- (NSArray *)constructOfferImages:(NSArray *)arrayJson
{
    NSMutableArray *images = [NSMutableArray array];
    for (NSDictionary *image in arrayJson)
    {
        OfferImage *offerImage = [[OfferImage alloc] init];
        offerImage.uid = [image objectForKey:@"id"];
        offerImage.imageUrl = [image objectForKey:@"url"];
        [images addObject:offerImage];
    }
    
    return images;
}

@end
