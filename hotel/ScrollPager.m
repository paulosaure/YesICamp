//
//  ScrollPager.m
//  hotel
//
//  Created by Paul Lavoine on 24/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "ScrollPager.h"


IB_DESIGNABLE

@interface ScrollPager () <UIScrollViewDelegate>

@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) UIView *indicatorView;
@property (nonatomic, strong) NSMutableArray *views;
@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, assign) BOOL animationInProgress;

// Outlets
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) IBInspectable UIColor *textColor;
@property (nonatomic, strong) IBInspectable UIColor *selectedTextColor;
@property (nonatomic, strong) IBInspectable UIColor *indicatorColor;

@property (nonatomic, strong) IBInspectable UIFont *font;
@property (nonatomic, strong) IBInspectable UIFont *selectedFont;

@property (nonatomic, assign) IBInspectable NSNumber *indicatorSizeMatchesTitle;
@property (nonatomic, assign) IBInspectable NSNumber *indicatorHeight;

@property (nonatomic, strong) IBInspectable UIColor *borderColor;
@property (nonatomic, assign) IBInspectable NSNumber *borderWidth;
@property (nonatomic, assign) IBInspectable NSNumber *animationDuration;

@end

@implementation ScrollPager

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self initialize];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self initialize];
    }
    
    return self;
}

- (void)initialize
{
    [self addSegmentsWithTitles:@[@"One", @"Two", @"Three", @"Four"]];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self redrawComponents];
}

- (void)addSegmentsWithViews:(NSArray *)segments
{
    [self addViews:segments];
    [self redrawComponents];
}

- (void)addSegmentsWithTitles:(NSArray *)segmentTitles
{
    [self addButtons:segmentTitles];
    [self redrawComponents];
}

- (void)addSegmentsWithImages:(NSArray *)segmentImages
{
    [self addButtons:segmentImages];
    [self redrawComponents];
}

- (void)setSelectedIndex:(NSInteger)index animated:(BOOL)animated
{
    [self setSelectedIndex:index animated:animated moveScrollView:YES];
}

- (void)setSelectedIndex:(NSInteger)index animated:(BOOL)animated moveScrollView:(BOOL)moveScrollView
{
    self.selectedIndex = index;
    [self moveToIndex:index animated:animated moveScrollView:moveScrollView];
}

- (void)addViews:(NSArray *)segmentViews
{
    for (UIView *view in self.scrollView.subviews)
    {
        [view removeFromSuperview];
    }
    
    for (int i = 0; i < [segmentViews count]; i++)
    {
        UIView *view = segmentViews[i];
        [self.scrollView addSubview:view];
        [self.views addObject:view];
    }
}

- (void)addButtons:(NSArray *)titleOrImages
{
    for (UIButton *button in self.buttons)
    {
        [button removeFromSuperview];
    }
    
    [self.buttons removeAllObjects];
    
    for (int i = 0; i < [titleOrImages count]; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        [button addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttons addObject:button];
        
        id info = titleOrImages[i];
        if ([info isKindOfClass:[UIImage class]])
        {
            [button setImage:info forState:UIControlStateNormal];
        }
        else if ([info isKindOfClass:[NSString class]])
        {
            [button setTitle:info forState:UIControlStateNormal];
        }
    }
}

- (void)moveToIndex:(NSInteger)index animated:(BOOL)animated moveScrollView:(BOOL)moveScrollView
{
    self.animationInProgress = YES;
    
    [UIView animateWithDuration:animated ? [self.animationDuration floatValue] : 0.0
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         CGFloat width = self.frame.size.width / [self.buttons count];
                         UIButton *button = self.buttons[index];
                         
                         [self redrawButtons];
                         
                         if ([self.indicatorSizeMatchesTitle boolValue])
                         {
                             NSString *string = button.titleLabel.text;
                             CGSize size = [string sizeWithAttributes:@{NSFontAttributeName : button.titleLabel.font}];
                             CGFloat x = width * index + ((width - size.width) / 2);
                             self.indicatorView.frame = CGRectMake(x, self.frame.size.height - [self.indicatorHeight floatValue], size.width, [self.indicatorHeight floatValue]);
                         }
                         else
                         {
                             self.indicatorView.frame = CGRectMake(width * index, self.frame.size.height - [self.indicatorHeight floatValue], button.frame.size.width, [self.indicatorHeight floatValue]);
                         }
                         
                         if (self.scrollView != nil && moveScrollView)
                         {
                             self.scrollView.contentOffset = CGPointMake(index * self.scrollView.frame.size.width, 0);
                         }
                     }
                     completion:^(BOOL completed){
                         if (self != nil)
                         {
                             self.animationInProgress = FALSE;
                         }
                     }];
}

- (void)redrawComponents
{
    [self redrawButtons];
    
    if ([self.buttons count] > 0)
    {
        [self moveToIndex:self.selectedIndex animated:FALSE moveScrollView:FALSE];
    }
    
    if (self.scrollView != nil)
    {
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * [self.buttons count], self.scrollView.frame.size.height);
        
        for (int i = 0; i < [self.views count]; i++)
        {
            ((UIView *)self.views[i]).frame = CGRectMake(self.scrollView.frame.size.width * i, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
        }
    }
}

- (void)redrawButtons
{
    if ([self.buttons count] == 0)
    {
        return;
    }
    
    CGFloat width = self.frame.size.width / [self.buttons count];
    CGFloat height = self.frame.size.height - [self.indicatorHeight floatValue];
    
    for (int i = 0 ; i < [self.buttons count]; i++)
    {
        UIButton *button = self.buttons[i];
        button.frame = CGRectMake(width*i, 0, width, height);
        [button setTitleColor:(i == self.selectedIndex) ? self.selectedTextColor : self.textColor forState:UIControlStateNormal];
    }
}

- (void)buttonSelected:(UIButton *)sender
{
    if (sender.tag == self.selectedIndex)
        return;
    
    [self.delegate scrollPager:self changedIndex:sender.tag];
    [self setSelectedIndex:sender.tag animated:YES moveScrollView:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!self.animationInProgress)
    {
        CGFloat page = scrollView.contentOffset.x / scrollView.frame.size.width;
        
        if (page > 0.5)
        {
            page = page + 1.0f;
        }
        
        if (page != self.selectedIndex)
        {
            [self setSelectedIndex:(NSInteger)page animated:YES moveScrollView:FALSE];
            [self.delegate scrollPager:self changedIndex:(NSInteger)page];
        }
    }
}

- (void)setScrollView:(UIScrollView *)scrollView
{
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = FALSE;
}

- (void)setTextColor:(UIColor *)textColor
{
    [self redrawComponents];
}

- (void)setSelectedTextColor:(UIColor *)selectedTextColor
{
    [self redrawComponents];
}

- (void)setFont:(UIFont *)font
{
    [self redrawComponents];
}

- (void)setSelectedFont:(UIFont *)selectedFont
{
    [self redrawComponents];
}

- (void)setIndicatorColor:(UIColor *)indicatorColor
{
    [self redrawComponents];
}

- (void)setIndicatorSizeMatchesTitle:(NSNumber *)indicatorSizeMatchesTitle
{
    [self redrawComponents];
}

- (void)setIndicatorHeight:(NSNumber *)indicatorHeight
{
    [self redrawComponents];
}

- (void)setBorderColor:(UIColor *)borderColor
{
    self.layer.borderColor = borderColor.CGColor;
}

- (void)setBorderWidth:(NSNumber *)borderWidth
{
    self.layer.borderWidth = [borderWidth floatValue];
}

@end
