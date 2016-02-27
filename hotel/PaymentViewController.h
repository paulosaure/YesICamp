//
//  PaymentViewController.h
//  Yes I Camp
//
//  Created by Paul Lavoine on 27/02/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import <UIKit/UIKit.h>

#define PaymentViewNotification             @"PaymentViewNotification"
#define PaymentViewControllerID            @"PaymentViewControllerID"

@interface PaymentViewController : UIViewController

@property (nonatomic, assign) NSInteger bookingId;
@property (nonatomic, assign) NSInteger amount;

@end
