//
//  ScrollPagesViewController.h
//  hotel
//
//  Created by Paul Lavoine on 25/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LPViewPagerController.h"

typedef NS_ENUM(NSInteger, PageController) {
    PageControllerAccount,
    PageControllerPromo,
    PageControllerHotDeal
};

@interface ScrollPagesViewController : LPViewPagerController

- (void)didSelectedTitleAtIndex:(NSUInteger)index;

@end
