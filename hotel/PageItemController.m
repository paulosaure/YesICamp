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
@property (nonatomic, strong) NSString *imageUrl;
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
    
    if (!self.contentImageView.image)
    {
        NSString *urlImage = [NSString stringWithFormat:@"%@%@", MAIN_URL, self.imageUrl];
        self.contentImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlImage]]];
    }
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

#pragma mark - Content

- (void)configurePageWith:(OfferImage *)image index:(NSInteger)index
{
    self.imageUrl = image.imageUrl;
    self.itemIndex = index;
}


@end
