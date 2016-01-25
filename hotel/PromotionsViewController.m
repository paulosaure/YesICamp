//
//  ResultsTableViewController.m
//  hotel
//
//  Created by Paul Lavoine on 20/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "PromotionsViewController.h"
#import "PromotionCell.h"
#import "ProfilViewController.h"
#import "ParsingData.h"

@interface PromotionsViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *searchLabel;
@property (weak, nonatomic) IBOutlet UITextField *searchTextView;
@property (weak, nonatomic) IBOutlet UIButton *startSearchButton;

@end

@implementation PromotionsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.tableView registerNib:[PromotionCell cellNib] forCellReuseIdentifier:PROMO_CELL_IDENTIFIER];
}

#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.hotels count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Dequeue cell
    PromotionCell *cell = [tableView dequeueReusableCellWithIdentifier:PROMO_CELL_IDENTIFIER];
    
    // Configure celle
    [cell configureWithHotel:self.hotels[indexPath.row]];

    return cell;
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Get hotek
    Camping *hotel = self.hotels[indexPath.row];
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:MAIN_STORYBOARD bundle:nil];
    ProfilViewController *profilViewController = (ProfilViewController *)[storyBoard instantiateViewControllerWithIdentifier:ProfilViewControllerID];
    profilViewController.hotel = hotel;
    
    [self.navigationController pushViewController:profilViewController animated:YES];
}

- (IBAction)startSearch:(id)sender
{
    NSArray *results = [self sendRequestToServer];
    if ([results count] > 0)
    {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:MAIN_STORYBOARD bundle:nil];
        PromotionsViewController *promotionViewController = (PromotionsViewController *)[storyBoard instantiateViewControllerWithIdentifier:PromotionsViewControllerID];
        promotionViewController.hotels = results;
        [self.navigationController pushViewController:promotionViewController animated:YES];
    }
    else
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
}

- (NSArray *)sendRequestToServer
{
    NSArray *results = [NSArray array];
    // [ParsingData sharedInstance]
    return results;
}

@end
