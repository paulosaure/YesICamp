//
//  CalendarPickerViewController.h
//  Yes I Camp
//
//  Created by Paul Lavoine on 18/02/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CalendarPickerNotification  @"CalendarPickerNotification"
#define CalendarPickerID            @"CalendarPickerID"

@interface CalendarPickerViewController : UIViewController

@property (nonatomic, strong) Offer *offer;

@end
