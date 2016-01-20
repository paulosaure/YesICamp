//
//  ResultCell.m
//  hotel
//
//  Created by Paul Lavoine on 20/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "ResultCell.h"


@interface ResultCell ()

@property (nonatomic, strong) IBOutlet UILabel *name;

@end


@implementation ResultCell

#pragma mark - Utils

+ (UINib *)cellNib
{
    static UINib *cellNib;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cellNib = [UINib nibWithNibName:@"ResultCell" bundle:nil];
    });
    
    return cellNib;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)configureWithHotel:(Hotel *)hotel
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
