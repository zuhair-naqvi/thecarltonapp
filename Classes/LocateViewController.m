//
//  LocateViewController.m
//  TheCarltonApp
//
//  Created by Zuhair Naqvi on 27/11/10.
//  Copyright 2010 Fitzroy. All rights reserved.
//

#import "LocateViewController.h"


@implementation LocateViewController

@synthesize homeButton;
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
    [super viewDidLoad];
//	homeButton = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"53-house.png"] 
//												   style:UIBarButtonItemStylePlain target:self action:@selector(goHome)] autorelease];
//	[self.navigationItem setRightBarButtonItem:homeButton];
}

//- (void) goHome {
//	[[TTNavigator navigator] openURLAction:[[TTURLAction actionWithURLPath:@"tt://launcher"] applyAnimated:YES]];
//}

- (IBAction) goMaps:(id)sender
{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://maps.google.com/maps?q=193%20Bourke%20Street%2C%20Melbourne%2C%20VIC%2C%203000"]];
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
//	[homeButton release];
    [super dealloc];
}


@end
