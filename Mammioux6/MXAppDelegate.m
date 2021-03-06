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
        
        // register for remote notifications
        
        [application registerUserNotificationSettings:
         [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:nil]];
        [application registerForRemoteNotifications];
        
        // schedule local notifications
        
        // Post local notification
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        notification.fireDate = [NSDate date];
        notification.timeZone = [NSTimeZone defaultTimeZone];
        
        // Set notification text
        NSString *alertText = nil;
        
        alertText = @"Testing sending notifications to watch";
        notification.alertBody = alertText;
        
        // Set the action button
        notification.alertAction = NSLocalizedString(@"CORRECT_ISSUES", nil);
        notification.soundName = UILocalNotificationDefaultSoundName;
        notification.applicationIconBadgeNumber = 1;
        
        
        UILocalNotification *localNotif = [[UILocalNotification alloc] init];
        if (localNotif) {
            localNotif.alertBody = NSLocalizedString(@"OPT_OUT_LOCAL_NOTIFICATION_MESSAGE", nil);
            localNotif.applicationIconBadgeNumber = 1;
            localNotif.soundName = UILocalNotificationDefaultSoundName;
            localNotif.fireDate=[NSDate dateWithTimeIntervalSinceNow:300.0f];
            [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
        }
        
        UIAlertView *av = [UIAlertView new];
        
        [av initWithTitle:@"ALERT TITLE" message:@"Message" delegate:self cancelButtonTitle:nil otherButtonTitles:@[@"Continue"]];

        // Schedule the notification
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
	}
	
	
    [self.window makeKeyAndVisible];
	
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    NSLog(@"App will resign active");
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSLog(@"Application entered Background");

        UIApplicationState state = [application applicationState];
        if (state == UIApplicationStateInactive) {
            NSLog(@"Sent to background by locking screen");
        } else if (state == UIApplicationStateBackground) {
            NSLog(@"Sent to background by home button/switching to other app");
        } 

//    [self applicationWillTerminate:application];
//    exit(0);

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
    NSLog(@"Application will terminate");
}

@end
