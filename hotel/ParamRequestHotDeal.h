//
//  ParamRequestHotDeal.h
//  Yes I Camp
//
//  Created by Paul Lavoine on 13/02/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParamRequestHotDeal : NSObject

- (instancetype)initParamWithLongitude:(NSNumber *)longitude latitude:(NSNumber *)latitude locationDisplay:(NSNumber *)locationDisplay;


@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *locationDisplay;

@end

