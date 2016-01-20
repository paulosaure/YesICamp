//
//  Mangopay.m
//  hotel
//
//  Created by Paul Lavoine on 20/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "MangopayViewController.h"
#import "ScanPayViewController.h"

@implementation MangopayViewController

- (void)payment
{
    ScanPayViewController * scanPayViewController = [[ScanPayViewController alloc] initWithToken:@"YOUR_TOKEN_HERE" useConfirmationView:YES useManualEntry:YES];
    
    // If you want to use your own color for set sight
    [scanPayViewController setSightColor:[UIColor colorWithRed:97 / 255.f green:170 / 255.f blue:219 / 255.f alpha:1.0]];
    
    [scanPayViewController startScannerWithViewController:self success:^(SPCreditCard * card){
        
        // You will be notified of the user interaction through this block
        NSLog(@"%@ Expire %@/%@ CVC: %@", card.number, card.month, card.year, card.cvc);
    } cancel:^{
        
        // You will be notified when the user has canceled through this block
        NSLog(@"User cancel");
    }];
}

@end
