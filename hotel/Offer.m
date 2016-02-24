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
        self.uid = [dic objectForKeyOrNil:@"id"];
        self.title = [dic objectForKeyOrNil:@"title"];
        self.oldPrice = [dic objectForKeyOrNil:@"real_price"];
        self.price = [dic objectForKeyOrNil:@"price"];
        self.percent = [dic objectForKeyOrNil:@"percent"];
        self.begin = [dic objectForKeyOrNil:@"begin"];
        self.end = [dic objectForKeyOrNil:@"end"];
        self.category = [dic objectForKeyOrNil:@"category"];
        self.productID = [dic objectForKeyOrNil:@"product_id"];
        self.campingID = [dic objectForKeyOrNil:@"camping_id"];
        self.creation = [dic objectForKeyOrNil:@"created_at"];
        self.update = [dic objectForKeyOrNil:@"updated_at"];
        self.places =  [dic objectForKeyOrNil:@"places"];
        self.active = [dic objectForKeyOrNil:@"active"];
        self.mainTextInfos = [self constructMainTextInfos:[dic objectForKeyOrNil:@"main_text_infos"]];
        self.images = [self constructOfferImages:[dic objectForKeyOrNil:@"pictures"]];
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
        offerImage.uid = [image objectForKeyOrNil:@"id"];
        offerImage.imageUrl = [image objectForKeyOrNil:@"url"];
        [images addObject:offerImage];
    }
    
    return images;
}

@end
