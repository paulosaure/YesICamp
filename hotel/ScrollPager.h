//
//  ScrollPager.h
//  hotel
//
//  Created by Paul Lavoine on 24/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import <UIKit/UIKit.h>

#define VIEWS_KEY @"viewsKey"
#define BUTTONS_KEY @"buttonsKey"

@class ScrollPager;

@protocol ScrollPagerDelegate <NSObject>

- (void)scrollPager:(ScrollPager *)scrollpager changedIndex:(NSInteger)changedIndex;

@end

@interface ScrollPager : UIView

@property (nonatomic, weak) IBOutlet id<ScrollPagerDelegate> delegate;

- (void)addSegmentsWithViews:(NSArray *)segments;
- (void)addSegmentsWithTitles:(NSArray *)segmentTitles;
- (void)addSegmentsWithImages:(NSArray *)segmentImages;

@end
