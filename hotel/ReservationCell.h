//
//  ReservationCell.h
//  Yes I Camp
//
//  Created by Paul Lavoine on 22/02/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#define RESERVATION_CELL_IDENTIFIER @"ReservationCellID"

@interface ReservationCell : UITableViewCell

+ (UINib *)cellNib;
- (void)configureWithReservation:(Reservation *)reservation isLast:(BOOL)isLast;

@end
