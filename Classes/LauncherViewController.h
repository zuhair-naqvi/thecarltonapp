//
//  LauncherViewController.h
//  TheCarltonApp
//
//  Created by User on 2/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Three20/Three20.h"
#import "FBConnect.h"

@interface LauncherViewController : TTViewController <TTLauncherViewDelegate, FBRequestDelegate, FBSessionDelegate, UIImagePickerControllerDelegate> {
	TTLauncherView* _launcherView;
	UIImageView *logoView;
	Facebook *facebook;
}

@property (nonatomic, retain) UIImageView *logoView;
@property (nonatomic, retain) Facebook *facebook;

- (void) goCamera;


@end
