//
//  ScrollPagesViewController.m
//  hotel
//
//  Created by Paul Lavoine on 25/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "ScrollPagesViewController.h"
#import "LPTitleView.h"

#import "ConnectionViewController.h"
#import "HotDealViewController.h"
#import "OffersListViewController.h"

#import "InscriptionViewController.h"
#import "OfferDetail.h"
#import "CalendarPickerViewController.h"
#import "GetOfferDetailAction.h"

@interface ScrollPagesViewController () <LPViewPagerDataSource, LPViewPagerDelegate, LPTitleViewDelegate>

// Outlets
@property (weak, nonatomic) IBOutlet UIImageView *imageBackgroundView;

// Data
@property (nonatomic, strong) ConnectionViewController *homePageViewController;
@property (nonatomic, strong) HotDealViewController *hotDealViewController;
@property (nonatomic, strong) OffersListViewController *promotionsViewController;

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
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.myStoryboard = [UIStoryboard storyboardWithName:MAIN_STORYBOARD bundle:nil];
    
    [self configureNotification];
    [self configureUI];
    [self reloadData];
    
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gestureRecognizer:)];
    swipe.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipe];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // TODO Remove
//    [self didSelectedTitleAtIndex:PageControllerPromo];
}

#pragma mark - Configurations

- (void)configureNotification
{
    [NOTIFICATION_CENTER addObserver:self selector:@selector(pushInscriptionViewController) name:InscriptionViewNotificiation object:nil];
    [NOTIFICATION_CENTER addObserver:self selector:@selector(pushProfilViewController:) name:PushOfferDetailViewNotificiation object:nil];
    [NOTIFICATION_CENTER addObserver:self selector:@selector(pushHotDealViewController:) name:HotDealSelectedNotification object:nil];
    [NOTIFICATION_CENTER addObserver:self selector:@selector(pushCalendarPickerViewController:) name:CalendarPickerNotification object:nil];
    [NOTIFICATION_CENTER addObserver:self selector:@selector(pushAlertFields:) name:popUpNotification object:nil];
}

- (void)configureUI
{
    self.view.backgroundColor = [UIColor whiteColor];
//    self.navigationController.navigationBar.barTintColor = BLACK_COLOR;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.imageBackgroundView.image = [UIImage imageNamed:@"backgroundImage"];
    [self.imageBackgroundView setTintColor:GREEN_COLOR];
    self.imageBackgroundView.contentMode = UIViewContentModeScaleAspectFill;
     [self.view insertSubview:self.imageBackgroundView atIndex:0];
//        [self.navigationController.navigationBar setTintColor:GREEN_COLOR];
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
                self.promotionsViewController = [self.myStoryboard instantiateViewControllerWithIdentifier:PromotionsViewControllerID];
                viewController = self.promotionsViewController;
            }
            break;
            
        case PageControllerHotDeal:
            viewController = self.hotDealViewController;
            if (!viewController)
            {
                self.hotDealViewController = [self.myStoryboard instantiateViewControllerWithIdentifier:HotDealViewControllerID];
                viewController = self.hotDealViewController;
                ((HotDealViewController *)viewController).parent = self;
            }
            break;
            
        case PageControllerAccount:
        default:
            viewController = self.homePageViewController;
            if (!viewController)
            {
                self.homePageViewController = [self.myStoryboard instantiateViewControllerWithIdentifier:HomePageViewControllerID];
                viewController = self.homePageViewController;
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
        self.pagingTitleView.indicatorColor     = GREEN_COLOR;
        self.pagingTitleView.frame              = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CONTENT_PICTO_VIEW_HEIGHT);
        
        NSArray *imageArray           = @[@"discount", @"localization", @"account"];
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
    
    [self.pagingTitleView adjustImageViewAtIndex:index];
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
    OfferDetail *profilViewController = (OfferDetail *)[[self mainStoryboard] instantiateViewControllerWithIdentifier:OfferDetailViewControllerID];
    profilViewController.offer = notification.object;
    [self pushViewController:profilViewController];
}

- (void)pushInscriptionViewController
{
    InscriptionViewController *inscriptionViewController = (InscriptionViewController *)[[self mainStoryboard] instantiateViewControllerWithIdentifier:InscriptionViewControllerID];
    [self pushViewController:inscriptionViewController];
}

- (void)pushProfilViewController:(NSNotification *)notification
{
    OfferDetail *profilViewController = (OfferDetail *)[[self mainStoryboard] instantiateViewControllerWithIdentifier:OfferDetailViewControllerID];
    profilViewController.offer = notification.object;
    [self pushViewController:profilViewController];
}

- (void)pushCalendarPickerViewController:(NSNotification *)notication
{
    CalendarPickerViewController *calendarPickerViewController = (CalendarPickerViewController *)[[self mainStoryboard] instantiateViewControllerWithIdentifier:CalendarPickerID];
    calendarPickerViewController.offer = notication.object;
    [self pushViewController:calendarPickerViewController];
}

- (void)pushViewController:(UIViewController *)view
{
    [self.navigationController pushViewController:view animated:YES];
}

- (void)pushAlertFields:(NSNotification *)notification
{
    PopUpInformation *information = notification.object;
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:information.title
                                  message:information.message
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:information.messageButton
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    if (information.popToRootViewController)
                                    {
                                        [self.navigationController popToRootViewControllerAnimated:YES];
                                        [self didSelectedTitleAtIndex:PageControllerAccount];
                                    }
                                }];
    
    [alert addAction:yesButton];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Utils

- (void)setHeaderSectionWithString:(NSString *)title
{
    [self.promotionsViewController isSearching:YES];
    [self.promotionsViewController setSearchTextview:title];
}

- (void)gestureRecognizer:(UISwipeGestureRecognizer *)sender
{
    [self.view endEditing:YES];
}

@end
