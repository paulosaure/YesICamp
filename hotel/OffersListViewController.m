//
//  OffersListViewController.m
//  hotel
//
//  Created by Paul Lavoine on 20/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "OffersListViewController.h"
#import "OfferCell.h"
#import "OfferDetail.h"
#import "ParsingData.h"
#import "GetOffersListAction.h"

#define NUMBER_OFFERS_WITH_SEARCH       10

@interface OffersListViewController () <UITableViewDelegate, UITableViewDataSource>


// Outlets
@property (weak, nonatomic) IBOutlet UITextField *searchTextView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *startSearchButton;
@property (weak, nonatomic) IBOutlet UIView *searchContentView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinnerView;

// Data
@property (nonatomic, strong) NSArray *offersList;

@end

@implementation OffersListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [NOTIFICATION_CENTER addObserver:self selector:@selector(handleOffersList:) name:OffersListWithCampingNotification object:nil];
    [NOTIFICATION_CENTER addObserver:self selector:@selector(handleOffersList:) name:OffersListNotification object:nil];
    
    if (!self.offersList)
    {
        [[NetworkManagement sharedInstance] addNewAction:[GetOffersListAction action]];
        [self isSearching:YES];
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [NOTIFICATION_CENTER removeObserver:self];
    [self isSearching:NO];
}

- (void)configureUI
{
    self.searchTextView.placeholder = LOCALIZED_STRING(@"offersList.search_text_view.placeholder");
    self.startSearchButton.tintColor = GREEN_COLOR;
    self.searchContentView.backgroundColor = BLACK_COLOR;
    self.view.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundColor = [UIColor clearColor];
    
    [self.searchTextView setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    // Configure table View
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[OfferCell cellNib] forCellReuseIdentifier:OFFER_CELL_IDENTIFIER];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.offersList count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Dequeue cell
    OfferCell *cell = [tableView dequeueReusableCellWithIdentifier:OFFER_CELL_IDENTIFIER];
    
    // Configure celle
    [cell configureWithOffer:self.offersList[indexPath.row]];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 18)];
    [label setFont:[UIFont boldSystemFontOfSize:15]];
    label.textColor = [UIColor whiteColor];
    NSString *string = [[NSString stringWithFormat:@"%@ : %@",LOCALIZED_STRING(@"offersList.header_section.title"), self.searchTextView.text] uppercaseString];
    
    [label setText:string];
    [view addSubview:label];
    [view setBackgroundColor:GREEN_COLOR];
    return view;
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Get camping
    Offer *offer = self.offersList[indexPath.row];
    [NOTIFICATION_CENTER postNotificationName:PushOfferDetailViewNotificiation object:offer];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (2*self.tableView.frame.size.height) / 5;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

#pragma mark - Action

- (IBAction)startSearch:(id)sender
{
    [self isSearching:YES];
    if ([self.searchTextView.text isEqual:@""])
    {
        [[NetworkManagement sharedInstance] addNewAction:[GetOffersListAction action]];
    }
    else
    {
        [[NetworkManagement sharedInstance] addNewAction:[GetOffersListAction actionWithCity:self.searchTextView.text count:NUMBER_OFFERS_WITH_SEARCH]];
    }
}

#pragma mark - Notification
- (void)handleOffersList:(NSNotification *)notif
{
    self.offersList = notif.object;
    [self.tableView reloadData];
    [self isSearching:NO];
}

#pragma mark - Utils

- (void)isSearching:(BOOL)isSearching
{
    self.spinnerView.hidden = !isSearching;
    self.startSearchButton.hidden = isSearching;
    isSearching ? [self.spinnerView startAnimating] : [self.spinnerView stopAnimating];
}

- (void)setSearchTextview:(NSString *)title
{
    self.searchTextView.text = title;
}

- (void)displayWarningMessage
{
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Error"
                                  message:@"Problème technique"
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Ok"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    //Handel your yes please button action here
                                    
                                    
                                }];
    
    [alert addAction:yesButton];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
