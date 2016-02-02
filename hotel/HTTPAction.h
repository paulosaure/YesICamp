//
//  HTTPAction.h
//  Yes I Camp
//
//  Created by Paul Lavoine on 01/02/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, WebService)
{
    WebServiceGetOffersList = 0, // default
    WebServiceGetCampingsList,
    WebServiceGetHotsDealsList,
    WebServiceConnection,
    WebServiceInscription
};

@interface HTTPAction : NSObject

- (instancetype)initWithUrl:(NSString *)url service:(WebService)service;
- (void)handleDownloadedData:(NSString *)obj;

@property (nonatomic, strong) NSString *url;
@property (nonatomic, assign) WebService service;

@end
