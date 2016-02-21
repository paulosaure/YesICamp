//
//  NSDictionary+Additions.m
//  Yes I Camp
//
//  Created by Cyril Chandelier on 21/02/16.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "NSDictionary+Additions.h"



@implementation NSDictionary (Additions)

/**
 Return the basic objectForKey: but replace NSNull results with nil
 */
- (id)objectForKeyOrNil:(id)key
{
    id object = [self objectForKey:key];
    if (object == [NSNull null])
        return nil;
    
    return object;
}

@end
