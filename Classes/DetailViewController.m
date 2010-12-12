//
//  DetailViewController.m
//  DrillDownApp
//
//  Created by iPhone SDK Articles on 3/8/09.
//  Copyright www.iPhoneSDKArticles.com 2009. 
//

#import "DetailViewController.h"

@implementation DetailViewController

@synthesize itemDesc, itemPic, itemDescText, itemPicView, spinner;

- (void)viewDidLoad {
    [super viewDidLoad];
	
	itemDescText.text = itemDesc;
	itemDescText.backgroundColor = [UIColor clearColor];

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
	[itemDesc release];
	[itemPic release];
	[itemDescText release];
	[itemPicView release];
    [super dealloc];
}


@end
