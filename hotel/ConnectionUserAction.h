//
//  ConnectionUser.h
//  hotel
//
//  Created by Paul Lavoine on 20/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#define ConnectionReponseNotification @"ConnectionReponseNotification"

@interface ConnectionUserAction : HTTPAction

+ (instancetype)action:(NSString *)userName password:(NSString *)password;

@end
