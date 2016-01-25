//
//  HomePageViewController.m
//  hotel
//
//  Created by Paul Lavoine on 20/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomePageViewController.h"
#import "ConnectionUser.h"

#import "AFNetworking.h"

@interface HomePageViewController () <AFURLResponseSerialization, AFURLRequestSerialization>

@property (weak, nonatomic) IBOutlet UITextField *pseudoTextView;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextView;


@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)connection:(id)sender
{
    if ([self connectionWithServer])
    {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:MAIN_STORYBOARD bundle:nil];
//        SearchViewController *searchViewController = (SearchViewController *)[storyBoard instantiateViewControllerWithIdentifier:SearchViewControllerID];
//        [self.navigationController pushViewController:searchViewController animated:YES];
    }
    else
    {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Error"
                                      message:@"Problème technique"
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"Ok"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action)
                                    {
                                        //Handel your yes please button action here
                                        
                                        
                                    }];
        
        [alert addAction:yesButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (id)copyWithZone:(NSZone *)zone
{
    return  nil;
}

- (id)responseObjectForResponse:(NSURLResponse *)response
                           data:(NSData *)data
                          error:(NSError *__autoreleasing *)error
{
        return  nil;
}

- (NSURLRequest *)requestBySerializingRequest:(NSURLRequest *)request
                               withParameters:(NSDictionary *)parameters
                                        error:(NSError *__autoreleasing *)error
{
    
    return  nil;
}

+ (BOOL)supportsSecureCoding {
    return YES;
}


- (BOOL)connectionWithServer
{
    NSString *urlString = @"http://edouardg.fr/vincent/connexion.php";
    NSString *parameters = [NSString stringWithFormat:@"email=%@&pass=%@", @"email", @"pass"];


    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer
                                  serializerWithReadingOptions:NSJSONReadingAllowFragments];
    
    
    [manager GET:urlString
      parameters:parameters
        progress:nil
         success:^(NSURLSessionDataTask *task, id responseObject)
    {
        NSLog(@"eee");
    }
         failure:^(NSURLSessionDataTask *task, NSError *error)
    {
        NSLog(@"Error 1 : %@\n\n\n\n", error);
    }];
    

    
//    NSDictionary *parameter = @{@"foo": @"bar", @"key": @"value"};
//    [manager POST:urlString parameters:parameter progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"Success: %@", responseObject);
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"Error 2 : %@", error);
//    }];
    
//
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]
//                                         initWithRequest:request];
//    operation.responseSerializer = [AFJSONResponseSerializer serializer];
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@", responseObject);
//    } failure:nil];
//    [operation start];
    
    
    return YES;
}

@end
