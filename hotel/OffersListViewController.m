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

@interface OffersListViewController () <UITableViewDelegate, UITableViewDataSource>


// Outlets
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *searchTextView;
@property (weak, nonatomic) IBOutlet UIButton *startSearchButton;
@property (weak, nonatomic) IBOutlet UIView *searchContentView;

// Data
@property (nonatomic, strong) NSArray *offersList;

@end

@implementation OffersListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureUI];
    
    [NOTIFICATION_CENTER addObserver:self selector:@selector(handleOffersList:) name:OffersListNotification object:nil];
    
    [[NetworkManagement sharedInstance] addNewAction:[GetOffersListAction action]];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)configureUI
{
    self.searchTextView.placeholder = LOCALIZED_STRING(@"offersList.search_text_view.placeholder");
    self.startSearchButton.tintColor = GREEN_COLOR;
    self.searchContentView.backgroundColor = BLACK_COLOR;
    self.view.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundColor = [UIColor clearColor];
    
    [self.searchTextView setValue:GREEN_COLOR forKeyPath:@"_placeholderLabel.textColor"];
    
    // Configure table View
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[OfferCell cellNib] forCellReuseIdentifier:OFFER_CELL_IDENTIFIER];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.offersList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Dequeue cell
    OfferCell *cell = [tableView dequeueReusableCellWithIdentifier:OFFER_CELL_IDENTIFIER];
    
    // Configure celle
    [cell configureWithCamping:self.offersList[indexPath.row]];

    return cell;
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Get camping
    Offer *offer = self.offersList[indexPath.row];
    [NOTIFICATION_CENTER postNotificationName:OfferDetailNotificiation object:offer];
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
    [[NetworkManagement sharedInstance] addNewAction:[GetOffersListAction actionWithCity:self.searchTextView.text]];
}

#pragma mark - Notification
- (void)handleOffersList:(NSNotification *)notif
{
    self.offersList = notif.object;
    [self.tableView reloadData];
}

#pragma mark - Utils

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
