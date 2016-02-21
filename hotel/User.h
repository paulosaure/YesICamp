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
- (void)didConnectionSucceded:(NSDictionary *)account uid:(NSString *)uid tokenId:(NSString *)token client:(NSString *)client;

@property (nonatomic, assign) BOOL isConnected;

@end
