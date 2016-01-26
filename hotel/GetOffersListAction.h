//
//  GetCampingsList.h
//  hotel
//
//  Created by Paul Lavoine on 26/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetOffersListAction : NetworkManagement

+ (instancetype)action;
- (void)requestServer;

@end
