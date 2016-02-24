//
//  CalendarPickerViewController.m
//  Yes I Camp
//
//  Created by Paul Lavoine on 18/02/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "CalendarPickerViewController.h"
#import "DSLCalendarView.h"
#import "UIButton+Effects.h"
#import "UILabel+Effects.h"
#import "DateLabelWithPadding.h"
#import <CardIO.h>
#import "MakeReservationAction.h"

@interface CalendarPickerViewController () <DSLCalendarViewDelegate, CardIOPaymentViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet DSLCalendarView *calendarView;
@property (weak, nonatomic) IBOutlet UIButton *bookDateButton;

@property (weak, nonatomic) IBOutlet DateLabelWithPadding *fromWordLabel;
@property (weak, nonatomic) IBOutlet DateLabelWithPadding *toWordLabel;
@property (weak, nonatomic) IBOutlet UILabel *fromDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *toDateLabel;

@end

@implementation CalendarPickerViewController

#pragma mark - View lifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.calendarView.delegate = self;
    [self configureUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [CardIOUtilities preload];
}

#pragma mark - Configuration

- (void)configureUI
{
    self.titleLabel.text = LOCALIZED_STRING(@"calendarPicker.select_date.title");
    self.titleLabel.textColor = GREEN_COLOR;
    
    self.view.backgroundColor = BLACK_COLOR;
    
    self.fromWordLabel.text = [[NSString stringWithFormat:@"%@ : ",LOCALIZED_STRING(@"calendarPicker.from_date.label")] uppercaseString];
    self.fromDateLabel.text = [@"" uppercaseString];
    [self.fromWordLabel addTransparentColorEffect:GREEN_COLOR];
    self.fromDateLabel.textColor = [UIColor whiteColor];
    
    self.toWordLabel.text = [[NSString stringWithFormat:@"%@ : ",LOCALIZED_STRING(@"calendarPicker.to_date.label")] uppercaseString];
    self.toDateLabel.text = [@"" uppercaseString];
    [self.toWordLabel addTransparentColorEffect:GREEN_COLOR];
    self.toDateLabel.textColor = [UIColor whiteColor];
    
    NSString *titleButton = [NSString stringWithFormat:@"%@  |  %@ %@",[LOCALIZED_STRING(@"calendarPicker.pay.button") uppercaseString], self.offer.price, LOCALIZED_STRING(@"globals.unity")];
    [self.bookDateButton addEffectbelowBookButton:titleButton];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - DSLCalendarViewDelegate methods

- (void)calendarView:(DSLCalendarView *)calendarView didSelectRange:(DSLCalendarRange *)range
{
    if (range != nil)
    {
        NSString *fromDate = [NSString stringWithFormat:@"%ld/%ld/%ld",(long)range.startDay.day, (long)range.startDay.month, (long)range.startDay.year];
        NSString *toDate = [NSString stringWithFormat:@"%ld/%ld/%ld",(long)range.endDay.day, (long)range.endDay.month, (long)range.startDay.year];
        [self updateDateLabelFrom:fromDate to:toDate];
    }
    else
    {
        NSLog( @"No selection" );
    }
}

- (DSLCalendarRange*)calendarView:(DSLCalendarView *)calendarView didDragToDay:(NSDateComponents *)day selectingRange:(DSLCalendarRange *)range
{
    NSDateComponents *today = [[NSDate date] dslCalendarView_dayWithCalendar:calendarView.visibleMonth.calendar];
    
    NSDateComponents *startDate = range.startDay;
    NSDateComponents *endDate = range.endDay;
    
    if ([self day:startDate isBeforeDay:today] && [self day:endDate isBeforeDay:today]) {
        return nil;
    }
    else {
        if ([self day:startDate isBeforeDay:today]) {
            startDate = [today copy];
        }
        if ([self day:endDate isBeforeDay:today]) {
            endDate = [today copy];
        }
        
        return [[DSLCalendarRange alloc] initWithStartDay:startDate endDay:endDate];
    }
}

- (void)calendarView:(DSLCalendarView *)calendarView willChangeToVisibleMonth:(NSDateComponents *)month duration:(NSTimeInterval)duration
{
    //    NSLog(@"Will show %@ in %.3f seconds", month, duration);
}

- (void)calendarView:(DSLCalendarView *)calendarView didChangeToVisibleMonth:(NSDateComponents *)month
{
    //    NSLog(@"Now showing %@", month);
}

- (BOOL)day:(NSDateComponents*)day1 isBeforeDay:(NSDateComponents*)day2
{
    return ([day1.date compare:day2.date] == NSOrderedAscending);
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
    
    [NOTIFICATION_CENTER addObserver:self selector:@selector(didBookReservation:) name:didReservationNotification object:nil];
    
#warning TODO
    [[NetworkManagement sharedInstance] addNewAction:[MakeReservationAction actionWithDateBegin:@""
                                                                                      dateEnd:@""
                                                                           redactedCardNumber:@""
                                                                                  expiryMonth:@""
                                                                                   expiryYear:@""
                                                                                          cvv:@""]
                                              method:POST_METHOD];
}

#pragma mark - Notification

- (void)didBookReservation:(NSNotification *)notification
{
    [NOTIFICATION_CENTER postNotificationName:EmptyFieldsNotification object:notification.object];
#warning TODO 
    // Pop to parent controller et afficher la liste des réservation avec celle qu'on vient de faire
}

#pragma mark - Actions
- (IBAction)bookDateAction:(id)sender
{
    NSString *errorMessage = @"";
    BOOL isError = YES;
    if (![User sharedInstance].isConnected)
    {
        errorMessage = LOCALIZED_STRING(@"calendarPicker.not_connected.error");
    }
    else if ([self.fromDateLabel.text isEqualToString:@""])
    {
        errorMessage = LOCALIZED_STRING(@"calendarPicker.date_empty.error");
    }
    else
    {
        isError = NO;
    }
    
    if (!isError)
    {
        CardIOPaymentViewController *scanViewController = [[CardIOPaymentViewController alloc] initWithPaymentDelegate:self];
        scanViewController.modalPresentationStyle = UIModalPresentationFormSheet;
        [self presentViewController:scanViewController animated:YES completion:nil];
    }
    else
    {
        [NOTIFICATION_CENTER postNotificationName:EmptyFieldsNotification object:errorMessage];
    }
}

#pragma mark - Utils
- (void)updateDateLabelFrom:(NSString *)from to:(NSString *)to
{
    self.fromDateLabel.text = [from uppercaseString];
    self.toDateLabel.text = [to uppercaseString];
}


@end
