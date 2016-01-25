//
//  ResultCell.h
//  hotel
//
//  Created by Paul Lavoine on 20/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "Camping.h"

#define RESULT_CELL_IDENTIFIER         @"ResultCellID"

@interface ResultCell : UITableViewCell

+ (UINib *)cellNib;
- (void)configureWithHotel:(Camping *)hotel;

@end
