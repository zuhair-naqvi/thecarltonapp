//
//  LauncherViewController.m
//  TheCarltonApp
//
//  Created by User on 2/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LauncherViewController.h"

@implementation LauncherViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		self.title = @"Home";
		self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed: @"bg.gif"]]; 
	}
	return self;
}

- (void)loadView {
	[super loadView];
	
	self.navigationBarStyle = UIBarStyleBlackTranslucent;
	self.navigationBarTintColor = [UIColor colorWithRed:0.400 green:0.568 blue:0.025 alpha:7.5]; 
	
	UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.png"]];
	[logoView setCenter:CGPointMake((TTScreenBounds().size.width/2),40.0)];
	CGRect launcherRect = CGRectMake(0, 65, TTScreenBounds().size.width, (TTScreenBounds().size.height - 140));
	_launcherView = [[TTLauncherView alloc] initWithFrame:launcherRect];
	//_launcherView.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed: @"bg.gif"]]; 
	_launcherView.delegate = self;
	_launcherView.columnCount = 3;
	_launcherView.pages = [NSArray arrayWithObjects:
						   [NSArray arrayWithObjects:
							[[[TTLauncherItem alloc] initWithTitle:@"Contact"
															 image:@"bundle://phone.png"
															   URL:nil canDelete:NO] autorelease],
							[[[TTLauncherItem alloc] initWithTitle:@"Bookings"
															 image:@"bundle://bookings.png"
															   URL:nil canDelete:NO] autorelease],
							[[[TTLauncherItem alloc] initWithTitle:@"Menu"
															 image:@"bundle://menu.png"
															   URL:nil canDelete:YES] autorelease],
							[[[TTLauncherItem alloc] initWithTitle:@"Free"
															 image:@"bundle://free.png"
															   URL:@"fb://item4" canDelete:YES] autorelease],
							[[[TTLauncherItem alloc] initWithTitle:@"News"
															 image:@"bundle://news.png"
															   URL:@"fb://item5" canDelete:YES] autorelease],
							[[[TTLauncherItem alloc] initWithTitle:@"Photos"
															 image:@"bundle://photos.png"
															   URL:nil canDelete:YES] autorelease],	
							[[[TTLauncherItem alloc] initWithTitle:@"Check In"
															 image:@"bundle://checkin.png"
															   URL:nil canDelete:YES] autorelease],
							[[[TTLauncherItem alloc] initWithTitle:@"Share"
															 image:@"bundle://share.png"
															   URL:nil canDelete:YES] autorelease],
							[[[TTLauncherItem alloc] initWithTitle:@"Settings"
															 image:@"bundle://settings.png"
															   URL:nil canDelete:YES] autorelease],								
							nil],
						   [NSArray arrayWithObjects:
							[[[TTLauncherItem alloc] initWithTitle:@"Share"
															 image:@"bundle://Stumbler.png"
															   URL:nil canDelete:YES] autorelease],
							[[[TTLauncherItem alloc] initWithTitle:@"Settings"
															 image:@"bundle://Settings.png"
															   URL:nil canDelete:YES] autorelease],
							nil],
						   nil
						   ];
	[self.view addSubview:logoView];
	[self.view addSubview:_launcherView];
	
	TTLauncherItem* free = [_launcherView itemWithURL:@"fb://item4"];
	free.badgeNumber = 2;
	
	TTLauncherItem* news = [_launcherView itemWithURL:@"fb://item5"];
	news.badgeNumber = 5;
	
//	[self.view addSubview:launcherView];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// TTLauncherViewDelegate

- (void)launcherView:(TTLauncherView*)launcher didSelectItem:(TTLauncherItem*)item {
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
	[super dealloc];
}


@end
