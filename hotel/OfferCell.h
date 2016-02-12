//
//  OfferCell.h
//  hotel
//
//  Created by Paul Lavoine on 20/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#define OFFER_CELL_IDENTIFIER         @"OfferCellID"

@interface OfferCell : UITableViewCell

+ (UINib *)cellNib;
- (void)configureWithCamping:(Offer *)offer;

@end
