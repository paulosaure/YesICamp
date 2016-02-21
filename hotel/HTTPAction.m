//
//  HTTPAction.m
//  Yes I Camp
//
//  Created by Paul Lavoine on 01/02/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "HTTPAction.h"

@implementation HTTPAction

- (instancetype)initWithUrl:(NSString *)url service:(WebService)service param:(NSString *)param
{
    if (self = [super init])
    {
        self.url = url;
        self.service = service;
        self.param = param;
    }
    
    return self;
}

- (instancetype)initWithUrl:(NSString *)url service:(WebService)service
{
    if (self = [super init])
    {
        self.url = url;
        self.service = service;
    }
    
    return self;
}


- (void)handleDownloadedData:(NSDictionary *)obj
{
    
}

@end
