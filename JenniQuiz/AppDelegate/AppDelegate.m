//
//  AppDelegate.m
//  JenniQuiz
//
//  Created by Jennifer Nguyen on 24/10/2014.
//  Copyright (c) 2013 Jennifer Nguyen. All rights reserved.
//


#import "AppDelegate.h"
#import "Config.h"
#import "UIImageAverageColorAddition.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self customizeTheme];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void)customizeTheme{
    
    NSString* backgroundImage = [Config sharedInstance].mainBackground;
    UIImage* image = [UIImage imageNamed:backgroundImage];
    UIColor* navigationColor = [image averageColor];
    
    [UINavigationBar appearance].tintColor = [self foregroundColor];
    [UINavigationBar appearance].barTintColor = navigationColor;
    NSMutableDictionary* navbarAttributes = [NSMutableDictionary dictionary];
    navbarAttributes[NSFontAttributeName] = [UIFont fontWithName:[Config sharedInstance].boldFont size:19.0f];
    navbarAttributes[NSForegroundColorAttributeName] = [self foregroundColor];
    [UINavigationBar appearance].titleTextAttributes = navbarAttributes;
    
    NSMutableDictionary* barButtonAttributes = [NSMutableDictionary dictionary];
    barButtonAttributes[NSFontAttributeName] = [UIFont fontWithName:[Config sharedInstance].boldFont size:14.0f];
    barButtonAttributes[NSForegroundColorAttributeName] = [self foregroundColor];
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:barButtonAttributes forState:UIControlStateNormal];
}

- (UIColor*)foregroundColor{
    return [UIColor whiteColor];
}

- (UIColor*)viewBackgroundColor{
    
    NSString* backgroundImage = [Config sharedInstance].mainBackground;
    return [UIColor colorWithPatternImage:[UIImage imageNamed:backgroundImage]];
}

@end
