//
//  AnnotationView.m
//  hotel
//
//  Created by Paul Lavoine on 26/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "AnnotationView.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@implementation AnnotationView

- (id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier])
    {
        // Initialization code
        
        self.image = [UIImage imageNamed:@"ClusterAnnotation"];
        self.frame = CGRectMake(0, 0, self.image.size.width, self.image.size.height);
        
        self.label = [[UILabel alloc] initWithFrame:self.frame];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.font = [UIFont systemFontOfSize:10];
        self.label.textColor = UIColorFromRGB(0x009fd6);
        self.label.center = CGPointMake(self.image.size.width/2, self.image.size.height*.43);
        self.centerOffset = CGPointMake(0, -self.frame.size.height/2);
        
        [self addSubview:self.label];
        
        self.canShowCallout = YES;
    }
    return self;
}

@end
