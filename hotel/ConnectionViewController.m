//
//  ConnectionViewController.m
//  hotel
//
//  Created by Paul Lavoine on 20/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConnectionViewController.h"
#import "ConnectionUserAction.h"
#import "InscriptionViewController.h"
#import "UITextField+Effects.h"
#import "UIButton+Effects.h"

@interface ConnectionViewController ()

// Outlets
@property (weak, nonatomic) IBOutlet UIView *contentConnectionView;
@property (weak, nonatomic) IBOutlet UITextField *pseudoTextView;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextView;
@property (weak, nonatomic) IBOutlet UIButton *connectionButton;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;

@property (weak, nonatomic) IBOutlet UIView *contentConnectedUserView;

@end

@implementation ConnectionViewController

#pragma mark - View life Cycle
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
    self.passwordTextView.secureTextEntry = YES;
    self.view.backgroundColor = [UIColor clearColor];
}

#pragma mark - Notification

- (void)handleConnecionResponse:(NSNotification *)notification
{
    NSString *response = notification.object;
    NSString *title = @"";
    NSString *message;
    
    if ([response isEqualToString:@""])
    {
        message = LOCALIZED_STRING(@"connection.connection_success.message");
    }
    else
    {
        title = LOCALIZED_STRING(@"globals.error");
        message = response;
    }
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:title
                                  message:message
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:LOCALIZED_STRING(@"globals.ok")
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    [self userIsConnect];
                                }];
    
    [alert addAction:yesButton];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Actions

- (IBAction)connection:(id)sender
{
    if ([self.pseudoTextView.text isEqualToString:@""] || [self.passwordTextView.text isEqualToString:@""])
    {
        [NOTIFICATION_CENTER postNotificationName:EmptyFieldsNotification object:nil];
    }
    else
    {
        [NOTIFICATION_CENTER addObserver:self selector:@selector(handleConnecionResponse:) name:ConnectionReponseNotification object:nil];
        [[NetworkManagement sharedInstance] addNewAction:[ConnectionUserAction action:self.pseudoTextView.text
                                                                             password:self.passwordTextView.text]
                                                  method:POST_METHOD];
    }
}

- (IBAction)pushInscriptionViewController:(id)sender
{
    [NOTIFICATION_CENTER postNotificationName:InscriptionViewNotificiation object:nil];
}


#pragma mark - Utils

- (void)userIsConnect
{
    if (![User sharedInstance].isConnected)
        return;
    
    self.contentConnectionView.hidden = YES;
    self.signUpButton.hidden = YES;
}

- (void)gestureRecognizer:(UISwipeGestureRecognizer *)sender
{
    [self.view endEditing:YES];
}


@end
