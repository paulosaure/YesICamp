//
//  SPWebViewFiller.h
// 
//
//  Created by ScanPay on 13/03/13.
//  Copyright (c) 2013 ScanPay  All rights reserved.
//

@interface SPWebViewFiller : NSObject <UIWebViewDelegate>
- (id)initWithWebview:(UIWebView *)webView;
- (void)addFieldWithId:(NSString *)fieldId andValue:(NSString *)value;
- (void)fillFieldWithId:(NSString *)fieldId andValue:(NSString *)value onWebView:(UIWebView *)webView;
- (void)selectOptionWithName:(NSString *)name forValue:(NSString *)value onWebView:(UIWebView *)webView;
@end
