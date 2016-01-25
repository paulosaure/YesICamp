//
//  PromotionCell.h
//  hotel
//
//  Created by Paul Lavoine on 20/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "Camping.h"

#define PROMO_CELL_IDENTIFIER         @"PromotionCellID"

@interface PromotionCell : UITableViewCell

+ (UINib *)cellNib;
- (void)configureWithHotel:(Camping *)hotel;

@end
