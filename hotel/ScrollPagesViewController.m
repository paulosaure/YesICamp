//
//  ScrollPagesViewController.m
//  hotel
//
//  Created by Paul Lavoine on 25/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "ScrollPagesViewController.h"
#import "ScrollPager.h"

@interface ScrollPagesViewController () <ScrollPagerDelegate>

@property (nonatomic, weak) IBOutlet ScrollPager *scrollPager;
@property (nonatomic, weak) IBOutlet ScrollPager *secondScrollPager;

@end


@implementation ScrollPagesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UILabel *firstView = [[UILabel alloc] init];
    firstView.backgroundColor = [UIColor whiteColor];
    firstView.text = @"first View";
    firstView.textAlignment = NSTextAlignmentCenter;
    
    UILabel *secondView = [[UILabel alloc] init];
    secondView.backgroundColor = [UIColor greenColor];
    secondView.text = @"first View";
    secondView.textAlignment = NSTextAlignmentCenter;
    
    UILabel *thirdView = [[UILabel alloc] init];
    thirdView.backgroundColor = [UIColor blueColor];
    thirdView.text = @"first View";
    thirdView.textAlignment = NSTextAlignmentCenter;
    
    UILabel *fourthView = [[UILabel alloc] init];
    fourthView.backgroundColor = [UIColor redColor];
    fourthView.text = @"first View";
    fourthView.textAlignment = NSTextAlignmentCenter;
    
    self.scrollPager.delegate = self;
    [self.scrollPager addSegmentsWithViews:@[
                                             firstView,
                                             secondView,
                                             thirdView,
                                             fourthView
                                             ]];
    
    [self.scrollPager addSegmentsWithTitles:@[
                                              @"firstView",
                                              @"secondView",
                                              @"thirdView",
                                              @"fourthView"
                                              ]];
    
    [self.secondScrollPager addSegmentsWithImages:@[]];
}

- (void)scrollPager:(ScrollPager *)scrollpager changedIndex:(NSInteger)changedIndex
{
    NSLog(@"Change page %ld", (long)changedIndex);
}

@end
