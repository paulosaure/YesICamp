//
//  NetworkManagement.m
//  hotel
//
//  Created by Paul Lavoine on 20/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "NetworkManagement.h"
#import <AFURLSessionManager.h>

@implementation NetworkManagement


#pragma mark - Shared instance

+ (instancetype)sharedInstance
{
    static NetworkManagement *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[NetworkManagement alloc] init];
    });
    
    return sharedInstance;
}

@end
