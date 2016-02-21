//
//  CustomMKAnnotationView.m
//  YesICamp
//
//  Created by Paul Lavoine on 26/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "CustomMKAnnotationView.h"
#import "CustomMKAnnotation.h"

@interface CustomMKAnnotationView ()

@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation CustomMKAnnotationView

- (void)configureAnnotationWith:(CustomMKAnnotation *)annotation
{
    self.annotation = annotation;
    
    NSArray* nibViews = [[NSBundle mainBundle] loadNibNamed:@"CustomMKAnnotationView"
                                                      owner:self
                                                    options:nil];
    
    CustomMKAnnotationView *mainView = (CustomMKAnnotationView *)[nibViews firstObject];
    mainView.priceLabel.text = annotation.price;
    mainView.imageView.tintColor = GREEN_COLOR;
    mainView.frame = self.frame;
    
    if ([self.subviews count] == 1)
    {
        [((CustomMKAnnotationView *)self.subviews[0]) configureAnnotationWith:annotation];
    }
    else
    {
        [self addSubview:mainView];
    }
}

+ (NSInteger)widthPrice:(NSString *)price
{
    CGSize maximumSize = CGSizeMake(300, USER_LOCATION_MARKER_WIDTH);
    CGRect boxLabel = [price boundingRectWithSize:maximumSize
                                  options:NSStringDrawingUsesLineFragmentOrigin
                               attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0f weight:UIFontWeightBold]}
                                  context:nil];

    return boxLabel.size.width;
}

@end
