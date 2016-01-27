//
//  ScrollPagesViewController.m
//  hotel
//
//  Created by Paul Lavoine on 25/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "ScrollPagesViewController.h"
#import "LPTitleView.h"

#import "HomePageViewController.h"
#import "HotDealViewController.h"
#import "PromotionsViewController.h"
#import "InformationViewController.h"

#define CONTENT_PICTO_HEIGHT 47

@interface ScrollPagesViewController () <LPViewPagerDataSource, LPViewPagerDelegate, LPTitleViewDelegate>

@property (nonatomic, strong) HomePageViewController *homePageViewController;
@property (nonatomic, strong) HotDealViewController *hotDealViewController;
@property (nonatomic, strong) PromotionsViewController *promotionsViewController;
@property (nonatomic, strong) InformationViewController *informationViewController;

@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) LPTitleView *pagingTitleView;
@property (nonatomic, strong) UIStoryboard *myStoryboard;

@end


@implementation ScrollPagesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dataSource = self;
    self.delegate = self;
    
    // Do not auto load data
    self.manualLoadData = YES;
    self.currentIndex = 0;
    self.navigationItem.titleView = self.pagingTitleView;
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.translucent = NO;
    self.myStoryboard = [UIStoryboard storyboardWithName:MAIN_STORYBOARD bundle:nil];
    [self reloadData];
}

#pragma mark - LPViewPagerDataSource
- (NSUInteger)numberOfTabsForViewPager:(LPViewPagerController *)viewPager
{
    return 3;
}

- (UIViewController *)viewPager:(LPViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index
{
    if (index == 0) {
        return [self createVc1];
    } else if (index == 1) {
        return [self createVc2];
    } else {
        return [self createVc3];
    }
}

#pragma mark 🎈LPViewPagerDelegate
- (void)viewPager:(LPViewPagerController *)viewPager didChangeTabToIndex:(NSUInteger)index
{
    self.currentIndex = index;
}

- (LPTitleView *)pagingTitleView
{
    if (!_pagingTitleView) {
        self.pagingTitleView          = [[LPTitleView alloc] init];
        
        self.pagingTitleView.backgroundColor = [UIColor blackColor];

        self.pagingTitleView.frame    = CGRectMake(0, 0, 0, CONTENT_PICTO_HEIGHT);
        self.pagingTitleView.font     = [UIFont systemFontOfSize:15];
        self.pagingTitleView.indicatorColor = [UIColor purpleColor];
        
        NSArray *imageArray           = @[@"profil", @"deal", @"compte"];
        NSArray *titleArray           = @[@"Title1", @"Title2", @"Title3"];
        CGRect ptRect                 = self.pagingTitleView.frame;
        ptRect.size.width             = self.view.frame.size.width;
        self.pagingTitleView.frame    = ptRect;
        [self.pagingTitleView addTitles:titleArray];
        [self.pagingTitleView addImages:imageArray];
        self.pagingTitleView.delegate = self;
    }
    return _pagingTitleView;
}

- (void)didSelectedTitleAtIndex:(NSUInteger)index
{
    UIPageViewControllerNavigationDirection direction;
    if (self.currentIndex == index)
        return;
    
    NSInteger valueDifference = index - self.currentIndex;
    BOOL isNextViewController = (labs(valueDifference)) >= 2;
    
    if (index > self.currentIndex)
    {
        direction = UIPageViewControllerNavigationDirectionForward;
        if (isNextViewController)
        {
            [self translateNextViewController:(self.currentIndex+1) direction:direction];
        }
    }
    else
    {
        direction = UIPageViewControllerNavigationDirectionReverse;
        if (isNextViewController)
        {
            [self translateNextViewController:(self.currentIndex-1) direction:direction];
        }
    }
    
    [self translateViewController:index direction:direction];
}

- (void)translateNextViewController:(NSInteger)index direction:(UIPageViewControllerNavigationDirection)direction
{
    UIViewController *viewController = [self viewControllerAtIndex:index];
    if (viewController) {
        __weak typeof(self) weakself = self;
        [self.pageViewController setViewControllers:@[viewController]
                                          direction:direction
                                           animated:YES
                                         completion:^(BOOL finished) {
                                             weakself.currentIndex = index;
                                             [weakself didSelectedTitleAtIndex:index];
                                         }];
    }
}

- (void)translateViewController:(NSInteger)index direction:(UIPageViewControllerNavigationDirection)direction
{
    UIViewController *viewController = [self viewControllerAtIndex:index];
    if (viewController) {
        __weak typeof(self) weakself = self;
        [self.pageViewController setViewControllers:@[viewController] direction:direction animated:YES completion:^(BOOL finished) {
            weakself.currentIndex = index;
        }];
    }
}

- (void)setCurrentIndex:(NSInteger)index
{
    _currentIndex = index;
    [self.pagingTitleView adjustTitleViewAtIndex:index];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat contentOffsetX = scrollView.contentOffset.x;
    CGFloat screenWidth = [[UIScreen mainScreen]bounds].size.width;
    if (self.currentIndex != 0 && contentOffsetX <= screenWidth * 2) {
        contentOffsetX += screenWidth * self.currentIndex;
    }
    [self.pagingTitleView updatePageIndicatorPosition:contentOffsetX];
}

- (void)scrollEnabled:(BOOL)enabled
{
    self.scrollingLocked = !enabled;
    for (UIScrollView *view in self.pageViewController.view.subviews) {
        if ([view isKindOfClass:[UIScrollView class]]) {
            view.scrollEnabled = enabled;
            view.bounces = enabled;
        }
    }
}

#pragma mark - lazy load

- (UIViewController *)createVc1
{
    if (!self.homePageViewController) {
        
        self.homePageViewController = [self.myStoryboard instantiateViewControllerWithIdentifier:HomePageViewControllerID];
    }
    return self.homePageViewController;
}

- (UIViewController *)createVc2
{
    if (!self.promotionsViewController) {
        self.promotionsViewController = [self.myStoryboard instantiateViewControllerWithIdentifier:PromotionsViewControllerID];
    }
    return self.promotionsViewController;
}

- (UIViewController *)createVc3
{
    if (!self.hotDealViewController) {
        self.hotDealViewController = [self.myStoryboard instantiateViewControllerWithIdentifier:HotDealViewControllerID];
    }
    return self.hotDealViewController;
}

@end
