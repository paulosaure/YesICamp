//
//  HotDealViewController.h
//  hotel
//
//  Created by Paul Lavoine on 24/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import <UIKit/UIKit.h>

#define HotDealViewControllerID @"HotDealViewControllerID"
#define HotDealSelectedNotification @"HotDealSelectedNotification"

@class ScrollPagesViewController;

@interface HotDealViewController : UIViewController

- (void)centerMapViewOnUserLocation;

@property (nonatomic, strong) ScrollPagesViewController *parent;

@end
