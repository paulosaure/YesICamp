//
//  OfferDetailCell.h
//  hotel
//
//  Created by Paul Lavoine on 25/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import <UIKit/UIKit.h>

#define OFFER_DETAIL_CELL_IDENTIFIER @"OfferDetailCellID"

@interface OfferDetailCell : UITableViewCell

+ (UINib *)cellNib;
- (void)configureWithInformationsOffer:(NSDictionary *)offerDetailInformation;

@end