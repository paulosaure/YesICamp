//
//  CategoryLabelWithPadding.m
//  Yes I Camp
//
//  Created by Paul Lavoine on 21/02/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "CategoryLabelWithPadding.h"

#define PADDING 7
#define PADDING_UILABEL UIEdgeInsetsMake(0, PADDING, 0, PADDING)

@implementation CategoryLabelWithPadding

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
