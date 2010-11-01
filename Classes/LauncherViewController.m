//
//  LauncherViewController.m
//  TheCarltonApp
//
//  Created by User on 2/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LauncherViewController.h"

@interface LauncherViewController(Private)

- (TTLauncherItem *)launcherItemWithTitle:(NSString *)pTitle image:(NSString *)image URL:(NSString *)url;

@end

@implementation LauncherViewController


- (void)loadView {
	[super loadView];
	
	launcherView = [[TTLauncherView alloc] initWithFrame:self.view.bounds];
	launcherView.backgroundColor = [UIColor blackColor];
	launcherView.columnCount = 4;
	launcherView.pages = [NSArray arrayWithObjects:
						  [NSArray arrayWithObjects:
						   [self launcherItemWithTitle:@"Google" image:@"bundle://safari_logo.png" URL:@"http://google.com"],
						   [self launcherItemWithTitle:@"Apple" image:@"bundle://safari_logo.png" URL:@"http://apple.com"]
						   , nil]
						  , nil];
	launcherView.delegate = self;
	
	[self.view addSubview:launcherView];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.title = @"The Carlton";
	
	self.navigationBarStyle = UIBarStyleBlackTranslucent;
	self.navigationBarTintColor = [UIColor clearColor]; 
	
	UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:launcherView action:@selector(beginEditing)];
	self.navigationItem.rightBarButtonItem = editButton;
	[editButton release];
}

- (void)viewDidUnload {
	[launcherView release];
	launcherView = nil;
	
	[super viewDidUnload];
}


#pragma mark -
#pragma mark Private methods

- (TTLauncherItem *)launcherItemWithTitle:(NSString *)pTitle image:(NSString *)image URL:(NSString *)url {
	TTLauncherItem *launcherItem = [[TTLauncherItem alloc] initWithTitle:pTitle 
																   image:image 
																	 URL:url canDelete:YES];
	
	return [launcherItem autorelease];
}


#pragma mark -
#pragma mark TTLauncherViewDelegate methods

- (void)launcherViewDidBeginEditing:(TTLauncherView*)launcher {
	UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:launcherView action:@selector(endEditing)];
	self.navigationItem.rightBarButtonItem = doneButton;
	[doneButton release];
}

- (void)launcherViewDidEndEditing:(TTLauncherView*)launcher {
	UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:launcherView action:@selector(endEditing)];
	self.navigationItem.rightBarButtonItem = editButton;
	[editButton release];
}

- (void)launcherView:(TTLauncherView*)launcher didSelectItem:(TTLauncherItem*)item {
	[[TTNavigator navigator] openURLAction:[TTURLAction actionWithURLPath:item.URL]];
}


#pragma mark -
#pragma mark Memory Handling methods

- (void)dealloc {
	[launcherView release];
	
	[super dealloc];
}

@end
