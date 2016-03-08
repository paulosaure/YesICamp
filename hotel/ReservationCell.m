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
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;
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
    self.dateLabel.textColor = [UIColor whiteColor];
    self.campingTelAddress.textColor = [UIColor whiteColor];
    self.campingNameLabel.textColor = [UIColor whiteColor];
    self.campingAddressLabel.textColor = [UIColor whiteColor];
    self.price.textColor = [UIColor whiteColor];
    
    NSDictionary *dateAttributes = @{
                                     NSFontAttributeName:[UIFont boldSystemFontOfSize:22.0f],
                                     NSForegroundColorAttributeName:GREEN_COLOR
                                     };
    
    NSAttributedString *dateFrom = [[NSAttributedString alloc] initWithString:reservation.dateFrom
                                                                   attributes:dateAttributes];
    NSAttributedString *dateTo = [[NSAttributedString alloc] initWithString:reservation.dateTo
                                                                 attributes:dateAttributes];
    self.dateLabel.attributedText = [NSAttributedString attributedStringWithFormat:LOCALIZED_STRING(@"reservation.date.title"), dateFrom, dateTo];
    
    
    NSDictionary *reservationAttributes = @{
                                            NSFontAttributeName:[UIFont boldSystemFontOfSize:20.0f],
                                            NSForegroundColorAttributeName:[UIColor whiteColor]
                                            };
    NSAttributedString *reservationNumber = [[NSAttributedString alloc] initWithString:[reservation.offerId stringValue]
                                                                            attributes:reservationAttributes];
    self.reservationNumberLabel.attributedText = [NSAttributedString attributedStringWithFormat:LOCALIZED_STRING(@"reservation.rervation_number.title"), reservationNumber];
    
    self.campingAddressLabel.text = reservation.addressCamping;
    self.campingNameLabel.text = reservation.nameCamping;
    self.campingTelAddress.text = reservation.phoneCamping;
    
    self.price.text = [NSString stringWithFormat:@"%@%@", reservation.price, LOCALIZED_STRING(@"globals.unity")];
    self.price.textColor = GREEN_COLOR;
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
