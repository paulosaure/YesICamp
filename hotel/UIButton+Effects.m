//
//  UIButton+Effects.m
//  Yes I Camp
//
//  Created by Paul Lavoine on 01/02/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "UIButton+Effects.h"

@implementation UIButton (Effects)

- (void)addColorEffect:(UIColor *)color text:(NSString *)text
{
    [self setTitle:text forState:UIControlStateNormal];
    [self setTitleColor:TINT_COLOR forState:UIControlStateNormal];
    self.backgroundColor = [color colorWithAlphaComponent:0.5f];
    self.layer.cornerRadius = 5.0f;
}

@end
