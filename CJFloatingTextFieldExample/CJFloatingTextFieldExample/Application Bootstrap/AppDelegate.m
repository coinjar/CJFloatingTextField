//
//  AppDelegate.m
//  CJFloatingTextFieldExample
//
//  Created by Aron on 22/01/2015.
//  Copyright (c) 2015 CoinJar. All rights reserved.
//

#import "AppDelegate.h"
#import "CJExampleViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[CJExampleViewController alloc] initWithNibName:@"CJExampleViewController" bundle:nil];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
