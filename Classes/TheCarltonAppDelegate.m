//
//  TheCarltonAppDelegate.m
//  TheCarlton
//
//  Created by Zuhair Naqvi on 11/12/10.
//  Copyright 2010 Fitzroy. All rights reserved.
//

#define ACCESS_TOKEN_KEY @"fb_access_token"
#define EXPIRATION_DATE_KEY @"fb_expiration_date"

#import "TheCarltonAppDelegate.h"

// Launcher Dependencies
#import "LauncherViewController.h"
#import "SyncViewController.h"
#import "BoxViewController.h"
#import "GalleryViewController.h"
#import "MenuRootViewController.h"
#import "ContactViewController.h"
#import "LocateViewController.h"
#import "BookingsViewController.h"
#import "NewsViewController.h"
#import "ShareViewController.h"
#import "MedallionViewController.h"
#import "User.h"

@implementation TheCarltonAppDelegate

@synthesize window, navigationController, prefs, facebook;

/*
 P1
 1. Prompts for phone email and website.*
 2. Location map.*
 3. Ticket.
 4. Change bookings titles to "restaurant booking".*
 5. Send user back to main screen on after share*
 6. Pop-up connect only if not connected*
 
 P2
 5. Camera post photos for Post to wall
 6. Replace checkin with MemberID - medalion.
 7. Replace menu images with like button.
 8. Free wifi popup.
 */

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
	//[self initSettingsDefaults];
	prefs = [NSUserDefaults standardUserDefaults];
	if ([prefs stringForKey:@"server"] == NULL) {
		[self initSettingsDefaults];
	}
	
	NSLog(@"%@", [prefs stringForKey:@"server"]);
	

	TTNavigator* navigator = [TTNavigator navigator];
	navigator.persistenceMode = TTNavigatorPersistenceModeNone;
	TTURLMap* map = navigator.URLMap;
	[map from:@"*" toViewController:[TTWebController class]];
	[map from:@"tt://menu/" toViewController:[MenuRootViewController class]];
	[map from:@"tt://contact/" toViewController:[ContactViewController class]];
	[map from:@"tt://photos/" toViewController:[GalleryViewController class]];
	[map from:@"tt://box/" toViewController:[BoxViewController class]];
	[map from:@"tt://bookings/" toViewController:[BookingsViewController class]];
	[map from:@"tt://news/" toViewController:[NewsViewController class]];
	[map from:@"tt://share/" toViewController:[ShareViewController class]];
	[map from:@"tt://sync/" toViewController:[SyncViewController class]];
	[map from:@"tt://medallion/" toViewController:[MedallionViewController class]];
	[map from:@"tt://launcher/" toViewController:[LauncherViewController class]];
//	//Child mapping
	[map from:@"tt://locate/" toViewController:[LocateViewController class]];
	
	if (![navigator restoreViewControllers]) {
		[navigator openURLAction:
		 [TTURLAction actionWithURLPath:@"tt://launcher"]];
	}
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	
	[[User sharedUser] loginWithUserId:[[prefs stringForKey:@"memberid"] intValue]];
	
	facebook = [[Facebook alloc] initWithAppId:[prefs stringForKey:@"fbappid"]];
	[self login];

//	
//	NSMutableDictionary * params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
//									@"SELECT name FROM user WHERE uid=me()", @"query",
//									nil];
//	[facebook requestWithMethodName:@"fql.query"
//						   andParams:params
//					   andHttpMethod:@"POST"
//						 andDelegate:self];
	
    return YES;
}

- (BOOL)navigator:(TTNavigator*)navigator shouldOpenURL:(NSURL*)URL {
	return YES;
}

- (void)login {
    // on login, use the stored access token and see if it still works
    facebook.accessToken = [prefs objectForKey:ACCESS_TOKEN_KEY];
    facebook.expirationDate = [prefs objectForKey:EXPIRATION_DATE_KEY];
	
	NSLog(@"Exp: %@", [prefs objectForKey:EXPIRATION_DATE_KEY]);
	
    // only authorize if the access token isn't valid
    // if it *is* valid, no need to authenticate. just move on
    if (![facebook isSessionValid]) {
		NSArray *permissions = [[NSArray arrayWithObjects:
								 @"read_stream",@"publish_stream",@"email",@"offline_access",nil] retain];
		
		
		[facebook authorize:permissions delegate:self];
    }
	[[NSNotificationCenter defaultCenter] postNotificationName:@"fbConnectEvent" object:self];
}



- (void)fbDidLogin {
	
    // store the access token and expiration date to the user defaults
    [prefs setObject:facebook.accessToken forKey:ACCESS_TOKEN_KEY];
    [prefs setObject:facebook.expirationDate forKey:EXPIRATION_DATE_KEY];
    [prefs synchronize];	    
}


- (BOOL)application:(UIApplication*)application handleOpenURL:(NSURL*)URL {
	
	if ([URL.scheme isEqualToString:[NSString stringWithFormat:@"fb%@",[prefs stringForKey:@"fbappid"]]]) {
		
		return [facebook handleOpenURL:URL]; 
		
	}
	
	else {
		
		[[TTNavigator navigator] openURLAction:[TTURLAction actionWithURLPath:URL.absoluteString]];	
		
	} 
	
	return YES;
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
	if (buttonIndex == 1) {
		[self login];
	}
}


- (void)request:(FBRequest *)request didLoad:(id)result
{
	//NSLog(@"hello");
	//[[User sharedUser] setFbUid:result];
	NSLog(@"%d", result);
}

- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
	//[self.label setText:[error localizedDescription]];
	UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Can't connect to Facebook" message:@"This could be temporary issue with your network or Facebook's servers." delegate:self cancelButtonTitle:@"Continue Without" otherButtonTitles:nil] autorelease];
    [alert addButtonWithTitle:@"Try Again"];
    [alert show];
	NSLog(@"FBRequest Error %@", [error localizedDescription]);
};


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

/*
 Load default prefernces on first load
 */

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



- (void)dealloc {
	[prefs release];
	[navigationController release];
    [window release];
    [super dealloc];
}


@end
