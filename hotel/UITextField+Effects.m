//
//  UITextField+Effects.m
//  Yes I Camp
//
//  Created by Paul Lavoine on 01/02/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "UITextField+Effects.h"

@implementation UITextField (Effects)

- (void)addTransparentColorEffect:(UIColor *)color placeholder:(NSString *)placeholder
{
    NSAttributedString *passPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName : color}];
    self.attributedPlaceholder = passPlaceholder;
    
    self.backgroundColor = [UIColor clearColor];
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = 1.0f;
    self.layer.cornerRadius = 5.0f;
}

@end
