//
//  HotDealCell.m
//  hotel
//
//  Created by Paul Lavoine on 30/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "HotDealCell.h"

@interface HotDealCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *separatorView;

@end

@implementation HotDealCell

#pragma mark - Utils

+ (UINib *)cellNib
{
    static UINib *cellNib;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cellNib = [UINib nibWithNibName:@"HotDealCell" bundle:nil];
    });
    
    return cellNib;
}

- (void)configureWithInformationsHotDeal:(HotDeal *)hotDeal
{
    self.titleLabel.text = @"Title";
    self.timeLabel.text = @"Description";
}

- (void)setSeparatorVisiblity:(BOOL)isLast
{
    self.separatorView.hidden = isLast;
}
@end
