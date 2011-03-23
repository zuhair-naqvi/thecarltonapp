//
//  BoxViewController.m
//  TheCarltonApp
//
//  Created by Zuhair Naqvi on 5/12/10.
//  Copyright 2010 Fitzroy. All rights reserved.
// 

#import "BoxViewController.h"
#import "RemoteDictionary.h"
#import "RemoteImage.h"
#import "User.h"

@implementation BoxViewController

@synthesize description, promoImage, imageUrl;

- (void)viewDidLoad {
	[self setTitle:@"The Box"];
	NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(showRedeem) userInfo:nil repeats:NO];
    RemoteDictionary *rdict = [[RemoteDictionary alloc] init];
	[rdict setDelegate:self];	
	[rdict dictionaryFromServer:@"box/plist"];
}

- (void) remoteDictionaryDidLoad:(NSDictionary*)dict
{
	[description setText:[dict valueForKey:@"description"]];
	RemoteImage *rimg = [[RemoteImage alloc] init];
	[rimg setDelegate:self];	
	[rimg imageFromServer:[dict valueForKey:@"picture"]];
}

- (void) remoteImageDidLoad:(UIImage*)image
{
	[promoImage setImage:image];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
	if (buttonIndex == 1) {
		UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Show this at the bar" message:@"\n\n\n\n\n\n\n" delegate:self cancelButtonTitle:nil otherButtonTitles:nil] autorelease];
		[alert addButtonWithTitle:@"Done"];
		
		UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 30, 234, 168)];
		NSString *path = [[NSString alloc] initWithString:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"ticket_04.png"]];
		UIImage *bkgImg = [[UIImage alloc] initWithContentsOfFile:path];
		[imageView setImage:bkgImg];
		[bkgImg release];
		[path release];
		
		[alert addSubview:imageView];
		[imageView release];
		
		[alert show];
	}
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
