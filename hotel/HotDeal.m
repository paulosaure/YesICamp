//
//  HotDeal.m
//  hotel
//
//  Created by Paul Lavoine on 30/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "HotDeal.h"

@interface HotDeal ()

@property (nonatomic, strong) NSDate *remainingTime;
@property (nonatomic, strong) NSDate *dateLastRequest;

@end

@implementation HotDeal

- (NSDate *)remainingTimeWithRequestDate
{
    NSDate *currentDate = [NSDate date];
    
    NSTimeInterval remainingInterval = [currentDate timeIntervalSinceDate:self.remainingTime];
    NSTimeInterval diff = [currentDate timeIntervalSinceDate:self.dateLastRequest];
    self.dateLastRequest = currentDate;
    
    return [NSDate dateWithTimeInterval:(remainingInterval - diff) sinceDate:currentDate];
}

@end
