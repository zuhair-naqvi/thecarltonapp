//
//  BookingsViewController.m
//  TheCarlton
//
//  Created by James on 13/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BookingsViewController.h"


@implementation BookingsViewController

@synthesize numGuests, bookingTime;

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
	[self setTitle:@"Bookings"];
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    if(touch.phase == UITouchPhaseBegan) {
        [numGuests resignFirstResponder];
    }
}

- (IBAction) goBang:(id)sender
{
	
	UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Booking Request" message:@"We've received your booking request, we'll call you to confirm the booking." delegate:self cancelButtonTitle:@"Done" otherButtonTitles:nil] autorelease];
    // optional - add more buttons:
    //[alert addButtonWithTitle:@"Yes"];
    [alert show];
	
}


- (void)dealloc {
	[numGuests release];
	[bookingTime release];
    [super dealloc];
}


@end
