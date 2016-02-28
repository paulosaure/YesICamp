//
//  PaymentForm.h
//  Yes I Camp
//
//  Created by Paul Lavoine on 28/02/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PaymentForm : NSObject

- (instancetype)initWithBookingID:(NSString *)bookingId
                        firstname:(NSString *)firstname
                         lastname:(NSString *)lastname
                            email:(NSString *)email
                         birthday:(NSString *)birthday
                      nationality:(NSString *)nationality
               countryOfResidence:(NSString *)countryOfResidence
                         currency:(NSString *)currency
                         cardType:(NSString *)cardType;

@property (nonatomic, strong, readonly) NSString *bookingId;

@property (nonatomic, strong, readonly) NSString *lastname;
@property (nonatomic, strong, readonly) NSString *firstname;
@property (nonatomic, strong, readonly) NSString *email;

@property (nonatomic, strong, readonly) NSString *birthday;
@property (nonatomic, strong, readonly) NSString *nationality;
@property (nonatomic, strong, readonly) NSString *countryOfResidence;

@property (nonatomic, strong, readonly) NSString *currency;
@property (nonatomic, strong, readonly) NSString *cardType;

@end
