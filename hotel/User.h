//
//  User.h
//  Yes I Camp
//
//  Created by Paul Lavoine on 21/02/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

+ (instancetype)sharedInstance;
- (void)didConnectionSucceded:(NSString *)firstName lastName:(NSString *)lastName email:(NSString *)email password:(NSString *)password age:(NSString *)age;

@property (nonatomic, assign) BOOL isConnected;

@end
