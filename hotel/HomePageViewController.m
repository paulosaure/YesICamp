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
#import "UITextField+Effects.h"
#import "UIButton+Effects.h"

@interface HomePageViewController ()

// Outlets
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
    
    UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureRecognizer:)];
    [self.view addGestureRecognizer:singleFingerTap];
}

- (void)configureUI
{    
    [self.pseudoTextView addTransparentColorEffect:GREEN_COLOR placeholder:LOCALIZED_STRING(@"homePage.email.placeholder")];
    [self.passwordTextView addTransparentColorEffect:GREEN_COLOR placeholder:LOCALIZED_STRING(@"homePage.password.placeholder")];
    [self.connectionButton addColorEffect:GREEN_COLOR text:LOCALIZED_STRING(@"homePage.connection.button")];
    [self.signUpButton addColorEffect:GREEN_COLOR text:LOCALIZED_STRING(@"homePage.inscription.button")];
    
    self.view.backgroundColor = [UIColor clearColor];
}

- (IBAction)connection:(id)sender
{
    if ([self.pseudoTextView.text isEqualToString:@""] || [self.passwordTextView.text isEqualToString:@""])
    {
        [NOTIFICATION_CENTER postNotificationName:EmptyFieldsNotification object:nil];
    }
    else
    {
        NSLog(@"Connexion ...");
    }
    //    if ([[NetworkManagement sharedInstance] connectionWithServer])

}

- (IBAction)pushInscriptionViewController:(id)sender
{
    [NOTIFICATION_CENTER postNotificationName:InscriptionNotificiation object:nil];
}


#pragma mark - Utils

- (void)gestureRecognizer:(UISwipeGestureRecognizer *)sender
{
    [self.view endEditing:YES];
}


@end
