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
#import "LabelWithPadding.h"
#import "BookReservationAction.h"
#import "PaymentViewController.h"
#import <NSAttributedString+CCLFormat.h>

#define DATE_FORMAT_SERVER  @"%ld-%ld-%ld"
#define DATE_FORMAT_DISPLAYED       @"%ld/%ld/%ld"

@interface CalendarPickerViewController () <DSLCalendarViewDelegate>

// Outlets
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet DSLCalendarView *calendarView;
@property (weak, nonatomic) IBOutlet UIButton *checkDateValidityButton;

@property (weak, nonatomic) IBOutlet LabelWithPadding *fromWordLabel;
@property (weak, nonatomic) IBOutlet LabelWithPadding *toWordLabel;
@property (weak, nonatomic) IBOutlet UILabel *fromDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *toDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *explicationLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelTopVerticalConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelBottomVerticalConstraint;

// Data
@property (strong, nonatomic) NSString *fromDate;
@property (strong, nonatomic) NSString *toDate;

@end

@implementation CalendarPickerViewController

#pragma mark - View lifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.calendarView.delegate = self;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *maxDate = [dateFormatter dateFromString:self.offer.end];
    self.calendarView.maxPossibleDate = [maxDate dslCalendarView_dayWithCalendar:self.calendarView.visibleMonth.calendar];
    [self configureUI];
}

#pragma mark - Configuration

- (void)configureUI
{
    NSDictionary *dateAttributes = @{
                                     NSForegroundColorAttributeName:GREEN_COLOR
                                     };
    NSAttributedString *dateBegin = [[NSAttributedString alloc] initWithString:self.offer.begin
                                                                    attributes:dateAttributes];
    NSAttributedString *dateEnd = [[NSAttributedString alloc] initWithString:self.offer.end
                                                                  attributes:dateAttributes];
    
    self.titleLabel.attributedText = [NSAttributedString attributedStringWithFormat:LOCALIZED_STRING(@"calendarPicker.select_date.title"), dateBegin, dateEnd];
    
    self.view.backgroundColor = BLACK_COLOR;
    
    self.fromWordLabel.text = [[NSString stringWithFormat:@"%@ : ",LOCALIZED_STRING(@"calendarPicker.from_date.label")] uppercaseString];
    self.fromDateLabel.text = [@"" uppercaseString];
    [self.fromWordLabel addTransparentColorEffect:GREEN_COLOR];
    self.fromDateLabel.textColor = [UIColor whiteColor];
    
    self.toWordLabel.text = [[NSString stringWithFormat:@"%@ : ",LOCALIZED_STRING(@"calendarPicker.to_date.label")] uppercaseString];
    self.toDateLabel.text = [@"" uppercaseString];
    [self.toWordLabel addTransparentColorEffect:GREEN_COLOR];
    self.toDateLabel.textColor = [UIColor whiteColor];
    
    self.explicationLabel.text = LOCALIZED_STRING(@"calendarPicker.explication.label");
    self.explicationLabel.textColor = [UIColor whiteColor];
    
    NSString *titleButton = [NSString stringWithFormat:@"%@  |  %@ %@ %@",[LOCALIZED_STRING(@"calendarPicker.checkValidity.button") uppercaseString], self.offer.price, LOCALIZED_STRING(@"globals.unity"), LOCALIZED_STRING(@"calendarPicker.price_per_night.information")];
    [self.checkDateValidityButton addEffectbelowBookButton:titleButton];
    
    [self isSearching:NO];
    
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    /*Do iPhone 4 stuff here.*/
    if (screenSize.height <= 480.0f) {
        self.titleLabelTopVerticalConstraint.constant = 0;
        self.titleLabelBottomVerticalConstraint.constant = 0;
        
        // Set navigation bar title
        self.title = [NSString stringWithFormat:LOCALIZED_STRING(@"calendarPicker.select_date.short_title"), self.offer.begin, self.offer.end];
        [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                          NSFontAttributeName:[UIFont systemFontOfSize:14 weight:400],
                                                                          NSForegroundColorAttributeName:GREEN_COLOR
                                                                          }];
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [NOTIFICATION_CENTER removeObserver:self];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - DSLCalendarViewDelegate methods

- (void)calendarView:(DSLCalendarView *)calendarView didSelectRange:(DSLCalendarRange *)range
{
    [self initDate];
    
    if (range != nil)
    {
        // Record date with good format for serveur
        self.fromDate = [NSString stringWithFormat:DATE_FORMAT_SERVER, (long)range.startDay.year, (long)range.startDay.month, (long)range.startDay.day];
        
        // Display Date
        NSString *fromDate = [NSString stringWithFormat:DATE_FORMAT_DISPLAYED,(long)range.startDay.day, (long)range.startDay.month, (long)range.startDay.year];
        NSString *toDate = @"";
        
        if (![range.startDay isEqual:range.endDay])
        {
            self.toDate = [NSString stringWithFormat:DATE_FORMAT_SERVER, (long)range.endDay.year, (long)range.endDay.month, (long)range.endDay.day];
            toDate = [NSString stringWithFormat:DATE_FORMAT_DISPLAYED,(long)range.endDay.day, (long)range.endDay.month, (long)range.startDay.year];
            
        }
        
        [self updateDateLabelFrom:fromDate to:toDate];
    }
    else
    {
        NSLog( @"No selection" );
    }
}

- (DSLCalendarRange*)calendarView:(DSLCalendarView *)calendarView didDragToDay:(NSDateComponents *)day selectingRange:(DSLCalendarRange *)range
{
    [self initDate];
    
    NSDateComponents *today = [[NSDate date] dslCalendarView_dayWithCalendar:calendarView.visibleMonth.calendar];
    
    NSDateComponents *startDate = range.startDay;
    NSDateComponents *endDate = range.endDay;
    
    if (([self day:startDate isBeforeDay:today] && [self day:endDate isBeforeDay:today])
        || ([self day:calendarView.maxPossibleDate isBeforeDay:startDate])
        || ([self day:calendarView.maxPossibleDate isBeforeDay:endDate]))
    {
        return nil;
    }
    else
    {
        if ([self day:startDate isBeforeDay:today])
        {
            startDate = [today copy];
        }
        if ([self day:endDate isBeforeDay:today])
        {
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

#pragma mark - Actions

- (IBAction)checkValidityDateAction:(id)sender
{
    NSString *errorMessage = @"";
    if (![User sharedInstance].isConnected)
    {
        errorMessage = LOCALIZED_STRING(@"calendarPicker.not_connected.error");
    }
    else if ([self.fromDateLabel.text isEqualToString:@""])
    {
        errorMessage = LOCALIZED_STRING(@"calendarPicker.date_empty.error");
    }
    else if ([self.fromDate isEqualToString:self.toDate])
    {
        errorMessage = LOCALIZED_STRING(@"calendarPicker.same_date.error");
    }
    else if (self.fromDate == nil || self.toDate == nil)
    {
        errorMessage = LOCALIZED_STRING(@"calendarPicker.pick_two_date.error");
    }
    
    if (![errorMessage isEqualToString:@""])
    {
        PopUpInformation *information = [[PopUpInformation alloc] initWithTitle:LOCALIZED_STRING(@"globals.error")
                                                                        message:errorMessage
                                                                  messageButton:LOCALIZED_STRING(@"globals.ok")];
        
        UIAlertController * alert =  [UIAlertController
                                      alertControllerWithTitle:information.title
                                      message:information.message
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:information.messageButton
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action)
                                    {
                                    }];
        
        [alert addAction:yesButton];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else
    {
        [self isSearching:YES];
        [NOTIFICATION_CENTER addObserver:self selector:@selector(didBookReservationSucceded:) name:didBookReservationSuccededNotification object:nil];
        [NOTIFICATION_CENTER addObserver:self selector:@selector(didBookReservationFailed:) name:didBookReservationFailedNotification object:nil];
        
        [[NetworkManagement sharedInstance] addNewAction:[BookReservationAction actionWithOfferId:[self.offer.uid stringValue]
                                                                                        dateBegin:self.fromDate
                                                                                          dateEnd:self.toDate]
                                                  method:POST_METHOD];
    }
}

#pragma mark - Notifications

- (void)didBookReservationSucceded:(NSNotification *)notification
{
    [self isSearching:NO];
    PaymentViewController *paymentViewController = (PaymentViewController *)[[UIStoryboard storyboardWithName:MAIN_STORYBOARD bundle:nil] instantiateViewControllerWithIdentifier:PaymentViewControllerID];
    
    paymentViewController.bookingId = [notification.object integerValue];
    paymentViewController.amount = ([self numberOfDaysBetween:self.fromDate end:self.toDate] + 1) * [self.offer.price integerValue];
    
    [self.navigationController pushViewController:paymentViewController animated:YES];
}

- (void)didBookReservationFailed:(NSNotification *)notification
{
    [self isSearching:NO];
    NSString *errorMessage = (notification.object) ? notification.object : LOCALIZED_STRING(@"calendarPicker.book_not_possible.error");
    PopUpInformation *informations = [[PopUpInformation alloc] initWithTitle:LOCALIZED_STRING(@"globals.error")
                                                                     message:errorMessage
                                                               messageButton:LOCALIZED_STRING(@"globals.ok")];
    [NOTIFICATION_CENTER postNotificationName:popUpNotification object:informations];
}

#pragma mark - Utils

- (void)isSearching:(BOOL)isSearching
{
    self.spinner.hidden = !isSearching;
    self.checkDateValidityButton.hidden = isSearching;
    isSearching ? [self.spinner startAnimating] : [self.spinner stopAnimating];
}

- (NSInteger)numberOfDaysBetween:(NSString *)start end:(NSString *)end
{
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"yyyy-MM-dd"];
    NSDate *startDate = [f dateFromString:start];
    NSDate *endDate = [f dateFromString:end];
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay
                                                        fromDate:startDate
                                                          toDate:endDate
                                                         options:NSCalendarWrapComponents];
    
    return [components day];
}

- (void)initDate
{
    self.fromDate = nil;
    self.toDate = nil;
    NSString *toDate = @"";
    NSString *fromDate = @"";
    [self updateDateLabelFrom:fromDate to:toDate];
}

- (void)updateDateLabelFrom:(NSString *)from to:(NSString *)to
{
    self.fromDateLabel.text = [from uppercaseString];
    self.toDateLabel.text = [to uppercaseString];
}

@end
