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

@synthesize description, promoImage, imageUrl, textField, ticketalert;

- (void)viewDidLoad {
	[self setTitle:@"The Box"];
	if ([[User sharedUser] boxOpen] == 2) {
		UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Box Locked" message:@"You have already redeemed your offer!" delegate:self cancelButtonTitle:@"Done" otherButtonTitles:nil] autorelease];
		[alert show];
	}
	else {
		NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(showRedeem) userInfo:nil repeats:NO];
	}

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

- (void) processRedeem:(id) sender
{
	[[User sharedUser] setBoxOpen:2];
	[ticketalert dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
	if (buttonIndex == 1) {
		
		ticketalert = [[UIAlertView alloc] initWithTitle:@"Show this at the bar" message:@"" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
		
		CGAffineTransform myTransform = CGAffineTransformMakeTranslation(0, 30);
		
//		UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 30, 234, 168)];
//		NSString *path = [[NSString alloc] initWithString:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"ticket_04.png"]];
//		UIImage *bkgImg = [[UIImage alloc] initWithContentsOfFile:path];
//		[imageView setImage:bkgImg];
//		[bkgImg release];
//		[path release];
		
		UIButton *ticketButton = [UIButton buttonWithType:UIButtonTypeCustom];

		ticketButton.frame = CGRectMake(20, 30, 234, 168);
		ticketButton.adjustsImageWhenHighlighted = NO;
		[ticketButton setImage:[UIImage imageNamed:@"ticket_04.png"] forState:UIControlStateNormal];
		[ticketButton setImage:[UIImage imageNamed:@"ticket_04_highlighted.png"] forState:UIControlStateHighlighted];
		[ticketButton addTarget:self action:@selector(processRedeem:) forControlEvents:UIControlEventTouchUpInside];
		
		[ticketalert setTransform:myTransform];
		
		[ticketalert addSubview:ticketButton];
//		[imageView release];
		
		textField = [[UITextField alloc] initWithFrame:CGRectMake(20.0, 200.0, 260.0, 25.0)]; 
		[textField setBackgroundColor:[UIColor whiteColor]];
		[textField setPlaceholder:@"passcode"];
		[textField setKeyboardType:UIKeyboardTypeNumberPad];
		[textField setSecureTextEntry:YES];
		[textField setReturnKeyType:UIReturnKeyGo];
		[textField becomeFirstResponder];
		[ticketalert addSubview:textField];
		
		
		[ticketalert show];
	}
}

- (void)willPresentAlertView:(UIAlertView *)alertView {
	if ([[alertView title] isEqualToString:@"Show this at the bar"]) {
		alertView.frame = CGRectMake( 12, 30, 300, 270 );
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
	[textField release];
	[description release];
	[ticketalert release];
    [super dealloc];
}


@end
