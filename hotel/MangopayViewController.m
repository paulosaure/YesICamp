//
//  MangopayViewController.m
//  hotel
//
//  Created by Paul Lavoine on 20/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "MangopayViewController.h"
#import "ScanPayViewController.h"
#import "SPWebViewFiller/SPWebViewFiller.h"

@interface MangopayViewController () <ScanPayDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *paymentWebView;

@end

@implementation MangopayViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ScanPayViewController *scan = [[ScanPayViewController alloc]initWithDelegate:self appToken:@"PUT_YOUR_TOKEN_HERE"
                                   ];
    [self presentViewController:scan animated:YES completion:nil];
    
    
    SPWebViewFiller *filler = [[SPWebViewFiller alloc] initWithWebview:self.paymentWebView];
    [filler addFieldWithId:@"Id of the field" andValue:@"Value_to_put_into_field"];
    [filler addFieldWithId:@"Id of the field" andValue:@"Value_to_put_into_field"];
    
//    [self.paymentWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"url"]]];
}

- (void)scanPayViewController:(ScanPayViewController *)scanPayViewController failedToScanWithError:(NSError *)error
{
    
}

- (void)scanCancelledByUser:(ScanPayViewController *)scanPayViewController
{
    
}

- (void)scanPayViewController:(ScanPayViewController *)scanPayViewController didScanCard:(SPCreditCard *)card
{
    
}

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
