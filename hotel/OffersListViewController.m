//
//  OffersListViewController.m
//  hotel
//
//  Created by Paul Lavoine on 20/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "OffersListViewController.h"
#import "PromotionCell.h"
#import "ProfilViewController.h"
#import "ParsingData.h"
#import "GetOffersListAction.h"

@interface OffersListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *searchTextView;
@property (weak, nonatomic) IBOutlet UIButton *startSearchButton;

@end

@implementation OffersListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[PromotionCell cellNib] forCellReuseIdentifier:PROMO_CELL_IDENTIFIER];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[GetOffersListAction action] requestServer];
}

- (void)configureUI
{
    self.searchTextView.placeholder = LOCALIZED_STRING(@"offersList.search_text_view.placeholder");
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;//[self.campings count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Dequeue cell
    PromotionCell *cell = [tableView dequeueReusableCellWithIdentifier:PROMO_CELL_IDENTIFIER];
    
    // Configure celle
    [cell configureWithCamping:self.campings[indexPath.row]];

    return cell;
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Get hotek
    Camping *camping = self.campings[indexPath.row];
    
    [NOTIFICATION_CENTER postNotificationName:ProfilNotificiation object:camping];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200.0f;
}

#pragma mark - Request

- (NSArray *)sendRequestToServer
{
    NSArray *results = [NSArray array];
    // [ParsingData sharedInstance]
    return results;
}

#pragma mark - Action

- (IBAction)startSearch:(id)sender
{
    NSArray *results = [self sendRequestToServer];
    if ([results count] > 0)
    {
        [self.tableView reloadData];
    }
    else
    {
        [self displayWarningMessage];
    }
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
