//
//  ParsingData.m
//  hotel
//
//  Created by Paul Lavoine on 20/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "ParsingData.h"

@implementation ParsingData

#pragma mark - Shared instance

+ (instancetype)sharedInstance
{
    static ParsingData *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ParsingData alloc] init];
    });
    
    return sharedInstance;
}

#pragma mark - Configure objects
- (NSArray *)hotelsWithJson:(NSString *)path
{
    NSArray *hotels = [NSArray array];
    
// TODO
    
    return  hotels;
}

#pragma mark - Extraction Json

- (NSDictionary *)deserializeData:(NSString *)pathToFile name:(NSString *)name
{
    // Read JSON from a file
    NSString *path = [pathToFile stringByAppendingString:[@"" stringByAppendingString:name]];
    NSData *jsonData = [NSData dataWithContentsOfFile:path];
    
    // Get JSON data into a Foundation object
    if (jsonData != nil)
    {
        NSError *error = nil;
        NSDictionary *docParse = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                 options:NSJSONReadingAllowFragments
                                                                   error:&error];
        if (error)
        {
            NSLog(@"%@", [error localizedDescription]);
        }
        return docParse;
    }
    else
    {
        NSLog(@"Wrong path to Json"); // TODO: do something
        return nil;
    }
}

@end
