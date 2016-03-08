//
//  NoReservationCell.m
//  Yes I Camp
//
//  Created by Paul Lavoine on 08/03/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "NoReservationCell.h"

@interface NoReservationCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation NoReservationCell

#pragma mark - Utils

+ (UINib *)cellNib
{
    static UINib *cellNib;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cellNib = [UINib nibWithNibName:@"NoReservationCell" bundle:nil];
    });
    
    return cellNib;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.titleLabel.text = LOCALIZED_STRING(@"noreservation.no_reservation.title");
    self.titleLabel.textColor = GREEN_COLOR;
}

@end
