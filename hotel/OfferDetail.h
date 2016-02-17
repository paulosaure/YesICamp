//
//  OfferDetail.h
//  hotel
//
//  Created by Paul Lavoine on 20/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#define OfferDetailViewControllerID @"OfferDetailViewControllerID"

@interface OfferDetail : UIViewController

- (instancetype)init;

@property (nonatomic, strong) Offer *offer;

@end
