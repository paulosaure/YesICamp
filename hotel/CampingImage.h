//
//  CampingImage.h
//  Yes I Camp
//
//  Created by Paul Lavoine on 08/03/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CampingImage : NSObject

@property (nonatomic, strong) NSNumber *uid;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) UIImage *image;

@end
