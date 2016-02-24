//
//  PopUpInformation.m
//  Yes I Camp
//
//  Created by Paul Lavoine on 24/02/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "PopUpInformation.h"

@implementation PopUpInformation

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message messageButton:(NSString *)messageButton
{
    if (self = [super init])
    {
        _title = title;
        _message = message;
        _messageButton = messageButton;
    }
    
    return self;
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message messageButton:(NSString *)messageButton popToViewController:(BOOL)popToViewController
{
    if (self = [super init])
    {
        _title = title;
        _message = message;
        _messageButton = messageButton;
        _popToRootViewController = popToViewController;
    }
    
    return self;
}

@end
