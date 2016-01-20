//
//  InscriptionUser.m
//  hotel
//
//  Created by Paul Lavoine on 20/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "InscriptionUser.h"
#import "UserProfil.h"
#import <AFHTTPSessionManager.h>

@implementation InscriptionUser

- (void)inscriptionWithProfil:(UserProfil *)profil url:(NSString *)url
{
    [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:url parameters:profil error:nil];
}

@end
