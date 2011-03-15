//
//  LauncherViewController.m
//  TheCarltonApp
//
//  Created by User on 2/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LauncherViewController.h"
#import "User.h"

@implementation LauncherViewController


@synthesize logoView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		self.title = @"Home";
		self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed: @"bg.jpg"]]; 
	}
	return self;
}


- (void)loadView {
	[super loadView];
	self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed: @"bg.jpg"]]; 
	self.navigationBarStyle = UIBarStyleBlackTranslucent;
	self.navigationBarTintColor = [UIColor colorWithRed:0.400 green:0.568 blue:0.025 alpha:7.5]; 
	
	logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.png"]];
	[logoView setCenter:CGPointMake((TTScreenBounds().size.width/2),40.0)];
	
	CGRect launcherRect = CGRectMake(0, 65, TTScreenBounds().size.width, (TTScreenBounds().size.height - 140));
	
	_launcherView = [[TTLauncherView alloc] initWithFrame:launcherRect];		
	_launcherView.delegate = self;
	_launcherView.columnCount = 3;
	_launcherView.pages = [NSArray arrayWithObjects:
						   [NSArray arrayWithObjects:
							[[[TTLauncherItem alloc] initWithTitle:@"Contact"
															 image:@"bundle://contact.png"
															   URL:@"tt://contact/" canDelete:NO] autorelease],
							[[[TTLauncherItem alloc] initWithTitle:@"Bookings"
															 image:@"bundle://bookings.png"
															   URL:@"tt://bookings/" canDelete:NO] autorelease],
							[[[TTLauncherItem alloc] initWithTitle:@"Food & Drinks"
															 image:@"bundle://menu.png"
															   URL:@"tt://menu/" canDelete:NO] autorelease],
							[[[TTLauncherItem alloc] initWithTitle:@"The Box"
															 image:@"bundle://free.png"
															   URL:@"tt://box/" canDelete:NO] autorelease],
							[[[TTLauncherItem alloc] initWithTitle:@"News"
															 image:@"bundle://news.png"
															   URL:@"tt://news/" canDelete:NO] autorelease],
							[[[TTLauncherItem alloc] initWithTitle:@"Photos"
															 image:@"bundle://cameraimg.png"
															   URL:@"tt://photos/" canDelete:NO] autorelease],	
							[[[TTLauncherItem alloc] initWithTitle:@"Check In"
															 image:@"bundle://checkin.png"
															   URL:nil canDelete:NO] autorelease],
							[[[TTLauncherItem alloc] initWithTitle:@"Share"
															 image:@"bundle://share.png"
															   URL:@"tt://share/" canDelete:NO] autorelease],
							[[[TTLauncherItem alloc] initWithTitle:@"Sync"
															 image:@"bundle://sync_01.png"
															   URL:@"tt://sync/" canDelete:NO] autorelease],								
							nil],
						   nil
						   ];
	[self.view addSubview:logoView];
	[self.view addSubview:_launcherView];
	[logoView retain];
	TTLauncherItem* box = [_launcherView itemWithURL:@"tt://box/"];
	box.badgeNumber = 1;
	
	TTLauncherItem* photos = [_launcherView itemWithURL:@"tt://photos/"];
	photos.badgeNumber = 5;	
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// TTLauncherViewDelegate

- (void)launcherView:(TTLauncherView*)launcher didSelectItem:(TTLauncherItem*)item {
    [[TTNavigator navigator] openURLAction:[[TTURLAction actionWithURLPath:item.URL] applyAnimated:YES]];
}

- (void)launcherViewDidBeginEditing:(TTLauncherView*)launcher {
	[self.navigationItem setRightBarButtonItem:[[[UIBarButtonItem alloc]
												 initWithBarButtonSystemItem:UIBarButtonSystemItemDone
												 target:_launcherView action:@selector(endEditing)] autorelease] animated:YES];
}

- (void)launcherViewDidEndEditing:(TTLauncherView*)launcher {
	[self.navigationItem setRightBarButtonItem:nil animated:YES];
}


- (void)dealloc {
	[logoView release];
	[super dealloc];
}


@end
