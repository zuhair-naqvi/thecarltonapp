//
//  BoxViewController.m
//  TheCarltonApp
//
//  Created by Zuhair Naqvi on 5/12/10.
//  Copyright 2010 Fitzroy. All rights reserved.
//

#import "BoxViewController.h"


@implementation BoxViewController

@synthesize description, timer;
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	self.title = @"The Box";
	description.backgroundColor = [UIColor clearColor];
	timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(showRedeem) userInfo:nil repeats:NO];
}

- (void)showRedeem {
	UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"And it's Free" message:@"That's right, this one's on us :-)" delegate:self cancelButtonTitle:@"No Thanks" otherButtonTitles:nil] autorelease];
    // optional - add more buttons:
    [alert addButtonWithTitle:@"Redeem"];
    [alert show];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[description release];
	[timer release];
    [super dealloc];
}


@end