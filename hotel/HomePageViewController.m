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
    NSAttributedString *pseudoPlaceHolder = [[NSAttributedString alloc] initWithString:LOCALIZED_STRING(@"homePage.email.placeholder") attributes:@{NSForegroundColorAttributeName : BLUE_COLOR}];
    self.pseudoTextView.attributedPlaceholder = pseudoPlaceHolder;
    
    NSAttributedString *passPlaceholder = [[NSAttributedString alloc] initWithString:LOCALIZED_STRING(@"homePage.password.placeholder") attributes:@{NSForegroundColorAttributeName : BLUE_COLOR}];
    self.passwordTextView.attributedPlaceholder = passPlaceholder;
    
    
    self.pseudoTextView.backgroundColor = [UIColor clearColor];
    self.pseudoTextView.layer.borderColor = BLUE_COLOR.CGColor;
    self.pseudoTextView.layer.borderWidth = 1.0f;
    self.pseudoTextView.layer.cornerRadius = 5.0f;
    
    self.passwordTextView.backgroundColor = [UIColor clearColor];
    self.passwordTextView.layer.borderColor = BLUE_COLOR.CGColor;
    self.passwordTextView.layer.borderWidth = 1.0f;
    self.passwordTextView.layer.cornerRadius = 5.0f;
    
    [self.connectionButton setTitle:LOCALIZED_STRING(@"homePage.connection.button") forState:UIControlStateNormal];
    [self.connectionButton setTitleColor:TINT_COLOR forState:UIControlStateNormal];
    self.connectionButton.backgroundColor = [BLUE_COLOR colorWithAlphaComponent:0.5f];
    self.connectionButton.layer.cornerRadius = 5.0f;
    
    [self.signUpButton setTitle:LOCALIZED_STRING(@"homePage.inscription.button") forState:UIControlStateNormal];
    [self.signUpButton setTitleColor:TINT_COLOR forState:UIControlStateNormal];
    self.signUpButton.backgroundColor = [BLUE_COLOR colorWithAlphaComponent:0.5f];
    self.signUpButton.layer.cornerRadius = 5.0f;
    
    self.view.backgroundColor = [UIColor clearColor];
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
