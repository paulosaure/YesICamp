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
#import "ReservationCell.h"
#import "GetReservationAction.h"

@interface ConnectionViewController () <UITableViewDataSource, UITableViewDelegate>

// Outlets
@property (weak, nonatomic) IBOutlet UIView *contentConnectionView;
@property (weak, nonatomic) IBOutlet UITextField *pseudoTextView;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextView;
@property (weak, nonatomic) IBOutlet UIButton *connectionButton;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ConnectionViewController

#pragma mark - View life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureUI];
    
    // Configure table View
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 200;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerNib:[ReservationCell cellNib] forCellReuseIdentifier:RESERVATION_CELL_IDENTIFIER];
    
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
    self.tableView.hidden = YES;
    self.view.backgroundColor = [UIColor clearColor];
    
    self.tableView.backgroundColor = [UIColor clearColor];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;//[[User sharedInstance].reservations count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Dequeue cell
    ReservationCell *cell = [tableView dequeueReusableCellWithIdentifier:RESERVATION_CELL_IDENTIFIER];
    
    // Configure celle
    [cell configureWithReservation:[User sharedInstance].reservations[indexPath.row] isLast:(indexPath.row + 1 == [[User sharedInstance].reservations count])];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 18)];
    [label setFont:[UIFont boldSystemFontOfSize:15]];
    label.textColor = [UIColor whiteColor];
    NSString *string = [[NSString stringWithFormat:@"%@",LOCALIZED_STRING(@"connection.header_section.title")] uppercaseString];
    
    [label setText:string];
    [view addSubview:label];
    [view setBackgroundColor:GREEN_COLOR];
    return view;
}

#pragma mark - UITableViewDelegate


#pragma mark - Notifications

- (void)didReceiveReservations:(NSNotification *)notification
{
    NSLog(@"ok");
}

- (void)handleConnectionResponse:(NSNotification *)notification
{
    NSString *response = notification.object;
    NSString *title = @"";
    NSString *message;

    if ([response isEqualToString:@""])
    {
        message = LOCALIZED_STRING(@"connection.connection_success.message");
        [User sharedInstance].isConnected = YES;
        [self userIsConnect:YES];
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
                                    
                                }];
    
    [alert addAction:yesButton];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Actions

- (IBAction)connection:(id)sender
{
    if ([self.pseudoTextView.text isEqualToString:@""] || [self.passwordTextView.text isEqualToString:@""])
    {
        [NOTIFICATION_CENTER postNotificationName:EmptyFieldsNotification object:LOCALIZED_STRING(@"homePage.error.fielsEmpty")];
    }
    else
    {
        [NOTIFICATION_CENTER addObserver:self selector:@selector(handleConnectionResponse:) name:ConnectionReponseNotification object:nil];
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

- (void)userIsConnect:(BOOL)isConnected
{
    self.contentConnectionView.hidden = isConnected;
    self.signUpButton.hidden = isConnected;
    self.tableView.hidden = !isConnected;
    
    if (isConnected)
    {
        [NOTIFICATION_CENTER addObserver:self selector:@selector(didReceiveReservations:) name:ReservationListNotification object:nil];
        [[NetworkManagement sharedInstance] addNewAction:[GetReservationAction action] method:GET_METHOD];
    }
}

- (void)gestureRecognizer:(UISwipeGestureRecognizer *)sender
{
    [self.view endEditing:YES];
}


@end
