//
//  ConnectionUser.h
//  hotel
//
//  Created by Paul Lavoine on 20/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

@interface ConnectionUser : NetworkManagement

- (void)connectionWithIdentifiant:(NSString *)email password:(NSString *)password url:(NSString *)url;

@end
