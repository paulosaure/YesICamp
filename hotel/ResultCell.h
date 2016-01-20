//
//  ResultCell.h
//  hotel
//
//  Created by Paul Lavoine on 20/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Hotel.h"

#define RESULT_CELL_IDENTIFIER         @"ResultCellID"

@interface ResultCell : UITableViewCell

+ (UINib *)cellNib;
- (void)configureWithHotel:(Hotel *)hotel;

@end
