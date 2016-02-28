//
//  PaymentForm.m
//  Yes I Camp
//
//  Created by Paul Lavoine on 28/02/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "PaymentForm.h"

@implementation PaymentForm

- (instancetype)initWithBookingID:(NSString *)bookingId
                        firstname:(NSString *)firstname
                         lastname:(NSString *)lastname
                            email:(NSString *)email
                         birthday:(NSString *)birthday
                      nationality:(NSString *)nationality
               countryOfResidence:(NSString *)countryOfResidence
                         currency:(NSString *)currency
                         cardType:(NSString *)cardType
{
    if (self = [super init])
    {
        _bookingId = bookingId ;
        _firstname = firstname ;
        _lastname = lastname ;
        _email = email ;
        _birthday = birthday ;
        _nationality = nationality ;
        _countryOfResidence = countryOfResidence ;
        _currency = currency ;
        _cardType = cardType ;
    }
    
    return self;
}
@end
    
