//
//  HotDealCell.h
//  hotel
//
//  Created by Paul Lavoine on 30/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotDeal.h"

#define HOT_DEAL_CELL_ID @"HotDealCellID"

@interface HotDealCell : UITableViewCell

+ (UINib *)cellNib;
- (void)configureWithInformationsHotDeal:(HotDeal *)hotDeal;
- (void)setSeparatorVisiblity:(BOOL)isLast;

@end
