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
- (NSString *)paramsClientInformation;

@property (nonatomic, assign) BOOL isConnected;
@property (nonatomic, strong) NSArray *reservations;


@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *email;

@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *client;
@property (nonatomic, strong) NSString *tokenId;

@end
