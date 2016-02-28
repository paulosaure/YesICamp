//
//  CardRegistration.m
//  Yes I Camp
//
//  Created by Paul Lavoine on 27/02/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "CardRegistration.h"

@interface CardRegistration ()

@property (nonatomic, strong) NSString *tag;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *currency;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *registrationData;
@property (nonatomic, strong) NSString *cardType;
@property (nonatomic, strong) NSString *cardId;
@property (nonatomic, strong) NSString *resultCode;
@property (nonatomic, strong) NSString *resultMessage;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, assign) CVTimeStamp *creationDate;

@end

@implementation CardRegistration

- (instancetype)initWithAccessKey:(NSString *)accessKey preRegistrationData:(NSString *)preRegistrationData cardRegistrationUrl:(NSString *)cardRegistrationUrl
{
    if (self = [super init])
    {
        _accessKey = accessKey;
        _preRegistrationData = preRegistrationData;
        _cardRegistrationUrl = cardRegistrationUrl;
    }
    
    return self;
}
@end
