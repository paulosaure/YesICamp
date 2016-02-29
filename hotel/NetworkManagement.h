//
//  NetworkManagement.h
//  hotel
//
//  Created by Paul Lavoine on 20/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import <Foundation/Foundation.h>

#define GET_METHOD @"GET"
#define POST_METHOD @"POST"
#define DELETE_METHOD @"DELETE"

#define RESPONSE_HEADER     @"header"
#define RESPONSE_BODY       @"body"

@interface NetworkManagement : NSObject

+ (instancetype)sharedInstance;
- (void)addNewAction:(HTTPAction *)action;
- (void)addNewAction:(HTTPAction *)action method:(NSString *)method;

@end
