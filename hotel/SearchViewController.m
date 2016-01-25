//
//  SearchViewController.m
//  hotel
//
//  Created by Paul Lavoine on 20/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "SearchViewController.h"
#import "ResultsTableViewController.h"
#import "ParsingData.h"

@interface SearchViewController ()

@property (weak, nonatomic) IBOutlet UILabel *searchLabel;
@property (weak, nonatomic) IBOutlet UITextField *searchTextView;
@property (weak, nonatomic) IBOutlet UIButton *startSearchButton;

@end

@implementation SearchViewController

#pragma mark - View life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)startSearch:(id)sender
{
    NSArray *results = [self sendRequestToServer];
    if ([results count] > 0)
    {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:MAIN_STORYBOARD bundle:nil];
        ResultsTableViewController *resultViewController = (ResultsTableViewController *)[storyBoard instantiateViewControllerWithIdentifier:ResultViewControllerID];
        resultViewController.hotels = results;
        [self.navigationController pushViewController:resultViewController animated:YES];
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
