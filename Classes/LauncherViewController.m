//
//  LauncherViewController.m
//  TheCarltonApp
//
//  Created by User on 2/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LauncherViewController.h"
#import "User.h"
#import "TheCarltonAppDelegate.h"

@implementation LauncherViewController


@synthesize logoView, facebook;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		self.title = @"Loading...";
		//NSLog(@"Fb id: %d", [[User sharedUser] fbUid]);
			
		[[NSNotificationCenter defaultCenter]
		addObserver:self
		selector:@selector(fbConnected:)
		name:@"fbConnectEvent"
		object:nil];
		self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed: @"bg.jpg"]]; 
	}
	return self;
}

- (void) fbConnected:(id) sender {
	NSLog(@"FbDidLogin");	
	TheCarltonAppDelegate *appDelegate = (TheCarltonAppDelegate *)[[UIApplication sharedApplication] delegate];
	[[appDelegate facebook] requestWithGraphPath:@"me" andDelegate:self];
}

- (void)request:(FBRequest *)request didLoad:(id)result
{
	NSLog(@"My result: %@", result);
	[[User sharedUser] setFbUser:result];
	self.title = [NSString stringWithFormat:@"Hi %@", [result valueForKey:@"first_name"]];
	
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
	if (buttonIndex == 1) {
		[self fbConnected:self];
	}
}


- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
	//[self.label setText:[error localizedDescription]];
	UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Can't connect to Facebook" message:@"This could be temporary issue with your network or Facebook's servers." delegate:self cancelButtonTitle:@"Continue Without" otherButtonTitles:nil] autorelease];
    [alert addButtonWithTitle:@"Try Again"];
    [alert show];
	NSLog(@"FBRequest Error %@", [error localizedDescription]);
};


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
	if ([item.title isEqualToString:@"Share"]) {
		TheCarltonAppDelegate *appDelegate = (TheCarltonAppDelegate *)[[UIApplication sharedApplication] delegate];
		
		SBJSON *jsonWriter = [[SBJSON new] autorelease];
		
		NSDictionary* actionLinks = [NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:
															   @"Always Running",@"text",@"http://itsti.me/",@"href", nil], nil];
		
		NSString *actionLinksStr = [jsonWriter stringWithObject:actionLinks];
		NSDictionary* attachment = [NSDictionary dictionaryWithObjectsAndKeys:
									@"a long run", @"name",
									@"The Facebook Running app", @"caption",
									@"it is fun", @"description",
									@"http://itsti.me/", @"href", nil];
		NSString *attachmentStr = [jsonWriter stringWithObject:attachment];
		NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
									   @"Share on Facebook",  @"user_message_prompt",
									   actionLinksStr, @"action_links",
									   attachmentStr, @"attachment",
									   nil];
		
		
		[[appDelegate facebook] dialog:@"stream.publish"
							 andParams:params
						   andDelegate:self];
	}
	else {
		[[TTNavigator navigator] openURLAction:[[TTURLAction actionWithURLPath:item.URL] applyAnimated:YES]];
	}    
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
