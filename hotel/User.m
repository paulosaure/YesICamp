//
//  User.m
//  Yes I Camp
//
//  Created by Paul Lavoine on 21/02/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "User.h"

@interface User ()

@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *age;
@property (nonatomic, strong) NSString *birthDate;
@property (nonatomic, strong) NSString *countryCode;
@property (nonatomic, strong) NSString *nationality;
@property (nonatomic, strong) CardDetail *cardDetail;
@property (nonatomic, strong) CardRegistration *cardRegistration;

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

- (void)didConnectionSucceded:(NSDictionary *)account uid:(NSString *)uid tokenId:(NSString *)token client:(NSString *)client
{
    self.firstName = [account objectForKeyOrNil:@"firstname"];
    self.lastName = [account objectForKeyOrNil:@"lastname"];
    self.email = [account objectForKeyOrNil:@"email"];
    self.age = [account objectForKeyOrNil:@"age"];
    self.nationality = [account objectForKeyOrNil:@"nationality"];
    self.birthDate = [account objectForKeyOrNil:@"birthDate"];
    self.countryCode = [account objectForKeyOrNil:@"countryCode"];
    self.tokenId = token;
    self.uid = uid;
    self.client = client;
    
    self.isConnected = YES;
}

- (NSString *)paramsClientInformation
{
    return [NSString stringWithFormat:@"uid=%@&tokenId=%@&client=%@",self.uid, self.tokenId, self.client];
}
@end
