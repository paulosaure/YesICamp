//
//  OfferCell.m
//  hotel
//
//  Created by Paul Lavoine on 20/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "OfferCell.h"
#import "OfferImage.h"
#import "CategoryLabelWithPadding.h"

@interface OfferCell ()

@property (nonatomic, weak) IBOutlet UIImageView *imageBackgroundView;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *oldPriceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *gradientImageView;
@property (weak, nonatomic) IBOutlet CategoryLabelWithPadding *categoryLabel;

@property (weak, nonatomic) IBOutlet UIView *contentStar;
@property (weak, nonatomic) IBOutlet UIImageView *firstStar;
@property (weak, nonatomic) IBOutlet UIImageView *secondStar;
@property (weak, nonatomic) IBOutlet UIImageView *thirdStar;
@property (weak, nonatomic) IBOutlet UIImageView *fourthStar;
@property (weak, nonatomic) IBOutlet UIImageView *fiveStar;

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

- (void)configureWithOffer:(Offer *)offer
{
    [self globalConfiguration];
    
    // Name
    self.nameLabel.text = offer.title;
    
    // Percentage
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",offer.oldPrice, LOCALIZED_STRING(@"globals.unity")]];
    [attributeString addAttribute:NSStrikethroughStyleAttributeName
                            value:@2
                            range:NSMakeRange(0, [attributeString length])];
    self.oldPriceLabel.textColor = [UIColor whiteColor];
    self.oldPriceLabel.attributedText = attributeString;
    
    // Price
    self.priceLabel.text = [NSString stringWithFormat:@"%@%@", offer.price, LOCALIZED_STRING(@"globals.unity")];
    
    // Category
    self.categoryLabel.text = [offer.category uppercaseString];
    self.categoryLabel.backgroundColor = [GlobalConfiguration colorWithString:offer.category];
    
    OfferImage *offerImage = [offer.images firstObject];
    UIImage *image = offerImage.image;
    if (!offerImage.image)
    {
        if (!offerImage.imageUrl)
        {
            image = [UIImage imageNamed:@"no-photo"];
        }
        else
        {
            NSString *urlImage = [NSString stringWithFormat:@"%@%@", MAIN_URL, offerImage.imageUrl];
            offerImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlImage]]];
            image = offerImage.image;
        }
    }
    
    self.imageBackgroundView.image = image;
}

- (void)configureWithCamping:(Camping *)camping
{
    [self globalConfiguration];
    
    // Name
    self.nameLabel.text = camping.title;
    self.nameLabel.textColor = [UIColor whiteColor];
    
    // Percentage
    self.oldPriceLabel.hidden = YES;
    
    // Price
    self.priceLabel.text = [NSString stringWithFormat:@"%.f - %.f%@", [camping minPriceWithCamping], [camping maxPriceWithCamping], LOCALIZED_STRING(@"globals.unity")];
    
    // Category
    
    CampingImage *campingImage = [camping.images firstObject];
    UIImage *image = campingImage.image;
    if (!campingImage.image)
    {
        if (!campingImage.imageUrl)
        {
            image = [UIImage imageNamed:@"no-photo"];
        }
        else
        {
            NSString *urlImage = [NSString stringWithFormat:@"%@%@", MAIN_URL, campingImage.imageUrl];
            campingImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlImage]]];
            image = campingImage.image;
        }
    }

    self.imageBackgroundView.image = image;
}

- (void)globalConfiguration
{
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.nameLabel.textColor = [UIColor whiteColor];
    self.priceLabel.textColor = [UIColor greenColor];
    
    self.gradientImageView.image = [UIImage imageNamed:@"gradient"];
    self.gradientImageView.tintColor = BLACK_COLOR;
    
    self.contentStar.hidden = YES;
    self.contentStar.backgroundColor = [UIColor clearColor];
    
}

- (void)configureStars:(NSInteger)starNumber
{
    NSArray *stars = @[self.firstStar, self.secondStar, self.thirdStar, self.fourthStar, self.fiveStar];
    for (int i = 0; i < starNumber; i++)
    {
        UIImageView *star = (UIImageView *)stars[i];
        star.tintColor = [UIColor yellowColor];
        star.image = [UIImage imageNamed:@"star"];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
