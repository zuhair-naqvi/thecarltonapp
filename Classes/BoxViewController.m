//
//  BoxViewController.m
//  TheCarltonApp
//
//  Created by Zuhair Naqvi on 5/12/10.
//  Copyright 2010 Fitzroy. All rights reserved.
// 

#import "BoxViewController.h"
#import "RemoteImage.h"

@implementation BoxViewController

@synthesize description, promoImage;

- (void)viewDidLoad {
	self.title = @"The Box";	
	description.backgroundColor = [UIColor clearColor];
	NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(showRedeem) userInfo:nil repeats:NO];
	
	//[[TTURLCache sharedCache] removeAll:YES];
	
	RemoteImage *img = [[RemoteImage alloc] init];
	img.delegate = self;
	[img imageFromServer:@"logogreen.png"];
	
}

- (void) remoteImageDidLoad:(UIImage*)image
{
	[promoImage setImage:image];
}

- (void) remoteImageDidNotLoad:(NSError*)error
{
	NSLog(@"Failed: %@",error);
}

- (void)showRedeem {
	UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"And it's Free" message:@"That's right, this one's on us :-)" delegate:self cancelButtonTitle:@"No Thanks" otherButtonTitles:nil] autorelease];
    [alert addButtonWithTitle:@"Redeem"];
    [alert show];	
}

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
    [super dealloc];
}


@end
