//
//  SyncViewController.m
//  TheCarlton
//
//  Created by Zuhair Naqvi on 12/12/10.
//  Copyright 2010 Fitzroy. All rights reserved.
//

#import "SyncViewController.h"

@implementation SyncViewController

@synthesize syncStatus, spinner, rdict, rimg;

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
    rdict = [[RemoteDictionary alloc] init];
	[rdict setDelegate:self];
	
	rimg = [[RemoteImage alloc] init];
	[rimg setDelegate: self];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (IBAction) sync:(id)sender {
	self.navigationItem.title = @"Synchronising...";
	[spinner startAnimating];
	[syncStatus setHidden:NO];
	[[TTURLCache sharedCache] removeAll:YES];
	[self syncBox];
	[self syncMenu];
}

- (void) syncMenu {
	[syncStatus setText:@"Loading Menu"];	
	[rdict dictionaryFromServer:@"menu.xml"];	
}

- (void) syncBox {
	[syncStatus setText:@"Filling the Box"];
	[rdict dictionaryFromServer:@"box.xml"];
}

- (void) remoteImageDidLoad:(UIImage*)image
{
	//[syncStatus setText:@"Box Filled"];
}

- (void) remoteDictionaryDidLoad:(NSDictionary*)dict
{
	NSLog(@"Dict: %@", dict);
	if ([dict valueForKey:@"Rows"] == NULL) {
		[syncStatus setText:@"Box Filled"];
		[rimg imageFromServer:[dict objectForKey:@"picture"]];
	}
	else {
		/*
		 * @todo Get array diff of previous menu and new one to update menu badge with new items
		 */
		[spinner stopAnimating];
		[syncStatus setText:@"Sync Complete!"];
		self.navigationItem.title = @"";
	}

}
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
	[rdict release];
	[rimg release];
	[syncStatus release];
	[spinner release];
    [super dealloc];
}


@end
