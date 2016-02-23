//
//  PageItemController.m
//  HandOff_ObjC
//
//  Created by Olga Dalton on 23/10/14.
//  Copyright (c) 2014 Olga Dalton. All rights reserved.
//

#import "PageItemController.h"

@interface PageItemController ()

// Data
@property (nonatomic, strong) UIImage *image;

// IBOutlets
@property (nonatomic, weak) IBOutlet UIImageView *contentImageView;

@end

@implementation PageItemController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.contentImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.view.backgroundColor = [UIColor clearColor];
    self.contentImageView.image = self.image;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

#pragma mark - Content

- (void)configurePageWith:(OfferImage *)offerImage index:(NSInteger)index
{
    if (!offerImage.image)
    {
        NSString *urlImage = [NSString stringWithFormat:@"%@%@", MAIN_URL, offerImage.imageUrl];
        offerImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlImage]]];
    }
    self.image = offerImage.image;
    self.itemIndex = index;
}


@end
