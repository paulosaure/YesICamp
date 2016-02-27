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
#import "CountryPicker.h"
#import "UITextField+Effects.h"
#import "UILabel+Effects.h"
#import "UIButton+Effects.h"
#import "LabelWithPadding.h"
#import "UIView+Effects.h"

@interface PaymentViewController () <CardIOPaymentViewControllerDelegate>

// Outlets

// Personal information Label
@property (weak, nonatomic) IBOutlet UILabel *birthdateLabel;
@property (weak, nonatomic) IBOutlet UILabel *countryCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nationalityLabel;

// Personal information TextView
@property (weak, nonatomic) IBOutlet UITextField *nameTextView;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextView;
@property (weak, nonatomic) IBOutlet UITextField *emailTextView;

@property (weak, nonatomic) IBOutlet UIDatePicker *birthDatePickerView;
@property (weak, nonatomic) IBOutlet CountryPicker *countryCodePickerView;
@property (weak, nonatomic) IBOutlet CountryPicker *nationalityPickerView;

// Card information TextView
@property (weak, nonatomic) IBOutlet UILabel *cardNumberNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *expirationDateNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *cvxNumberLabel;

// Button
@property (weak, nonatomic) IBOutlet UIButton *scanPayButton;
@property (weak, nonatomic) IBOutlet UIButton *paymentButton;

// View
@property (weak, nonatomic) IBOutlet UIView *separatorView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;

// Data
@property (nonatomic, strong) CardDetail *cardDetail;
@property (nonatomic, strong) CardRegistration *cardRegistration;

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
    // TextView
    [self.nameTextView addTransparentColorEffect:GREEN_COLOR placeholder:LOCALIZED_STRING(@"inscription.firstname.placeholder")];
    [self.firstNameTextView addTransparentColorEffect:GREEN_COLOR placeholder:LOCALIZED_STRING(@"inscription.lastname.placeholder")];
    [self.emailTextView addTransparentColorEffect:GREEN_COLOR placeholder:LOCALIZED_STRING(@"inscription.lastname.placeholder")];
    
    // Populate text fields
    User *user = [User sharedInstance];
    if (user)
    {
        self.nameTextView.text = user.lastName;
        self.firstNameTextView.text = user.firstName;
        self.emailTextView.text = user.email;
    }
    
    // Label
    [self.cardNumberNumberLabel addTransparentColorEffect:GREEN_COLOR placeHolder:LOCALIZED_STRING(@"payment.card_number.placeholder")];
    [self.expirationDateNumberLabel addTransparentColorEffect:GREEN_COLOR placeHolder:LOCALIZED_STRING(@"payment.card_expiration_date.placeholder")];
    [self.cvxNumberLabel addTransparentColorEffect:GREEN_COLOR placeHolder:LOCALIZED_STRING(@"payment.card_cvx.placeholder")];
    
    // PickerView
    self.birthdateLabel.text = LOCALIZED_STRING(@"payment.birthdate.label");
    self.nationalityLabel.text = LOCALIZED_STRING(@"payment.nationality.label");
    self.countryCodeLabel.text = LOCALIZED_STRING(@"payment.countryCode.label");
    [self.birthDatePickerView addTransparentColorEffect:GREEN_COLOR];
    [self.nationalityPickerView addTransparentColorEffect:GREEN_COLOR];
    [self.countryCodePickerView addTransparentColorEffect:GREEN_COLOR];
    
    
    [self.birthDatePickerView setValue:[UIColor whiteColor] forKey:@"textColor"];
    
    NSString *titleButton = [NSString stringWithFormat:@"%@  |  %ld %@",[LOCALIZED_STRING(@"payment.pay.button") uppercaseString], (long)self.amount, LOCALIZED_STRING(@"globals.unity")];
    
    // Button
    [self.paymentButton addEffectbelowBookButton:titleButton];
    [self.scanPayButton addColorEffect:GREEN_COLOR text:LOCALIZED_STRING(@"payment.scan_credit_card.button")];
    
    // View
    self.separatorView.backgroundColor = GREEN_COLOR;
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
    // Register card info
    NSString *expirationDate = [NSString stringWithFormat:@"%02lu/%lu", (unsigned long)info.expiryMonth, (unsigned long)info.expiryYear];
    self.cardDetail.cardNumber = info.cardNumber;
    self.cardDetail.cardExpirationDate = expirationDate;
    self.cardDetail.cardCvx = info.cvv;
    
    // Popoulate UI
    self.cardNumberNumberLabel.text = info.cardNumber;
    self.expirationDateNumberLabel.text = expirationDate;
    self.cvxNumberLabel.text = info.cvv;
    
    [scanViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Actions
- (IBAction)scanCreditCardAction:(id)sender
{
    CardIOPaymentViewController *scanViewController = [[CardIOPaymentViewController alloc] initWithPaymentDelegate:self];
    scanViewController.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:scanViewController animated:YES completion:nil];
}

- (IBAction)payButton:(id)sender {
        
}


@end
