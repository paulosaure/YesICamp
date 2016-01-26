//
//  NetworkManagement.h
//  hotel
//
//  Created by Paul Lavoine on 20/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, WebService)
{
    WebServiceGetOffersList = 0, // default
    WebServiceGetCampingsList,
    WebServiceConnection,
    WebServiceInscription
};

@interface NetworkManagement : NSObject

+ (instancetype)sharedInstance;
- (void)requestServer:(NSString *)url action:(WebService)action;

@end
