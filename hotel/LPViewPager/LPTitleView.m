//
//  LPTitleView.m
//  LPViewPagerController
//
//  Created by litt1e-p on 15/12/5.
//  Copyright © 2015年 litt1e-p. All rights reserved.
//

#import "LPTitleView.h"

#define INDICATOR_VIEW_HEIGHT 4
#define TRANSLATE_PICTO_TOP 5

@interface LPTitleView()

@property (nonatomic, strong) NSMutableArray *views;
@property (nonatomic, strong) UIView *pageIndicator;
@property (nonatomic, strong) NSArray *imageArray;

@end

@implementation LPTitleView

- (id)init
{
    if (self = [super init])
    {
        self.views = [NSMutableArray array];
        [self addSubview:self.pageIndicator];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect idRect            = self.pageIndicator.frame;
    idRect.origin.y          = self.frame.size.height - INDICATOR_VIEW_HEIGHT;
    idRect.size.width        = self.frame.size.width / [self.imageArray count];
    self.pageIndicator.frame = idRect;
    
    [self.views enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        CGFloat viewWidth = self.frame.size.width/ [self.imageArray count];
        view.frame        = CGRectMake(viewWidth * idx, TRANSLATE_PICTO_TOP, viewWidth, view.frame.size.height);
    }];
}

- (void)addImages:(NSArray *)images
{
    self.imageArray = images;
    [self.views makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.views removeAllObjects];
    __weak typeof(self) weakself = self;
    [images enumerateObjectsUsingBlock:^(id object, NSUInteger idx, BOOL *stop) {
        if ([object isKindOfClass:[NSString class]])
        {
            CGFloat sizePicto = CONTENT_PICTO_VIEW_HEIGHT - INDICATOR_VIEW_HEIGHT - TRANSLATE_PICTO_TOP - 5;
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,sizePicto ,sizePicto)];
            imageView.backgroundColor = [UIColor clearColor];
            imageView.tintColor = [UIColor whiteColor];
            imageView.image = [UIImage imageNamed:object];
            imageView.tag = idx;
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            imageView.userInteractionEnabled = YES;
            [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:weakself action:@selector(didTapTextLabel:)]];
            [weakself addSubview:imageView];
            [weakself.views addObject:imageView];
        }
    }];
}

- (void)didTapTextLabel:(UITapGestureRecognizer *)gestureRecognizer
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectedTitleAtIndex:)])
    {
        [self.delegate didSelectedTitleAtIndex:gestureRecognizer.view.tag];
    }
}

- (UIView *)pageIndicator
{
    if (!_pageIndicator)
    {
        _pageIndicator = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, INDICATOR_VIEW_HEIGHT)];
    }
    
    _pageIndicator.backgroundColor = self.indicatorColor;
    return _pageIndicator;
}

- (void)updatePageIndicatorPosition:(CGFloat)xPosition
{
    CGFloat screenWidth            = [[UIScreen mainScreen]bounds].size.width;
    CGFloat pageIndicatorXPosition = (((xPosition - screenWidth)/screenWidth) * (self.frame.size.width - self.pageIndicator.frame.size.width))/(self.imageArray.count - 1);
    CGRect idRect                  = self.pageIndicator.frame;
    idRect.origin.x                = pageIndicatorXPosition;
    self.pageIndicator.frame       = idRect;
}
//
//- (void)adjustImageViewAtIndex:(CGFloat)index
//{
//    for (UIImageView *imageView in self.subviews) {
//        if ([imageView isKindOfClass:[UIImageView class]]) {
//            imageView.backgroundColor = self.titleNormalColor ? : [UIColor colorWithWhite:0 alpha:1.000];
//            if (imageView.tag == index) {
//                imageView.backgroundColor =  self.titleSelectedColor ? : [UIColor clearColor];
//            }
//        }
//    }
//    CGRect idRect = self.pageIndicator.frame;
//    if (index == 0) {
//        idRect.origin.x = 0;
//    } else if (index == self.imageArray.count - 1) {
//        idRect.origin.x = self.frame.size.width - self.pageIndicator.frame.size.width;
//    }
//    self.pageIndicator.frame = idRect;
//}

//
//+ (CGFloat)calcTitleWidth:(NSArray *)titleArr withFont:(UIFont *)titleFont
//{
//    return [self getMaxTitleWidthFromArray:titleArr withFont:titleFont] * 3 + kTitleMargin * 2;
//}
//
//+ (CGFloat)getMaxTitleWidthFromArray:(NSArray *)titleArray withFont:(UIFont *)titleFont
//{
//    CGFloat maxWidth = 0;
//    for (int i = 0; i < titleArray.count; i++) {
//        NSString *titleString = [titleArray objectAtIndex:i];
//        CGFloat titleWidth    = [titleString sizeWithAttributes:@{NSFontAttributeName:titleFont}].width;
//        if (titleWidth > maxWidth) {
//            maxWidth = titleWidth;
//        }
//    }
//    return maxWidth;
//}


@end
