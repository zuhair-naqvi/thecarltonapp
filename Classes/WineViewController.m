//
//  WineViewController.m
//  TheCarltonApp
//
//  Created by Zuhair Naqvi on 28/11/10.
//  Copyright 2010 Fitzroy. All rights reserved.
//

#import "WineViewController.h"


@implementation WineViewController

//@synthesize contactButton, wineMainTable, wineTableController;
@synthesize wineMainTable, wineTableController;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"Food & Drinks";
//	contactButton = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"18-envelope.png"] 
//													  style:UIBarButtonItemStylePlain target:self action:@selector(goContact)] autorelease];
//	[self.navigationItem setRightBarButtonItem:contactButton];
	
	wineTableController = [[WineTableController alloc] init];
	
	wineMainTable.delegate = wineTableController;
	wineMainTable.dataSource = wineTableController;
	
	wineMainTable.backgroundColor = [UIColor clearColor];
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
    [super dealloc];
}


@end
