//
//  HomePageViewController.m
//  hotel
//
//  Created by Paul Lavoine on 20/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomePageViewController.h"
#import "ConnectionUserAction.h"
#import "InscriptionViewController.h"


@interface HomePageViewController ()

@property (weak, nonatomic) IBOutlet UITextField *pseudoTextView;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextView;
@property (weak, nonatomic) IBOutlet UIButton *connectionButton;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;


@end

@implementation HomePageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureUI];
}

- (void)configureUI
{
    self.signUpButton.titleLabel.text = LOCALIZED_STRING(@"homePage.inscription.button");
    self.connectionButton.titleLabel.text = LOCALIZED_STRING(@"homePage.connection.button");
    self.pseudoTextView.placeholder = LOCALIZED_STRING(@"homePage.email.placeholder");
    self.passwordTextView.placeholder = LOCALIZED_STRING(@"homePage.password.placeholder");
}

- (IBAction)connection:(id)sender
{
    [[ConnectionUserAction action] requestServer];
    
    
    
    //    if ([[NetworkManagement sharedInstance] connectionWithServer])
    //    {
    ////        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:MAIN_STORYBOARD bundle:nil];
    ////        SearchViewController *searchViewController = (SearchViewController *)[storyBoard instantiateViewControllerWithIdentifier:SearchViewControllerID];
    ////        [self.navigationController pushViewController:searchViewController animated:YES];
    //    }
    //    else
    //    {
    //        UIAlertController * alert=   [UIAlertController
    //                                      alertControllerWithTitle:@"Error"
    //                                      message:@"Problème technique"
    //                                      preferredStyle:UIAlertControllerStyleAlert];
    //
    //        UIAlertAction* yesButton = [UIAlertAction
    //                                    actionWithTitle:@"Ok"
    //                                    style:UIAlertActionStyleDefault
    //                                    handler:^(UIAlertAction * action)
    //                                    {
    //                                        //Handel your yes please button action here
    //
    //
    //                                    }];
    //
    //        [alert addAction:yesButton];
    //
    //        [self presentViewController:alert animated:YES completion:nil];
    //    }
}

- (IBAction)pushInscriptionViewController:(id)sender
{
    [NOTIFICATION_CENTER postNotificationName:InscriptionNotificiation object:nil];
}



@end
