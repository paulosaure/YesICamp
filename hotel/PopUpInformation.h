//
//  PopUpInformation.h
//  Yes I Camp
//
//  Created by Paul Lavoine on 24/02/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PopUpInformation : NSObject

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message messageButton:(NSString *)messageButton;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *messageButton;

@end
