//
//  LabelWithPadding.m
//  Yes I Camp
//
//  Created by Paul Lavoine on 21/02/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "LabelWithPadding.h"

#define PADDING 10
#define PADDING_UILABEL UIEdgeInsetsMake(PADDING, PADDING, PADDING, PADDING)

@implementation LabelWithPadding

- (void)drawTextInRect:(CGRect)rect
{
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, PADDING_UILABEL)];
}

- (CGSize)intrinsicContentSize
{
    CGSize size = [super intrinsicContentSize];
    size.width  += PADDING_UILABEL.left + PADDING_UILABEL.right;
    size.height += PADDING_UILABEL.top + PADDING_UILABEL.bottom;
    return size;
}

@end
