//
//  UIView+Effects.m
//
//  Created by Paul Lavoine on 27/02/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "UIView+Effects.h"

@implementation UIView (Effects)

- (void)addTransparentColorEffect:(UIColor *)color
{
    self.backgroundColor = [UIColor clearColor];
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = 1.0f;
    self.layer.cornerRadius = 5.0f;
}

@end
