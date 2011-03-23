//
//  DetailViewController.m
//  DrillDownApp
//
//  Created by iPhone SDK Articles on 3/8/09.
//  Copyright www.iPhoneSDKArticles.com 2009. 
//

#import "DetailViewController.h"
#import "TheCarltonAppDelegate.h"
#import "User.h"

@implementation DetailViewController

@synthesize itemDesc, itemPic, itemDescText, itemPicView, spinner;

- (void)viewDidLoad {
    [super viewDidLoad];
	
	itemDescText.text = itemDesc;

	spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	[spinner setCenter:CGPointMake(itemPicView.bounds.size.width/2, itemPicView.bounds.size.height/2)]; // I do this because I'm in landscape mode
	[itemPicView addSubview:spinner]; 
	[spinner startAnimating];
	
//	NSString *imageUrl = [NSString stringWithFormat:@"images/%@",itemPic];
	RemoteImage *itemImage = [[RemoteImage alloc] init];
	[itemImage setDelegate:self];
	[itemImage imageFromServer:itemPic];
}

- (void) remoteImageDidLoad:(UIImage*)img
{
	[spinner stopAnimating];
	[spinner release];
	itemPicView.image = img;
}

- (void) remoteImageDidNotLoad:(NSError*)error
{
	NSLog(@"failed: %@", error);
	[spinner stopAnimating];
	[spinner release];	
	itemPicView.image = [UIImage imageNamed:@"logogreen.png"];
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

- (IBAction) loveButton:(id) sender {
	TheCarltonAppDelegate *appDelegate = (TheCarltonAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	SBJSON *jsonWriter = [[SBJSON new] autorelease];
	
	NSDictionary* actionLinks = [NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:
														   @"Vist The Carlton",@"text",@"http://www.thecarlton.com.au/",@"href", nil], nil];
	
	NSString *actionLinksStr = [jsonWriter stringWithObject:actionLinks];
	NSDictionary* attachment = [NSDictionary dictionaryWithObjectsAndKeys:
								[NSString stringWithFormat:@"%@ Loves %@ at The Carlton",[[[User sharedUser] fbUser] valueForKey:@"first_name"], self.navigationItem.title], @"name",
								@"", @"caption",
								itemDesc, @"description",
								@"http://www.facebook.com/pages/The-Carlton/150052555010209", @"href", nil];
	NSString *attachmentStr = [jsonWriter stringWithObject:attachment];
	NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
								   @"Share on Facebook",  @"user_message_prompt",
								   actionLinksStr, @"action_links",
								   attachmentStr, @"attachment",
								   nil];
	
	
	[[appDelegate facebook] dialog:@"stream.publish"
						 andParams:params
					   andDelegate:self];
}


- (void)dealloc {
	[itemDesc release];
	[itemPic release];
	[itemDescText release];
	[itemPicView release];
    [super dealloc];
}


@end
