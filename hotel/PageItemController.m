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
@property (nonatomic, strong) NSString *imageName;

// IBOutlets
@property (nonatomic, weak) IBOutlet UIImageView *contentImageView;

@end

@implementation PageItemController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.contentImageView.image = [UIImage imageNamed:self.imageName];
    self.contentImageView.contentMode = UIViewContentModeScaleAspectFill;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

#pragma mark - Content

- (void)configurePageWith:(NSString *)name index:(NSInteger)index
{
    self.imageName = name;
    self.itemIndex = index;
}


@end
