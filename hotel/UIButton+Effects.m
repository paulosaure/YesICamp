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
    self.backgroundColor = [color colorWithAlphaComponent:0.8f];
    self.layer.cornerRadius = 5.0f;
}

- (void)addEffectbelowBookButton:(NSString *)labelButton
{
    self.titleLabel.font = [UIFont systemFontOfSize:15.0f weight:UIFontWeightBold];
    [self setTitle:labelButton forState:UIControlStateNormal];
    [self setBackgroundColor:BLACK_COLOR];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.backgroundColor = GREEN_COLOR;
}

@end
