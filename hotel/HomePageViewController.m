//
//  HomePageViewController.m
//  hotel
//
//  Created by Paul Lavoine on 20/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "HomePageViewController.h"
#import "SearchViewController.h"

@interface HomePageViewController ()

@property (weak, nonatomic) IBOutlet UITextField *pseudoTextView;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextView;


@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)connection:(id)sender
{
    if ([self connectionWithServer])
    {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:MAIN_STORYBOARD bundle:nil];
        SearchViewController *searchViewController = (SearchViewController *)[storyBoard instantiateViewControllerWithIdentifier:SearchViewControllerID];
        [self.navigationController pushViewController:searchViewController animated:YES];
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
        //        UIAlertAction* noButton = [UIAlertAction
        //                                   actionWithTitle:@"No, thanks"
        //                                   style:UIAlertActionStyleDefault
        //                                   handler:^(UIAlertAction * action)
        //                                   {
        //                                       //Handel no, thanks button
        //
        //                                   }];
        
        [alert addAction:yesButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (BOOL)connectionWithServer
{
    
    return YES;
}



@end
