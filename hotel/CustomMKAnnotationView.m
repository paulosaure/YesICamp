//
//  CustomMKAnnotationView.m
//  YesICamp
//
//  Created by Paul Lavoine on 26/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "CustomMKAnnotationView.h"

#define USER_LOCATION_MARKER_WIDTH      25
#define MARGE 10

@interface CustomMKAnnotationView ()

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation CustomMKAnnotationView

- (void)configureAnnotationWithPriceLavel:(NSString *)priceLabel color:(UIColor *)color
{
    NSArray* nibViews = [[NSBundle mainBundle] loadNibNamed:@"CustomMKAnnotationView"
                                                      owner:self
                                                    options:nil];
    
    CustomMKAnnotationView *mainView = (CustomMKAnnotationView *)[nibViews objectAtIndex:0];
    mainView.priceLabel.text = priceLabel;
    mainView.frame = CGRectMake(0, 0, USER_LOCATION_MARKER_WIDTH + [self widthPrice:priceLabel] + MARGE, USER_LOCATION_MARKER_WIDTH);
    mainView.backgroundColor = color;
    
    [self addSubview:mainView];
}

- (NSInteger)widthPrice:(NSString *)price
{
    CGSize maximumSize = CGSizeMake(300, USER_LOCATION_MARKER_WIDTH);
    CGRect boxLabel = [price boundingRectWithSize:maximumSize
                                  options:NSStringDrawingUsesLineFragmentOrigin
                               attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0f weight:UIFontWeightBold]}
                                  context:nil];

    return boxLabel.size.width;
}

@end
