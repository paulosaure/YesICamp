//
//  LPViewPagerController.m
//  LPViewPagerController
//
//  Created by litt1e-p on 15/12/5.
//  Copyright © 2015年 litt1e-p. All rights reserved.
//

#import "LPViewPagerController.h"

@interface LPViewPagerController () <UIScrollViewDelegate>

@property UIView *contentView;
@property NSMutableArray *contents;
@property NSUInteger tabCount;
@property NSUInteger currentIndex;
@property (getter = isAnimatingToTab, assign) BOOL animatingToTab;
@property (nonatomic) BOOL canLimitBounce;

@end

@implementation LPViewPagerController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self defaultSettings];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        [self defaultSettings];
    }
    return self;
}

#pragma mark - View life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    if (!self.manualLoadData)
    {
        [self reloadData];
    }
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [self.contentView setBackgroundColor:[BLACK_COLOR colorWithAlphaComponent:0.9f]];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -
- (void)defaultSettings
{
    _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                          navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                        options:nil];
    [((UIScrollView*)[_pageViewController.view.subviews objectAtIndex:0]) setDelegate:self];
    _pageViewController.dataSource = self;
    _pageViewController.delegate   = self;
    self.animatingToTab            = NO;
    self.showFromTabIndex          = 0;
}

- (void)reloadData
{
    _currentIndex   = 0;
    _canLimitBounce = YES;
    [_contents removeAllObjects];
    _tabCount       = [self.dataSource numberOfTabsForViewPager:self];
    _contents       = [NSMutableArray arrayWithCapacity:_tabCount];
    
    for (int i = 0; i < _tabCount; i++)
    {
        [_contents addObject:[NSNull null]];
    }
    
    if (!_contentView)
    {
        _contentView                  = _pageViewController.view;
        _contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _contentView.backgroundColor  = self.contentViewBackgroundColor;
        _contentView.bounds           = self.view.bounds;
        [self.view insertSubview:_contentView atIndex:0];
    }
    // Set first viewController
    UIViewController *viewController = [self viewControllerAtIndex:self.showFromTabIndex];
    if (viewController == nil)
    {
        viewController      = [[UIViewController alloc] init];
        viewController.view = [[UIView alloc] init];
    }
    [_pageViewController setViewControllers:@[viewController]
                                  direction:UIPageViewControllerNavigationDirectionForward
                                   animated:NO
                                 completion:nil];
}

- (UIViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (index >= _tabCount)
        return nil;

    if ([[_contents objectAtIndex:index] isEqual:[NSNull null]])
    {
        UIViewController *viewController;
        if ([self.dataSource respondsToSelector:@selector(viewPager:contentViewControllerForTabAtIndex:)]) {
            viewController = [self.dataSource viewPager:self contentViewControllerForTabAtIndex:index];
        } else {
            viewController      = [[UIViewController alloc] init];
            viewController.view = [[UIView alloc] init];
        }
        [_contents replaceObjectAtIndex:index withObject:viewController];
    }
    return [_contents objectAtIndex:index];
}

- (NSUInteger)indexForViewController:(UIViewController *)viewController
{
    return [_contents indexOfObject:viewController];
}

#pragma mark - UIPageViewControllerDataSource
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
       viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexForViewController:viewController];
    self.currentIndex = index;
    index++;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
      viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexForViewController:viewController];
    self.currentIndex = index;
    index--;
    return [self viewControllerAtIndex:index];
}

- (void)pageViewController:(UIPageViewController *)pageViewController
        didFinishAnimating:(BOOL)finished
   previousViewControllers:(NSArray *)previousViewControllers
       transitionCompleted:(BOOL)completed
{
    if (completed)
    {
        self.currentIndex = [_contents indexOfObject:[pageViewController.viewControllers lastObject]];
    }
}

#pragma mark - UIScrollViewDelegate, Responding to Scrolling and Dragging
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.scrollingLocked)
        return;

    CGFloat screenWidth = [[UIScreen mainScreen]bounds].size.width;
    if (self.currentIndex == 0 && scrollView.contentOffset.x < screenWidth && self.canLimitBounce)
    {
        scrollView.contentOffset = CGPointMake(screenWidth, scrollView.contentOffset.y);
    } else if (self.currentIndex == (self.tabCount - 1) && scrollView.contentOffset.x > screenWidth && self.canLimitBounce)
    {
        scrollView.contentOffset = CGPointMake(screenWidth, scrollView.contentOffset.y);
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(setSubViewScrollStatus:)])
    {
        [self.delegate setSubViewScrollStatus:NO];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(setSubViewScrollStatus:)])
    {
        [self.delegate setSubViewScrollStatus:YES];
    }
}
@end
