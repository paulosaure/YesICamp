//
//  OfferCell.m
//  hotel
//
//  Created by Paul Lavoine on 20/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "OfferCell.h"
#import "OfferImage.h"

@interface OfferCell ()

@property (nonatomic, weak) IBOutlet UIImageView *imageBackgroundView;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *gradientImageView;
@end


@implementation OfferCell

#pragma mark - Utils

+ (UINib *)cellNib
{
    static UINib *cellNib;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cellNib = [UINib nibWithNibName:@"OfferCell" bundle:nil];
    });
    
    return cellNib;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.imageBackgroundView.image = nil;
    self.nameLabel.text = nil;
    self.priceLabel.text = nil;
}

- (void)configureWithCamping:(Offer *)offer
{
    self.nameLabel.text = offer.title;
    self.nameLabel.textColor = [UIColor whiteColor];
    
    self.priceLabel.text = [NSString stringWithFormat:@"%@€", offer.price];
    self.priceLabel.textColor = [UIColor whiteColor];
    
    self.gradientImageView.image = [UIImage imageNamed:@"gradient"];
    self.gradientImageView.tintColor = GREEN_COLOR;
    
    OfferImage *offerImage = [offer.images firstObject];
    if (!offerImage.image)
    {
        NSString *urlImage = [NSString stringWithFormat:@"%@%@", MAIN_URL, offerImage.imageUrl];
        offerImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlImage]]];
    }
    
    self.imageBackgroundView.image = offerImage.image;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
