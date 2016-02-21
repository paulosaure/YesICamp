//
//  InscriptionUserAction.h
//  hotel
//
//  Created by Paul Lavoine on 20/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#define InscriptionReponseNotification @"InscriptionReponseNotification"

@interface InscriptionUserAction : HTTPAction

+ (instancetype)action:(NSString *)firstName lastName:(NSString *)lastName email:(NSString *)email password:(NSString *)password age:(NSString *)age;

@end
