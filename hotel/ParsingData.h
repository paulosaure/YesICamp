//
//  ParsingData.h
//  hotel
//
//  Created by Paul Lavoine on 20/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParsingData : NSObject

+ (instancetype)sharedInstance;
- (NSArray *)campingsWithJson:(NSString *)path;

@end
