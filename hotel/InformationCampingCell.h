//
//  InformationCell.h
//  hotel
//
//  Created by Paul Lavoine on 25/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Camping.h"
#define INFORMATION_CELL_IDENTIFIER @"InformationCellID"

@interface InformationCampingCell : UITableViewCell

+ (UINib *)cellNib;
- (void)configureWithInformationsCamping:(Camping *)camping;

@end