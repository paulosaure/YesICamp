//
//  SPWebViewFiller.m
//
//  Created by ScanPay on 13/03/13.
//  Copyright (c) 2013 ScanPay All rights reserved.
//

#import "SPWebViewFiller.h"

@interface SPWebViewFiller()
{
	NSMutableDictionary *_values;
}
@end

@implementation SPWebViewFiller

- (id)init
{
	self = [super init];
	if (self)
	{
		
	}
	return self;
}

- (id)initWithWebview:(UIWebView *)webView
{
	self = [super init];
	if (self)
	{
		_values = [[NSMutableDictionary alloc] init];
		[webView setDelegate:self];
	}
	return self;
}

- (void)addFieldWithId:(NSString *)fieldId andValue:(NSString *)value
{
	[_values setValue:value forKey:fieldId];
}

- (void)fillFieldWithId:(NSString *)fieldId andValue:(NSString *)value onWebView:(UIWebView *)webView;
{
	[webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementById('%@').value=\"%@\"", fieldId, value]];
}

- (void)selectOptionWithName:(NSString *)name forValue:(NSString *)value onWebView:(UIWebView *)webView
{
	[webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementsByName('%@')[0].value=\"%@\"", name, value]];
}

#pragma mark - UIWebView Delegate

- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
	
}

- (void) webViewDidFinishLoad:(UIWebView *)webView
{
	BOOL shouldRelease = YES;
	for (NSString *key in [_values allKeys])
	{
		if (![webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementById('%@').value=\"%@\"", key, [_values objectForKey:key]]])
			shouldRelease = NO;
	}
	
	if (shouldRelease)
	{
		[webView setDelegate:nil];
	}
}

- (void) webViewDidStartLoad:(UIWebView *)webView
{
	
}

- (BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
	return YES;
}

@end
