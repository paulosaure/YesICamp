//
//  NetworkManagement.m
//  hotel
//
//  Created by Paul Lavoine on 20/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "NetworkManagement.h"
#import <AFURLSessionManager.h>

#define DEFAULT_METHOD      GET_METHOD

@interface NetworkManagement () <NSURLSessionDelegate, NSURLSessionDataDelegate, NSURLSessionDownloadDelegate>

@property (nonatomic, strong) NSMutableDictionary *dictionary;
@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSURLSessionConfiguration* config;
@end

@implementation NetworkManagement


#pragma mark - Shared instance

+ (instancetype)sharedInstance
{
    static NetworkManagement *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[NetworkManagement alloc] init];
    });
    
    return sharedInstance;
}

- (instancetype)init
{
    if (self = [super init])
    {
        self.dictionary = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)addNewAction:(HTTPAction *)action
{
    [self connectionWithServer:action method:DEFAULT_METHOD];
}

- (void)addNewAction:(HTTPAction *)action method:(NSString *)method
{
    [self connectionWithServer:action method:method];
}

- (void)connectionWithServer:(HTTPAction *)action method:(NSString *)method
{
    // Init Request
    NSURL *url = [NSURL URLWithString:action.url];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = method;
    
    if (action.param)
    {
        [self configurePostRequest:request postParam:action.param];
    }
    
    // Generate session
    if (!self.config)
    {
        self.config = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:SESSION_UNIQUE_IDENTIFIER];
    }
    
    if (!self.session)
    {
        self.session = [NSURLSession sessionWithConfiguration:self.config delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    }
    
    // Start Download Task
    NSURLSessionDownloadTask* task = [self.session downloadTaskWithRequest:request];
    NSString *key = [NSString stringWithFormat:@"%ld", (long)task.taskIdentifier];
    [self.dictionary setObject:action forKey:key];
    [task resume];
}

- (void)configurePostRequest:(NSMutableURLRequest *)request postParam:(NSString *)postParam
{
    NSData *postData = [postParam dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
}


#pragma mark - NSURLSessionTaskDelegate

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    // Retrieve file at specific location
    NSString *stringFromFileAtURL = [[NSString alloc]
                                     initWithContentsOfURL:location
                                     encoding:NSUTF8StringEncoding
                                     error:nil];
    
    // Reconstruct key
    NSString *key = [@(downloadTask.taskIdentifier) stringValue];
    
    // Retrieve actionType
    HTTPAction *action = [self.dictionary objectForKey:key];
 
    NSDictionary *response = @{
                              RESPONSE_HEADER : downloadTask.response,
                              RESPONSE_BODY : stringFromFileAtURL
                              };
    
    // Notify action
    [action handleDownloadedData:response];
    
    // Clean dictionary
    [self.dictionary removeObjectForKey:key];
}

// This method is used to receive the data which we get using post method.
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData*)data
{
    NSLog(@"NetworkManagement : didReceiveData");
}

// This method receives the error report in case of connection is not made to server.
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"NetworkManagement : didFailWithError");
}

// This method is used to process the data after connection has made successfully.
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"NetworkManagement : connection");
}


-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    //    CGFloat percentDone = (double)totalBytesWritten/(double)totalBytesExpectedToWrite;
}

// AFNETWORKING
//- (void) getDataFrom:(NSString *)url
//{
//    __block id obj = nil;
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFJSONResponseSerializer
//                                  serializerWithReadingOptions:NSJSONReadingAllowFragments];
//
//    [manager GET:url
//      parameters:@""
//        progress:nil
//         success:^(NSURLSessionDataTask *task, id responseObject)
//     {
//         obj = responseObject;
//         //         [[NSNotificationCenter defaultCenter] postNotificationName:dataNotification object:packet];
//
//     }
//         failure:^(NSURLSessionDataTask *task, NSError *error)
//     {
//         NSLog(@"Error 1 : %@\n\n\n\n", error);
//     }];
//}

@end
