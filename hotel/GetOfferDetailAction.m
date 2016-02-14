//
//  GetOfferDetailAction.m
//  Yes I Camp
//
//  Created by Paul Lavoine on 13/02/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "GetOfferDetailAction.h"

#import "Offer.h"
#define OFFER_URL     @"offers/"

@implementation GetOfferDetailAction


#pragma mark - Constructor

+ (instancetype)action:(NSString *)uid
{
    NSString *urlSuffix = [NSString stringWithFormat:@"%@%@",OFFER_URL, uid];
    GetOfferDetailAction *action = [[GetOfferDetailAction alloc] initWithUrl:ACTION_URL(urlSuffix) service:WebServiceFetOfferDetail];
    
    return action;
}

#pragma mark - Manage Answer

- (void)handleDownloadedData:(NSString *)obj
{
    [super handleDownloadedData:obj];
    NSData *data = [obj dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *offerJson = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    Offer *offerReceive = [[Offer alloc] initWithDictionnary:offerJson];
    
    [NOTIFICATION_CENTER postNotificationName:OfferDetailtNotification object:offerReceive];
}

@end
