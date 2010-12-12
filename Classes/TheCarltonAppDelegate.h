//
//  TheCarltonAppDelegate.h
//  TheCarlton
//
//  Created by Zuhair Naqvi on 11/12/10.
//  Copyright 2010 Fitzroy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TheCarltonAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
	NSUserDefaults *prefs;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) NSUserDefaults *prefs;

- (void) initSettingsDefaults;

@end
