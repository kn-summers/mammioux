//
//  MXAppDelegate.m
//  Mammioux6
//
//  Created by Teresa Van Dusen on 7/26/13.
//  Copyright (c) 2013 mammioux. All rights reserved.
//

#import "MXAppDelegate.h"
#import "MammiouxViewController.h"
#import "SettingsViewController.h"

@implementation MXAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
	// read the current settings
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	
    
	if ([[NSUserDefaults standardUserDefaults] objectForKey:@"firstTime"]==nil ){
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"MAMMIOUX" message:@"First Time use"
													   delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
		[alert show];
		
        // get default settings from file
		NSString *filename = @"timers.plist";
		NSString *path = [[NSBundle mainBundle] bundlePath];
		NSString *fullPath = [path stringByAppendingPathComponent:filename];
		_settings = [[NSMutableDictionary alloc] initWithContentsOfFile:fullPath];
        // add default values to user defaults
		NSLog(@"Dump Settings");
		for (id key in _settings)
		{
			NSLog(@"key: %@, value: %@", key, [_settings objectForKey:key]);
			[[NSUserDefaults standardUserDefaults] setObject:[_settings objectForKey:key] forKey:key];
		}
		[[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstTime"];
		NSDictionary *appDefaults = [[NSUserDefaults standardUserDefaults] dictionaryRepresentation];
        //register persistent domain
		[defaults setPersistentDomain:appDefaults forName:@"mammioux"];
		[[NSUserDefaults standardUserDefaults] synchronize];
	}
	
	
    // remove the status bar.
	[[UIApplication sharedApplication] setStatusBarHidden:YES];
    [self.window makeKeyAndVisible];
	
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

@end
