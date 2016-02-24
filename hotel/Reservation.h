//
//  Reservation.h
//  Yes I Camp
//
//  Created by Paul Lavoine on 22/02/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Reservation : NSObject

- (instancetype)initWithDictionnary:(NSDictionary *)dic;

@property (nonatomic, strong, readonly) NSNumber *uid;
@property (nonatomic, strong, readonly) NSString *addressCamping;
@property (nonatomic, strong, readonly) NSString *nameCamping;
@property (nonatomic, strong, readonly) NSString *phoneCamping;
@property (nonatomic, strong, readonly) NSNumber *offerId;
@property (nonatomic, strong, readonly) NSNumber *price;
@property (nonatomic, strong, readonly) NSString *dateFrom;
@property (nonatomic, strong, readonly) NSString *dateTo;
@property (nonatomic, strong, readonly) NSString *statusReservation;

@end
