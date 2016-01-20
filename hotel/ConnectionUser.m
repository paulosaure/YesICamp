//
//  ConnectionUser.m
//  hotel
//
//  Created by Paul Lavoine on 20/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "ConnectionUser.h"
#import <AFHTTPSessionManager.h>

@implementation ConnectionUser

- (void)connectionWithIdentifiant:(NSString *)email password:(NSString *)password url:(NSString *)url
{
    NSString *parameters = [NSString stringWithFormat:@"email=%@&pass=%@", email, password];
    [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:url parameters:parameters error:nil];
}

@end
