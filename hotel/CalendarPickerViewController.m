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

@interface CalendarPickerViewController () <DSLCalendarViewDelegate>

@property (nonatomic, weak) IBOutlet DSLCalendarView *calendarView;
@property (weak, nonatomic) IBOutlet UIButton *bookDateButton;

@property (weak, nonatomic) IBOutlet LabelWithPadding *fromWordLabel;
@property (weak, nonatomic) IBOutlet LabelWithPadding *toWordLabel;
@property (weak, nonatomic) IBOutlet UILabel *fromDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *toDateLabel;

@end

@implementation CalendarPickerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.calendarView.delegate = self;
    [self configureUI];
}

- (void)configureUI
{
    self.view.backgroundColor = BLACK_COLOR;
    
    self.fromWordLabel.text = [[NSString stringWithFormat:@"%@ : ",LOCALIZED_STRING(@"calendarPicker.from_date.label")] uppercaseString];
    self.fromDateLabel.text = [@"" uppercaseString];
    [self.fromWordLabel addTransparentColorEffect:GREEN_COLOR];
    self.fromDateLabel.textColor = [UIColor whiteColor];
    
    self.toWordLabel.text = [[NSString stringWithFormat:@"%@ : ",LOCALIZED_STRING(@"calendarPicker.to_date.label")] uppercaseString];
    self.toDateLabel.text = [@"" uppercaseString];
    [self.toWordLabel addTransparentColorEffect:GREEN_COLOR];
    self.toDateLabel.textColor = [UIColor whiteColor];
    
    NSString *titleButton = [NSString stringWithFormat:@"%@  |  %@ %@",[LOCALIZED_STRING(@"calendarPicker.pay.button") uppercaseString], self.offer.price, LOCALIZED_STRING(@"global.price_unity.label")];
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
//    if (NO) { // Only select a single day
//        return [[DSLCalendarRange alloc] initWithStartDay:day endDay:day];
//    }
//    else if (YES) {
    // Don't allow selections before today
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
//    }
    
//    return range;
}

- (void)calendarView:(DSLCalendarView *)calendarView willChangeToVisibleMonth:(NSDateComponents *)month duration:(NSTimeInterval)duration
{
    NSLog(@"Will show %@ in %.3f seconds", month, duration);
}

- (void)calendarView:(DSLCalendarView *)calendarView didChangeToVisibleMonth:(NSDateComponents *)month
{
    NSLog(@"Now showing %@", month);
}

- (BOOL)day:(NSDateComponents*)day1 isBeforeDay:(NSDateComponents*)day2
{
    return ([day1.date compare:day2.date] == NSOrderedAscending);
}

#pragma mark - Actions
- (IBAction)bookDateAction:(id)sender
{
}

#pragma mark - Utils
- (void)updateDateLabelFrom:(NSString *)from to:(NSString *)to
{
    self.fromDateLabel.text = [from uppercaseString];
    self.toDateLabel.text = [to uppercaseString];
}


@end
