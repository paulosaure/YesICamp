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
#import "CalendarPickerViewController.h"
#import "GetOfferDetailAction.h"
#import "UIButton+Effects.h"
#import <MessageUI/MessageUI.h>

#define PAGE_CONTROLLER_HEIGHT 350

@interface OfferDetail () <UITableViewDataSource, UITableViewDelegate, UIPageViewControllerDataSource, UIPageViewControllerDelegate, MFMailComposeViewControllerDelegate>

// Outlets
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UIButton *reservationButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (nonatomic, weak) IBOutlet UIView *footerView;
@property (weak, nonatomic) IBOutlet UIButton *mailButtonFooterView;

// Data
@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) NSMutableArray *contentData;
@property (nonatomic, strong) NSMutableArray *imagesData;

@end

@implementation OfferDetail

#pragma mark - View lifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self isSearching:YES];
    [NOTIFICATION_CENTER addObserver:self selector:@selector(handleOfferDetail:) name:OfferDetailNotification object:nil];
    
    [[NetworkManagement sharedInstance] addNewAction:[GetOfferDetailAction action:[self.offer.uid stringValue]]];
    
    
    // Init data for tableView
    self.contentData = [NSMutableArray array];
    self.imagesData = [[NSMutableArray alloc] initWithArray:self.offer.images];
    
    // Init view page controller
    self.pageViewController = [[UIPageViewController alloc] init];
    self.pageViewController.delegate = self;
    
    // Configure view page controller
    [self createPageViewController];
    [self setupPageControl];
    
    // register Cell Nib
    [self.tableView registerNib:[OfferDetailCell cellNib] forCellReuseIdentifier:OFFER_DETAIL_CELL_IDENTIFIER];
    
    // Change height table header view
    self.tableView.estimatedRowHeight = 65.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.tableHeaderView = self.pageViewController.view;
    self.tableView.tableFooterView = self.footerView;
    self.mailButtonFooterView.hidden = YES;
    
    [self configureUI];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [NOTIFICATION_CENTER removeObserver:self];
}

- (void)configureUI
{
    self.view.backgroundColor = [UIColor blackColor];
    self.tableView.backgroundColor = [UIColor blackColor];
    self.mailButtonFooterView.imageView.tintColor = GREEN_COLOR;
    
    NSString *titleButton = [NSString stringWithFormat:@"%@  |  %@ %@",[LOCALIZED_STRING(@"offerDetail.reservation.button") uppercaseString], self.offer.price, LOCALIZED_STRING(@"globals.unity")];
    [self.reservationButton addEffectbelowBookButton:titleButton];
}


#pragma mark - Configuration

- (void)createPageViewController
{
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewController.dataSource = self;
    self.pageViewController.view.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), PAGE_CONTROLLER_HEIGHT);
    self.pageViewController.view.backgroundColor = BLACK_COLOR;
    [self setNumberOfPageItemController];
}

- (void)setNumberOfPageItemController
{
    if([self.imagesData count])
    {
        NSArray *startingViewControllers = @[[self itemControllerForIndex: 0]];
        [self.pageViewController setViewControllers: startingViewControllers
                                          direction: UIPageViewControllerNavigationDirectionForward
                                           animated: NO
                                         completion: nil];
    }
    
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
    if (viewController.itemIndex+1 < [self.imagesData count])
        return [self itemControllerForIndex:viewController.itemIndex+1];
    
    return nil;
}

- (PageItemController *) itemControllerForIndex: (NSUInteger) itemIndex
{
    if (itemIndex < [self.imagesData count])
    {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:MAIN_STORYBOARD bundle:nil];
        PageItemController *pageItemController = (PageItemController *)[storyBoard instantiateViewControllerWithIdentifier: PageItemControllerID];
        [pageItemController configurePageWith:self.imagesData[itemIndex] index:itemIndex];
        return pageItemController;
    }
    
    return nil;
}

#pragma mark - Page Indicator

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.imagesData count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

#pragma mark - TableViewMethods Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.contentData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Dequeue cell
    OfferDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:OFFER_DETAIL_CELL_IDENTIFIER];
    
    // Configure cell
    [cell configureWithInformationsOffer:self.contentData[indexPath.row]];
    [cell setSeparatorVisiblity:(indexPath.row == ([self.contentData count] - 1))];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBackgroundColor:[UIColor clearColor]];
}

#pragma mark - MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result) {
        case MFMailComposeResultSent:
            NSLog(@"You sent the email.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"You saved a draft of this email");
            break;
        case MFMailComposeResultCancelled:
            NSLog(@"You cancelled sending this email.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed:  An error occurred when trying to compose this email");
            break;
        default:
            NSLog(@"An error occurred when trying to compose this email");
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - Notification

- (void)handleOfferDetail:(NSNotification *)notif
{
    self.offer = notif.object;
    [self.imagesData addObjectsFromArray:self.offer.images];
    [self constructDataArray];
    [self.tableView reloadData];
    [self setNumberOfPageItemController];
    [self isSearching:NO];
}

#pragma mark - Actions
- (IBAction)sendEmail:(id)sender
{
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
        mail.mailComposeDelegate = self;
        [mail setSubject:@"Sample Subject"];
        [mail setMessageBody:@"Here is some main text in the email!" isHTML:NO];
        [mail setToRecipients:@[self.offer.email]];
        
        [self presentViewController:mail animated:YES completion:NULL];
    }
    else
    {
        NSLog(@"This device cannot send email");
    }

}

- (IBAction)reserveCamping:(id)sender
{
    [NOTIFICATION_CENTER postNotificationName:CalendarPickerNotification object:self.offer];
}

#pragma mark - Utils

- (void)isSearching:(BOOL)isSearching
{
    self.spinner.hidden = !isSearching;
    self.reservationButton.hidden = isSearching;
    isSearching ? [self.spinner startAnimating] : [self.spinner stopAnimating];
}

- (void)constructDataArray
{
    self.contentData = [NSMutableArray arrayWithArray:self.offer.mainTextInfos];
    
    // Allows to add some additionnal information
}

@end
