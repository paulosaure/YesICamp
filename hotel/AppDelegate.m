//
//  AppDelegate.m
//  hotel
//
//  Created by Paul Lavoine on 20/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "AppDelegate.h"
#import "DeconnectionUserAction.h"
#import "GetUUIDAction.h"
#import "User.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [self initPushNotifications];
    
    // Try to fetch user location
    [[LocationManager sharedInstance] updateLocation];
    
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"application:didRegisterForRemoteNotificationsWithDeviceToken: %@", deviceToken);
    self.deviceToken = deviceToken;

    // Send registration to Neolane
    [[self class] sendRegistrationToServer];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"Error: %@", error);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [[NetworkManagement sharedInstance] addNewAction:[DeconnectionUserAction action]
                                              method:DELETE_METHOD];
}

#pragma mark - Push notifications
- (void)initPushNotifications
{
    // Register for alert notifications
    if ([APPLICATION respondsToSelector:@selector(registerUserNotificationSettings:)])
    {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)
                                                                                 categories:nil];
        [APPLICATION registerUserNotificationSettings:settings];
    }
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    [application registerForRemoteNotifications];
}

+ (void)sendRegistrationToServer
{
    NSData *deviceToken = [APP_DELEGATE deviceToken];
    if (!deviceToken)
        return;
    
    NSString *name = [User sharedInstance].lastName ? [User sharedInstance].lastName : @"";
    [[NetworkManagement sharedInstance] addNewAction:[GetUUIDAction action:[[NSString alloc] initWithData:deviceToken encoding:NSUTF8StringEncoding]
                                                                      name:name]
                                              method:POST_METHOD];
}

- (void)dealloc
{
    [NOTIFICATION_CENTER removeObserver:self];
}

@end
