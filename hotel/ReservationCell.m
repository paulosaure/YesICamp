//
//  ReservationCell.m
//  Yes I Camp
//
//  Created by Paul Lavoine on 22/02/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "ReservationCell.h"

@interface ReservationCell ()

@property (nonatomic, weak) IBOutlet UILabel *reservationNumberLabel;

@property (nonatomic, weak) IBOutlet UIView *contentCampingInformationView;
@property (nonatomic, weak) IBOutlet UILabel *dateFromLabel;
@property (nonatomic, weak) IBOutlet UILabel *dateToLabel;
@property (nonatomic, weak) IBOutlet UILabel *campingNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *campingAddressLabel;
@property (nonatomic, weak) IBOutlet UILabel *campingTelAddress;

@property (nonatomic, weak) IBOutlet UILabel *price;

@property (nonatomic, weak) IBOutlet UIView *verticalSeparatorView;
@property (nonatomic, weak) IBOutlet UIView *horizontalSeparatorView;

@end

@implementation ReservationCell

#pragma mark - Utils

+ (UINib *)cellNib
{
    static UINib *cellNib;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cellNib = [UINib nibWithNibName:@"ReservationCell" bundle:nil];
    });
    
    return cellNib;
}

- (void)configureWithReservation:(Reservation *)reservation isLast:(BOOL)isLast
{
    self.reservationNumberLabel.textColor = [UIColor whiteColor];
    self.dateToLabel.textColor = [UIColor whiteColor];
    self.dateFromLabel.textColor = [UIColor whiteColor];
    self.campingTelAddress.textColor = [UIColor whiteColor];
    self.campingNameLabel.textColor = [UIColor whiteColor];
    self.campingAddressLabel.textColor = [UIColor whiteColor];
    self.price.textColor = [UIColor whiteColor];
    
    self.reservationNumberLabel.text = @"N°1234567";
    self.dateFromLabel.text = @"23/12/2015";
    self.dateToLabel.text = @"23/12/2015";
    
    self.campingAddressLabel.text = @"5 rue des mimomza Nice 06560";
    self.campingNameLabel.text = @"Blue camping";
    self.campingTelAddress.text = @"0650789797";
    
    self.price.text = @"40€";
    self.verticalSeparatorView.backgroundColor = GREEN_COLOR;
    self.horizontalSeparatorView.backgroundColor = GREEN_COLOR;
    
    self.contentCampingInformationView.backgroundColor = [UIColor clearColor];
    self.contentCampingInformationView.layer.borderColor = GREEN_COLOR.CGColor;
    self.contentCampingInformationView.layer.borderWidth = 1.0f;
    self.contentCampingInformationView.layer.cornerRadius = 5.0f;
    
    self.backgroundColor = [UIColor clearColor];
    self.horizontalSeparatorView.hidden = isLast;
}

@end
