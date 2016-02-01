//
//  NetworkManagement.h
//  hotel
//
//  Created by Paul Lavoine on 20/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface NetworkManagement : NSObject

+ (instancetype)sharedInstance;
- (void)addNewAction:(HTTPAction *)action;

@end
