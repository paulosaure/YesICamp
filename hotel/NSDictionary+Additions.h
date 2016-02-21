//
//  NSDictionary+Additions.h
//  Yes I Camp
//
//  Created by Cyril Chandelier on 21/02/16.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface NSDictionary (Additions)

/**
 Return the basic objectForKey: but replace NSNull results with nil
 */
- (id)objectForKeyOrNil:(id)key;

@end
