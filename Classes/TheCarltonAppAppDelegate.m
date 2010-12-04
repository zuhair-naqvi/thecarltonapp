//
//  TheCarltonAppAppDelegate.m
//  TheCarltonApp
//
//  Created by User on 2/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TheCarltonAppAppDelegate.h"
#import "Three20/Three20.h"
#import "LauncherViewController.h"
#import "MenuRootViewController.h"
#import "ContactViewController.h"
#import "GalleryViewController.h"
#import "PhotosViewController.h"
#import "LocateViewController.h"
#import "BoxViewController.h"

@implementation TheCarltonAppAppDelegate

@synthesize window;
@synthesize navigationController;
@synthesize data;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    

	//[[NSUserDefaults standardUserDefaults] registerDefaults:[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Root" ofType:@"plist"]]];
	[self initSettingsDefaults];

	TTNavigator* navigator = [TTNavigator navigator];
	navigator.persistenceMode = TTNavigatorPersistenceModeNone;
	TTURLMap* map = navigator.URLMap;
	[map from:@"*" toViewController:[TTWebController class]];
	[map from:@"tt://menu/" toViewController:[MenuRootViewController class]];
	[map from:@"tt://contact/" toViewController:[ContactViewController class]];
	[map from:@"tt://gallery/" toViewController:[GalleryViewController class]];
	[map from:@"tt://box/" toViewController:[BoxViewController class]];
	[map from:@"tt://launcher/" toViewController:[LauncherViewController class]];
	//Child mapping
	[map from:@"tt://locate/" toViewController:[LocateViewController class]];
	
	if (![navigator restoreViewControllers]) {
		[navigator openURLAction:
		 [TTURLAction actionWithURLPath:@"tt://launcher"]];
	}
	//[window makeKeyAndVisible];
	
	//Load Menu data
//	NSString *Path = [[NSBundle mainBundle] bundlePath];
//	NSString *DataPath = [Path stringByAppendingPathComponent:@"data.plist"];
	
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];	
	NSString *server = [prefs stringForKey:@"server"];	
	NSString *urlStr = [[NSString alloc] 
						initWithFormat:@"http://%@/front_dev.php/menu/plist?seedVar=%f", server, 
						(float)random()/RAND_MAX];
	NSLog(@"%@", urlStr);
	NSURL *url = [NSURL URLWithString:urlStr];
	
	//[[NSDictionary alloc] initWithContentsOfFile:DataPath];
	NSDictionary *tempDict = [[NSDictionary alloc] initWithContentsOfURL:url];//[NSDictionary dictionaryWithContentsOfURL:url];
	self.data = tempDict;
	[tempDict release];
	[urlStr release];
	[url release];
	
	//Register for push notifications
	NSLog(@"Registering for push notifications...");    
    [[UIApplication sharedApplication] 
	 registerForRemoteNotificationTypes:
	 (UIRemoteNotificationTypeAlert | 
	  UIRemoteNotificationTypeBadge | 
	  UIRemoteNotificationTypeSound)];
	
    return YES;
}

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken { 
	
    NSString *str = [NSString 
					 stringWithFormat:@"Device Token=%@",deviceToken];
    NSLog(@" %@",str);
	
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err { 
	
    NSString *str = [NSString stringWithFormat: @"Error: %@", err];
    NSLog(@" %@", str);    
	
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
	
    for (id key in userInfo) {
        NSLog(@"key: %@, value: %@", key, [userInfo objectForKey:key]);
    }    
	
}

- (BOOL)application:(UIApplication*)application handleOpenURL:(NSURL*)URL {
	[[TTNavigator navigator] openURLAction:[TTURLAction actionWithURLPath:URL.absoluteString]];
	return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
	[data release];
	[navigationController release];
	[window release];
    [super dealloc];
}

/** Loads user preferences database from Settings.bundle plists. */
- (void) initSettingsDefaults
{
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	
	//Determine the path to our Settings.bundle.
	NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
	NSString *settingsBundlePath = [bundlePath stringByAppendingPathComponent:@"Settings.bundle"];
	
	// Load paths to all .plist files from our Settings.bundle into an array.
	NSArray *allPlistFiles = [NSBundle pathsForResourcesOfType:@"plist" inDirectory:settingsBundlePath];
	
	// Put all of the keys and values into one dictionary,
	// which we then register with the defaults.
	NSMutableDictionary *preferencesDictionary = [NSMutableDictionary dictionary];
	
	// Copy the default values loaded from each plist
	// into the system's sharedUserDefaults database.
	NSString *plistFile;
	for (plistFile in allPlistFiles)
	{
		
		// Load our plist files to get our preferences.
		NSDictionary *settingsDictionary = [NSDictionary dictionaryWithContentsOfFile:plistFile];
		NSArray *preferencesArray = [settingsDictionary objectForKey:@"PreferenceSpecifiers"];
		
		// Iterate through the specifiers, and copy the default
		// values into the DB.
		NSDictionary *item;
		for(item in preferencesArray)
		{
			// Obtain the specifier's key value.
			NSString *keyValue = [item objectForKey:@"Key"];
			
			// Using the key, return the DefaultValue if specified in the plist.
			// Note: We won't know the object type until after loading it.
			id defaultValue = [item objectForKey:@"DefaultValue"];
			
			// Some of the items, like groups, will not have a Key, let alone
			// a default value.  We want to safely ignore these.
			if (keyValue && defaultValue)
			{
				[preferencesDictionary setObject:defaultValue forKey:keyValue];
			}
			
		}
		
	}
	
	// Ensure the version number is up-to-date, too.
	// This is, incidentally, how you update the value in a Title element.
	NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
	NSString *shortVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
	NSString *versionLabel = [NSString stringWithFormat:@"%@ (%d)", shortVersion, [version intValue]];
	[standardUserDefaults setObject:versionLabel forKey:@"app_version_number"];
	
	// Now synchronize the user defaults DB in memory
	// with the persistent copy on disk.
	[standardUserDefaults registerDefaults:preferencesDictionary];
	[standardUserDefaults synchronize];
}


@end
