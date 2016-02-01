//
//  PromotionCell.m
//  hotel
//
//  Created by Paul Lavoine on 20/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "PromotionCell.h"


@interface PromotionCell ()

@property (nonatomic, weak) IBOutlet UIImageView *imageBackgroundView;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *gradientImageView;
@end


@implementation PromotionCell

#pragma mark - Utils

+ (UINib *)cellNib
{
    static UINib *cellNib;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cellNib = [UINib nibWithNibName:@"PromotionCell" bundle:nil];
    });
    
    return cellNib;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
}

- (void)configureWithCamping:(Camping *)camping
{
//    self.imageView.image = [camping.images firstObject];
    self.nameLabel.text = @"Camping Cézanne";
    self.nameLabel.textColor = [UIColor whiteColor];
    
    self.priceLabel.text = @"70€";
    self.priceLabel.textColor = [UIColor whiteColor];
    self.imageBackgroundView.image = [UIImage imageNamed:@"campingImage"];
    
    self.gradientImageView.image = [UIImage imageNamed:@"gradient"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
