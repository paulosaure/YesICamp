//
//  UILabel+Effects.h
//  Yes I Camp
//
//  Created by Paul Lavoine on 21/02/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Effects)

- (void)addTransparentColorEffect:(UIColor *)color;
- (void)addTransparentColorEffect:(UIColor *)color placeHolder:(NSString *)placeHolder;

@end
