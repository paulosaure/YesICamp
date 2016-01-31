//
//  InformationCampingCell.m
//  hotel
//
//  Created by Paul Lavoine on 25/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "InformationCampingCell.h"

@interface InformationCampingCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end

@implementation InformationCampingCell

#pragma mark - Utils

+ (UINib *)cellNib
{
    static UINib *cellNib;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cellNib = [UINib nibWithNibName:@"InformationCampingCell" bundle:nil];
    });

    return cellNib;
}

- (void)configureWithInformationsCamping:(Camping *)camping
{
    self.titleLabel.text = @"Title";
    self.descriptionLabel.text = @"Description";
}
@end
