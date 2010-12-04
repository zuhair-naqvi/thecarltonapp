//
//  MenuViewController.m
//  TheCarltonApp
//
//  Created by Zuhair on 6/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MenuViewController.h"

@implementation MenuViewController
@synthesize contactButton, menuMainTable, menuTableController;
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
	self.title = @"Food & Drinks";
	contactButton = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"18-envelope.png"] 
												  style:UIBarButtonItemStylePlain target:self action:@selector(goContact)] autorelease];
	[self.navigationItem setRightBarButtonItem:contactButton];
	
	menuTableController = [[MenuTableController alloc] init];
	
	menuMainTable.delegate = menuTableController;
	menuMainTable.dataSource = menuTableController;
	
	menuMainTable.backgroundColor = [UIColor clearColor];
}

- (void) goContact {
	[[TTNavigator navigator] openURLAction:[[TTURLAction actionWithURLPath:@"tt://contact"] applyAnimated:YES]];
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
//	[menuTableController release];
//	[menuMainTable release];
    [super dealloc];
}


@end
