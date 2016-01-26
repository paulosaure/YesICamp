//
//  NetworkManagement.m
//  hotel
//
//  Created by Paul Lavoine on 20/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "NetworkManagement.h"
#import <AFURLSessionManager.h>

@interface NetworkManagement () <NSURLSessionDelegate, NSURLSessionDataDelegate, NSURLSessionDownloadDelegate>

@property (nonatomic, strong) NSMutableDictionary *dictionary;
@property (nonatomic, strong) NSURLSession *session;
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

- (void)requestServer:(NSString *)url action:(WebService)action
{
    [self connectionWithServer:url action:action];
}

- (void)connectionWithServer:(NSString *)urlString action:(WebService)action
{
    // Init Request
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"GET";
    
    // Generate session
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"myUniqueAppID"];
    _session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    // Start Download Task
    NSURLSessionDownloadTask* task = [_session downloadTaskWithRequest:request];
    NSString *key = [NSString stringWithFormat:@"%ld", (long)task.taskIdentifier];
    [self.dictionary setObject:@(action) forKey:key];
    [task resume];
}

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
    NSString *actionTypeNotification = [[self.dictionary objectForKey:key] stringValue];
    
    // Notify action
    [NOTIFICATION_CENTER postNotificationName:actionTypeNotification object:stringFromFileAtURL];
    
    // Clean dictionary
    [self.dictionary removeObjectForKey:key];
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
