//
//  RosterViewController.m
//  TheCarlton
//
//  Created by Zuhair Naqvi on 28/12/10.
//  Copyright 2010 Fitzroy. All rights reserved.
//

#import "RosterViewController.h"


@implementation RosterViewController

@synthesize monday, tuesday, wednesday, thursday, friday, saturday, sunday;

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
    [super viewDidLoad];
	
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	RemoteDictionary *dict = [[RemoteDictionary alloc] init];
	[dict setDelegate:self];
	[dict dictionaryFromServer:[NSString stringWithFormat:@"roster/plist/id/%d", [[prefs stringForKey:@"memberid"] integerValue]]];
	
	self.navigationItem.title = @"Loading Roster...";
}


- (void) remoteDictionaryDidLoad:(NSDictionary*)dict
{
	self.navigationItem.title = @"Roster";
	monday.text = [NSString stringWithFormat:@"Monday: %@", [[[dict objectForKey:@"Rows"] objectAtIndex:0] objectForKey:@"Monday"]];
	tuesday.text = [NSString stringWithFormat:@"Tuesday: %@", [[[dict objectForKey:@"Rows"] objectAtIndex:0] objectForKey:@"Tuesday"]];
	wednesday.text = [NSString stringWithFormat:@"Wednesday: %@", [[[dict objectForKey:@"Rows"] objectAtIndex:0] objectForKey:@"Wednesday"]];
	thursday.text = [NSString stringWithFormat:@"Thursday: %@", [[[dict objectForKey:@"Rows"] objectAtIndex:0] objectForKey:@"Thursday"]];
	friday.text = [NSString stringWithFormat:@"Friday: %@", [[[dict objectForKey:@"Rows"] objectAtIndex:0] objectForKey:@"Friday"]];
	saturday.text = [NSString stringWithFormat:@"Saturday: %@", [[[dict objectForKey:@"Rows"] objectAtIndex:0] objectForKey:@"Saturday"]];
	sunday.text = [NSString stringWithFormat:@"Sunday: %@", [[[dict objectForKey:@"Rows"] objectAtIndex:0] objectForKey:@"Sunday"]];
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
	[monday release];
	[tuesday release];
	[wednesday release];
	[thursday release];
	[friday release];
	[saturday release];
	[sunday release];
    [super dealloc];
}


@end
