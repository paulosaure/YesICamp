//
//  CardRegistration.h
//  Yes I Camp
//
//  Created by Paul Lavoine on 27/02/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CardRegistration : NSObject

- (instancetype)initWithAccessKey:(NSString *)accessKey preRegistrationData:(NSString *)preRegistrationData cardRegistrationUrl:(NSString *)cardRegistrationUrl;

@property (nonatomic, strong, readonly) NSString *cardRegistrationUrl;
@property (nonatomic, strong, readonly) NSString *accessKey;
@property (nonatomic, strong, readonly) NSString *preRegistrationData;

@end
