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
#import "OffersListViewController.h"
#import "InformationViewController.h"

#import "InscriptionViewController.h"
#import "ProfilViewController.h"



@interface ScrollPagesViewController () <LPViewPagerDataSource, LPViewPagerDelegate, LPTitleViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageBackgroundView;
@property (nonatomic, strong) HomePageViewController *homePageViewController;
@property (nonatomic, strong) HotDealViewController *hotDealViewController;
@property (nonatomic, strong) OffersListViewController *promotionsViewController;
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
    self.navigationController.navigationBar.translucent = NO;
    self.myStoryboard = [UIStoryboard storyboardWithName:MAIN_STORYBOARD bundle:nil];
    
    [self configureNotification];
    [self configureUI];
    [self reloadData];
    
    
    UISwipeGestureRecognizer *Swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(SwipeRecognizer:)];
    Swipe.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:Swipe];
}

#pragma mark - Configurations

- (void)configureNotification
{
    [NOTIFICATION_CENTER addObserver:self selector:@selector(pushInscriptionViewController) name:InscriptionNotificiation object:nil];
    [NOTIFICATION_CENTER addObserver:self selector:@selector(pushProfilViewController:) name:ProfilNotificiation object:nil];
    [NOTIFICATION_CENTER addObserver:self selector:@selector(pushHotDealViewController:) name:HotDealNotification object:nil];
}

- (void)configureUI
{
    self.view.backgroundColor = GREEN_COLOR;
    self.navigationController.navigationBar.barTintColor = GREEN_COLOR;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.imageBackgroundView.image = [UIImage imageNamed:@"backgroundImage"];
     [self.view insertSubview:self.imageBackgroundView atIndex:0];
}

#pragma mark - LPViewPagerDataSource
- (NSUInteger)numberOfTabsForViewPager:(LPViewPagerController *)viewPager
{
    return 3;
}

- (UIViewController *)viewPager:(LPViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index
{
    UIViewController *viewController;
    
    switch (index)
    {
        case PageControllerPromo:
            viewController = self.promotionsViewController;
            if (!viewController)
            {
                viewController = [self.myStoryboard instantiateViewControllerWithIdentifier:PromotionsViewControllerID];
            }
            break;
            
        case PageControllerHotDeal:
            viewController = self.hotDealViewController;
            if (!viewController)
            {
                viewController = [self.myStoryboard instantiateViewControllerWithIdentifier:HotDealViewControllerID];
            }
            break;
            
        case PageControllerAccount:
        default:
            viewController = self.homePageViewController;
            if (!viewController)
            {
                viewController = [self.myStoryboard instantiateViewControllerWithIdentifier:HomePageViewControllerID];
            }
            break;
    }

    return viewController;
}

#pragma mark 🎈LPViewPagerDelegate

- (void)viewPager:(LPViewPagerController *)viewPager didChangeTabToIndex:(NSUInteger)index
{
    self.currentIndex = index;
}

- (LPTitleView *)pagingTitleView
{
    if (!_pagingTitleView)
    {
        self.pagingTitleView                    = [[LPTitleView alloc] init];
        self.pagingTitleView.backgroundColor    = [UIColor clearColor];
        self.pagingTitleView.indicatorColor     = BLUE_COLOR;
        self.pagingTitleView.frame              = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CONTENT_PICTO_VIEW_HEIGHT);
        
        NSArray *imageArray           = @[@"account", @"discount", @"hotDeal"];
        self.pagingTitleView.delegate = self;
        [self.pagingTitleView addImages:imageArray];
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
    // Don't remove _ with self.
    _currentIndex = index;
    
    switch (index)
    {
        case PageControllerPromo:

            break;
            
        case PageControllerHotDeal:
            
            break;
            
        case PageControllerAccount:
        default:

            break;
    }
    
    //    [self.pagingTitleView adjustImageViewAtIndex:index];
    /*
     Cette méthode permettait (car je l'ai supprimé) de modifier la couleur du texte des images, on peut aller la récupérer dans git. Pour nous elle permet a la limite de grossir les image donc à garder si jamais. Je vais la commenter plutot
     */
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

#pragma mark - Notifications

- (UIStoryboard *)mainStoryboard
{
    return [UIStoryboard storyboardWithName:MAIN_STORYBOARD bundle:nil];
}

- (void)pushHotDealViewController:(NSNotification *)notification
{
    ProfilViewController *profilViewController = (ProfilViewController *)[[self mainStoryboard] instantiateViewControllerWithIdentifier:ProfilViewControllerID];
    profilViewController.camping = notification.object;
    [self pushViewController:profilViewController];
}

- (void)pushInscriptionViewController
{
    InscriptionViewController *inscriptionViewController = (InscriptionViewController *)[[self mainStoryboard] instantiateViewControllerWithIdentifier:InscriptionViewControllerID];
    [self pushViewController:inscriptionViewController];
}

- (void)pushProfilViewController:(NSNotification *)notification
{
    ProfilViewController *profilViewController = (ProfilViewController *)[[self mainStoryboard] instantiateViewControllerWithIdentifier:ProfilViewControllerID];
    profilViewController.camping = notification.object;
    [self pushViewController:profilViewController];
}

- (void)pushViewController:(UIViewController *)view
{
    [self.navigationController pushViewController:view animated:YES];
}

#pragma mark - Utils

- (void) SwipeRecognizer:(UISwipeGestureRecognizer *)sender
{
    [self.view endEditing:YES];
}

@end
