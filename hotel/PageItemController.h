//
//  PageItemController.h
//  HandOff_ObjC
//
//  Created by Olga Dalton on 23/10/14.
//  Copyright (c) 2014 Olga Dalton. All rights reserved.
//

#import <UIKit/UIKit.h>
#define PageItemControllerID @"PageItemControllerID"

@interface PageItemController : UIViewController

- (void)configurePageWith:(NSString *)name index:(NSInteger)index;

// Data
@property (nonatomic) NSUInteger itemIndex;

@end
