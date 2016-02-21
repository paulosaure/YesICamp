//
//  User.m
//  Yes I Camp
//
//  Created by Paul Lavoine on 21/02/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "User.h"

@interface User ()

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *age;
@property (nonatomic, strong) NSString *tokenId;

@end

@implementation User

#pragma mark - Shared instance

+ (instancetype)sharedInstance
{
    static User *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[User alloc] init];
    });
    
    return sharedInstance;
}

- (void)didConnectionSucceded:(NSString *)firstName lastName:(NSString *)lastName email:(NSString *)email password:(NSString *)password age:(NSString *)age
{
    self.firstName = firstName;
    self.lastName = lastName;
    self.email = email;
    self.password = password;
    self.age = age;
    
    self.isConnected = YES;
}

@end
