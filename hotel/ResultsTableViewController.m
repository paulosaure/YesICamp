//
//  ResultsTableViewController.m
//  hotel
//
//  Created by Paul Lavoine on 20/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "ResultsTableViewController.h"
#import "ResultCell.h"
#import "ProfilViewController.h"

@interface ResultsTableViewController ()

@end

@implementation ResultsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.tableView registerNib:[ResultCell cellNib] forCellReuseIdentifier:RESULT_CELL_IDENTIFIER];
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
    ResultCell *cell = [tableView dequeueReusableCellWithIdentifier:RESULT_CELL_IDENTIFIER];
    
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

@end
