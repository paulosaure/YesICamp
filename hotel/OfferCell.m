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
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;

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

- (void)configureWithCamping:(Offer *)offer
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.nameLabel.text = offer.title;
    self.nameLabel.textColor = [UIColor whiteColor];
    
    self.priceLabel.text = [NSString stringWithFormat:@"%@€", offer.price];
    self.priceLabel.textColor = [UIColor greenColor];
    
    self.gradientImageView.image = [UIImage imageNamed:@"gradient"];
    self.gradientImageView.tintColor = GREEN_COLOR;
    
    self.categoryLabel.text = [@"fun" uppercaseString];
    self.categoryLabel.backgroundColor = [GlobalConfiguration colorWithString:@"fun"];
    
    self.contentStar.backgroundColor = [UIColor clearColor];
    [self configureStars:3];
    
    OfferImage *offerImage = [offer.images firstObject];
    if (!offerImage.image)
    {
        NSString *urlImage = [NSString stringWithFormat:@"%@%@", MAIN_URL, offerImage.imageUrl];
        offerImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlImage]]];
    }
    
    self.imageBackgroundView.image = offerImage.image;
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
