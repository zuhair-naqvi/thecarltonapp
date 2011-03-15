//
//  TheCarltonAppDelegate.h
//  TheCarlton
//
//  Created by Zuhair Naqvi on 11/12/10.
//  Copyright 2010 Fitzroy. All rights reserved.
//

#import "Three20/Three20.h"
#import "FBConnect.h"

@interface TheCarltonAppDelegate : NSObject <UIApplicationDelegate, FBRequestDelegate, FBSessionDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
	NSUserDefaults *prefs;
	Facebook *facebook;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) NSUserDefaults *prefs;
@property (nonatomic, retain) Facebook *facebook;
- (void) initSettingsDefaults;
@end
