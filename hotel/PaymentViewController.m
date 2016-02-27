//
//  PaymentViewController.m
//  Yes I Camp
//
//  Created by Paul Lavoine on 27/02/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "PaymentViewController.h"
#import "UIButton+Effects.h"
#import <CardIO.h>
#import "GetReservationAction.h"

@interface PaymentViewController () <CardIOPaymentViewControllerDelegate>

// Outlets

// Personal information Label
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstNameLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *birthdateLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *countryCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nationalityLabel;

// Card information Label
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cardNumberLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *expirationDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *cvxLabel;

// Personal information TextView
@property (weak, nonatomic) IBOutlet UITextField *nameTextView;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *emailTextView;
@property (weak, nonatomic) IBOutlet UITextField *birthdateTextView;

// Card information TextView
@property (weak, nonatomic) IBOutlet UITextField *cardNumberTextView;
@property (weak, nonatomic) IBOutlet UITextField *expirationDateTextView;
@property (weak, nonatomic) IBOutlet UITextField *cvxTextView;


// Button
@property (weak, nonatomic) IBOutlet UIButton *scanPayButton;
@property (weak, nonatomic) IBOutlet UIButton *paymentButton;

@property (weak, nonatomic) IBOutlet UIView *separatorView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation PaymentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [CardIOUtilities preload];
}

- (void)configureUI
{
    
    NSString *titleButton = [NSString stringWithFormat:@"%@  |  %ld %@",[LOCALIZED_STRING(@"payment.pay.button") uppercaseString], self.amount, LOCALIZED_STRING(@"globals.unity")];
    
    [self.paymentButton addEffectbelowBookButton:titleButton];
}

- (void)didPayReservation:(NSNotification *)notification
{
    NSNumber *statusCode = notification.object;
    NSString *title = @"";
    NSString *message = @"";
    
    if ([statusCode isEqualToNumber:@200])
    {
        title = LOCALIZED_STRING(@"did_reservation_success");
        [[NetworkManagement sharedInstance] addNewAction:[GetReservationAction action] method:GET_METHOD];
    }
    else
    {
        title = LOCALIZED_STRING(@"globals.error");
        message = LOCALIZED_STRING(@"globals.technical_error");
    }
    
    PopUpInformation *informations = [[PopUpInformation alloc] initWithTitle:title
                                                                     message:message
                                                               messageButton:LOCALIZED_STRING(@"globals.ok")
                                                         popToViewController:YES];
    [NOTIFICATION_CENTER postNotificationName:popUpNotification object:informations];
}

#pragma mark - CardIOPaymentViewControllerDelegate

- (void)userDidCancelPaymentViewController:(CardIOPaymentViewController *)scanViewController
{
    //    NSLog(@"User canceled payment info");
    // Handle user cancellation here...
    [scanViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)userDidProvideCreditCardInfo:(CardIOCreditCardInfo *)info inPaymentViewController:(CardIOPaymentViewController *)scanViewController
{
    // The full card number is available as info.cardNumber, but don't log that!
    NSLog(@"Received card info. Number: %@, expiry: %02lu/%lu, cvv: %@.", info.redactedCardNumber, (unsigned long)info.expiryMonth, (unsigned long)info.expiryYear, info.cvv);
    // Use the card info...
    [scanViewController dismissViewControllerAnimated:YES completion:nil];
    
//    [NOTIFICATION_CENTER addObserver:self selector:@selector(didPayReservation:) name:didReservationNotification object:nil];
    
}

#pragma mark - Actions
//- (IBAction)bookDateAction:(id)sender
//{
//    NSString *errorMessage = @"";
//    BOOL isError = YES;
//    if (![User sharedInstance].isConnected)
//    {
//        errorMessage = LOCALIZED_STRING(@"calendarPicker.not_connected.error");
//    }
//    else if ([self.fromDateLabel.text isEqualToString:@""])
//    {
//        errorMessage = LOCALIZED_STRING(@"calendarPicker.date_empty.error");
//    }
//    else
//    {
//        isError = NO;
//    }
//    
//    if (!isError)
//    {
//        CardIOPaymentViewController *scanViewController = [[CardIOPaymentViewController alloc] initWithPaymentDelegate:self];
//        scanViewController.modalPresentationStyle = UIModalPresentationFormSheet;
//        [self presentViewController:scanViewController animated:YES completion:nil];
//    }
//    else
//    {
//        PopUpInformation *informations = [[PopUpInformation alloc] initWithTitle:LOCALIZED_STRING(@"globals.error")
//                                                                         message:errorMessage
//                                                                   messageButton:LOCALIZED_STRING(@"globals.ok")];
//        [NOTIFICATION_CENTER postNotificationName:popUpNotification object:informations];
//    }
//}
//

@end
