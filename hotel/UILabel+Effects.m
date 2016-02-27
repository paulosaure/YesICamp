//
//  UILabel+Effects.m
//  Yes I Camp
//
//  Created by Paul Lavoine on 21/02/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "UILabel+Effects.h"

@implementation UILabel (Effects)

- (void)addTransparentColorEffect:(UIColor *)color placeHolder:(NSString *)placeHolder
{
    [self addTransparentColorEffect:color];
    self.text = placeHolder;
}

- (void)addTransparentColorEffect:(UIColor *)color
{
    self.backgroundColor = [UIColor clearColor];
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = 1.0f;
    self.layer.cornerRadius = 5.0f;
    self.textColor = [UIColor whiteColor];
}

@end
