//
//  OfferDetailCell.m
//  hotel
//
//  Created by Paul Lavoine on 25/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "OfferDetailCell.h"
#import "Offer.h"

@interface OfferDetailCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end

@implementation OfferDetailCell

#pragma mark - Utils

+ (UINib *)cellNib
{
    static UINib *cellNib;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cellNib = [UINib nibWithNibName:@"OfferDetailCell" bundle:nil];
    });

    return cellNib;
}

- (void)configureWithInformationsOffer:(NSDictionary *)offerDetailInformation
{
    self.titleLabel.text = [[offerDetailInformation allKeys] firstObject];
    self.titleLabel.textColor = BLUE_COLOR;
    self.descriptionLabel.text = [[offerDetailInformation allValues] firstObject];
}
@end
