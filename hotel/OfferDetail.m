//
//  OfferDetail.m
//  hotel
//
//  Created by Paul Lavoine on 20/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "OfferDetail.h"
#import "OfferDetailCell.h"
#import "PageItemController.h"
#import "MangopayViewController.h"
#import "GetOfferDetailAction.h"

#define PAGE_CONTROLLER_HEIGHT 350

@interface OfferDetail () <UITableViewDataSource, UITableViewDelegate, UIPageViewControllerDataSource, UIPageViewControllerDelegate>

// Outlets
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UIButton *reservationButton;

// Data
@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) NSArray *contentImages;
@property (nonatomic, strong) NSMutableArray *contentData;

@end

@implementation OfferDetail

#pragma mark - View lifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [NOTIFICATION_CENTER addObserver:self selector:@selector(handleOfferDetail:) name:OfferDetailNotificiation object:nil];
    
    [[NetworkManagement sharedInstance] addNewAction:[GetOfferDetailAction action:[self.offer.uid stringValue]]];
    
    
    // Init data for tableView
    self.contentData = [NSMutableArray array];
    
    // Init view page controller
    self.pageViewController = [[UIPageViewController alloc] init];
    self.pageViewController.delegate = self;
    
    // Configure view page controller
    [self createPageViewController];
    [self setupPageControl];
    
    // Change height table header view
    self.tableView.estimatedRowHeight = 65.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.tableHeaderView = self.pageViewController.view;
    
    // register Cell Nib
    [self.tableView registerNib:[OfferDetailCell cellNib] forCellReuseIdentifier:OFFER_DETAIL_CELL_IDENTIFIER];
    
    [self configureUI];
}

- (void)configureUI
{
    [self.reservationButton setBackgroundColor:BLACK_COLOR];
    self.view.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundColor = [UIColor clearColor];
}


#pragma mark - Configuration

- (void)createPageViewController
{
    self.contentImages = @[@"campingImage",
                           @"campingImage",
                           @"campingImage",
                           @"campingImage"];
    
    UIPageViewController *pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    pageController.dataSource = self;
    pageController.view.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), PAGE_CONTROLLER_HEIGHT);
    pageController.view.backgroundColor = BLACK_COLOR;
    
    if([self.contentImages count])
    {
        NSArray *startingViewControllers = @[[self itemControllerForIndex: 0]];
        [pageController setViewControllers: startingViewControllers
                                 direction: UIPageViewControllerNavigationDirectionForward
                                  animated: NO
                                completion: nil];
    }
    
    self.pageViewController = pageController;
}

- (void)setupPageControl
{
    [[UIPageControl appearance] setPageIndicatorTintColor: [UIColor grayColor]];
    [[UIPageControl appearance] setCurrentPageIndicatorTintColor: [UIColor whiteColor]];
    [[UIPageControl appearance] setBackgroundColor: [UIColor clearColor]];
}

#pragma mark - UIPageViewControllerDelegate

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(PageItemController *)viewController
{
    if (viewController.itemIndex > 0)
        return [self itemControllerForIndex:viewController.itemIndex-1];
    
    return nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(PageItemController *)viewController
{
    if (viewController.itemIndex+1 < [self.contentImages count])
        return [self itemControllerForIndex:viewController.itemIndex+1];
    
    return nil;
}

- (PageItemController *) itemControllerForIndex: (NSUInteger) itemIndex
{
    if (itemIndex < [self.contentImages count])
    {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:MAIN_STORYBOARD bundle:nil];
        PageItemController *pageItemController = (PageItemController *)[storyBoard instantiateViewControllerWithIdentifier: PageItemControllerID];
        [pageItemController configurePageWith:self.contentImages[itemIndex] index:itemIndex];
        return pageItemController;
    }
    
    return nil;
}

#pragma mark - Page Indicator

- (NSInteger) presentationCountForPageViewController: (UIPageViewController *) pageViewController
{
    return [self.contentImages count];
}

- (NSInteger) presentationIndexForPageViewController: (UIPageViewController *) pageViewController
{
    return 0;
}

#pragma mark - TableViewMethods Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.offer.mainTextInfos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Dequeue cell
    OfferDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:OFFER_DETAIL_CELL_IDENTIFIER];
    
    // Configure cell
    [cell configureWithInformationsOffer:self.offer.mainTextInfos[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBackgroundColor:[UIColor clearColor]];
}

#pragma mark - Notification

- (void)handleOfferDetail:(NSNotification *)notif
{
    self.offer = notif.object;
    [self.tableView reloadData];
}

#pragma mark - Actions

- (IBAction)reserveCamping:(id)sender
{
    [NOTIFICATION_CENTER postNotificationName:MangoPayNotification object:nil];
}

@end
