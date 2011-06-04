//
//  MedallionViewController.m
//  TheCarlton
//
//  Created by James on 11/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MedallionViewController.h"
#import "User.h"

@implementation MedallionViewController

@synthesize memberId, memberLevel, deviceId, medallionImage;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	self.title = @"The Medallion";
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	memberId.text = [prefs stringForKey:@"memberid"];
	memberLevel.text = [[User sharedUser] level];
	deviceId.text = [[UIDevice currentDevice] uniqueIdentifier];
	if ([[[User sharedUser] level] isEqualToString:@"Gold"]) {
		[medallionImage initWithContentsOfFile:@"medallion_black.png"];
	}
    [super viewDidLoad];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
