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
#import "GlobalConfiguration.h"

#import "UITextField+Effects.h"
#import "UILabel+Effects.h"
#import "UIButton+Effects.h"
#import "LabelWithPadding.h"
#import "UIView+Effects.h"

#import "SendCardRegistrationAction.h"
#import "SendRegistrationDataAction.h"
#import "SendCardDetailAction.h"

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
@property (nonatomic, strong) NSString *codeCountry;
@property (nonatomic, strong) NSString *currency;
@property (nonatomic, assign) CardIOCreditCardType cardType;

@end

@implementation PaymentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configureNotification];
    [self configureUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [CardIOUtilities preload];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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
    [self.birthDatePickerView setMaximumDate:[NSDate date]];
    [self.birthDatePickerView setDate:[NSDate date] animated:YES];
    [self.birthDatePickerView addTransparentColorEffect:GREEN_COLOR];
    
    //Set Color of Date Picker
    [self.birthDatePickerView setValue:[UIColor whiteColor] forKeyPath:@"textColor"];
    SEL selector = NSSelectorFromString(@"setHighlightsToday:");
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDatePicker instanceMethodSignatureForSelector:selector]];
    BOOL no = NO;
    [invocation setSelector:selector];
    [invocation setArgument:&no atIndex:2];
    [invocation invokeWithTarget:self.birthDatePickerView];
    
    NSLocale *currentLocale = [NSLocale currentLocale];
    NSString *countryCode = [currentLocale objectForKey:NSLocaleCountryCode];
    
    self.nationalityLabel.text = LOCALIZED_STRING(@"payment.nationality.label");
    [self.nationalityPickerView setSelectedCountryCode:countryCode];
    [self.nationalityPickerView addTransparentColorEffect:GREEN_COLOR];
    
    self.countryCodeLabel.text = LOCALIZED_STRING(@"payment.countryCode.label");
    [self.countryCodePickerView setSelectedCountryCode:countryCode];
    [self.countryCodePickerView addTransparentColorEffect:GREEN_COLOR];
    
    NSString *titleButton = [NSString stringWithFormat:@"%@  |  %ld %@",[LOCALIZED_STRING(@"payment.pay.button") uppercaseString], (long)self.amount, LOCALIZED_STRING(@"globals.unity")];
    
    // Button
    [self.paymentButton addEffectbelowBookButton:titleButton];
    [self.scanPayButton addColorEffect:GREEN_COLOR text:LOCALIZED_STRING(@"payment.scan_credit_card.button")];
    
    // View
    self.separatorView.backgroundColor = GREEN_COLOR;
}

- (void)configureNotification
{
    [NOTIFICATION_CENTER addObserver:self selector:@selector(didReceiveCardRegistrationSucceded:) name:didReceiveCardRegistrationSuccededNotification object:nil];
    [NOTIFICATION_CENTER addObserver:self selector:@selector(didReceiveCardRegistrationFailed:) name:didReceiveCardRegistrationFailedNotification object:nil];
    
    [NOTIFICATION_CENTER addObserver:self selector:@selector(didReceiveRegistrationDataSucceded:) name:didReceiveRegistrationDataSuccededNotification object:nil];
    [NOTIFICATION_CENTER addObserver:self selector:@selector(didReceiveRegistrationDataFailed:) name:didReceiveRegistrationDataFailedNotification object:nil];
    
    [NOTIFICATION_CENTER addObserver:self selector:@selector(didPaymentSucceded:) name:didPaymentSuccededNotification object:nil];
    [NOTIFICATION_CENTER addObserver:self selector:@selector(didPaymentFailed:) name:didPaymentFailedNotification object:nil];
}

#pragma mark - CardIOPaymentViewControllerDelegate

- (void)userDidCancelPaymentViewController:(CardIOPaymentViewController *)scanViewController
{
    [scanViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)userDidProvideCreditCardInfo:(CardIOCreditCardInfo *)info inPaymentViewController:(CardIOPaymentViewController *)scanViewController
{
    // Register card info
    NSString *expirationDate = [NSString stringWithFormat:@"%02lu/%lu", (unsigned long)info.expiryMonth, (unsigned long)info.expiryYear];
    self.cardDetail = [[CardDetail alloc] init];
    self.cardDetail.cardNumber = info.cardNumber;
    self.cardDetail.cardExpirationDate = expirationDate;
    self.cardDetail.cardCvx = info.cvv;
    self.cardType = info.cardType;

     // TODO TMP
    self.currency = @"EUR";
    
    // Popoulate UI
    self.cardNumberNumberLabel.text = info.cardNumber;
    self.expirationDateNumberLabel.text = expirationDate;
    self.cvxNumberLabel.text = info.cvv;
    
    [scanViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Notifications

- (void)didReceiveCardRegistrationSucceded:(NSNotification *)notification
{
    NSLog(@"didReceiveCardRegistrationSucceded");
    NSLog(@"On envoie la requete avec le card detail");
    self.cardRegistration = notification.object;
    [[NetworkManagement sharedInstance] addNewAction:[SendCardDetailAction actionSendCardDetail:self.cardDetail cardRegistration:self.cardRegistration] method:POST_METHOD];
}

- (void)didReceiveCardRegistrationFailed:(NSNotification *)notification
{
    NSLog(@"didReceiveCardRegistrationFailed");
}

- (void)didReceiveRegistrationDataSucceded:(NSNotification *)notification
{
    NSLog(@"didReceiveRegistrationDataSucceded");
    NSLog(@"On envoie la requete registration data");
    [[NetworkManagement sharedInstance] addNewAction:[SendRegistrationDataAction actionSendRegistrationData:self.cardRegistration bookingId:[@(self.bookingId) stringValue]] method:POST_METHOD];
}

- (void)didReceiveRegistrationDataFailed:(NSNotification *)notification
{
    NSLog(@"didReceiveRegistrationDataFailed");
}

- (void)didPaymentSucceded:(NSNotification *)notification
{
    NSLog(@"didPaymentSucceded");
    [[NetworkManagement sharedInstance] addNewAction:[GetReservationAction action] method:GET_METHOD];
    PopUpInformation *informations = [[PopUpInformation alloc] initWithTitle:LOCALIZED_STRING(@"did_reservation_success")
                                                                     message:@""
                                                               messageButton:LOCALIZED_STRING(@"globals.ok")
                                                         popToViewController:YES];
    [NOTIFICATION_CENTER postNotificationName:popUpNotification object:informations];
}

- (void)didPaymentFailed:(NSNotification *)notification
{
    NSLog(@"didPaymentFailed");
    PopUpInformation *informations = [[PopUpInformation alloc] initWithTitle:LOCALIZED_STRING(@"globals.error")
                                                                     message:LOCALIZED_STRING(@"globals.technical_error")
                                                               messageButton:LOCALIZED_STRING(@"globals.ok")
                                                         popToViewController:YES];
    [NOTIFICATION_CENTER postNotificationName:popUpNotification object:informations];
}

#pragma mark - Actions
- (IBAction)scanCreditCardAction:(id)sender
{
    CardIOPaymentViewController *scanViewController = [[CardIOPaymentViewController alloc] initWithPaymentDelegate:self];
    scanViewController.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:scanViewController animated:YES completion:nil];
}

- (IBAction)payButton:(id)sender
{
    if (![self.cardNumberNumberLabel.text isEqualToString:@""] &
        ![self.expirationDateNumberLabel.text isEqualToString:@""] &
        ![self.cvxNumberLabel.text isEqualToString:@""] &
        ![self.nameTextView.text isEqualToString:@""] &
        ![self.firstNameTextView.text isEqualToString:@""] &
        ![self.emailTextView.text isEqualToString:@""])
    {
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        NSString *date = [dateFormat stringFromDate:self.birthDatePickerView.date];
        
        PaymentForm *paymentForm = [[PaymentForm alloc] initWithBookingID:[@(self.bookingId) stringValue]
                                                                firstname:self.firstNameTextView.text
                                                                 lastname:self.nameTextView.text
                                                                    email:self.emailTextView.text
                                                                 birthday:date
                                                              nationality:self.nationalityPickerView.selectedCountryName
                                                       countryOfResidence:self.countryCodePickerView.selectedCountryName
                                                                 currency:self.currency
                                                                 cardType:[[GlobalConfiguration class] cardTypeWithCardIOCreditCardType:self.cardType]];
        
        [[NetworkManagement sharedInstance] addNewAction:[SendCardRegistrationAction actionSendCardRegistration:paymentForm] method:POST_METHOD];
    }
}


@end
