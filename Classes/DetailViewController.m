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

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	//self.navigationItem.title = @"Detail View";
	itemDescText.text = itemDesc;
	itemDescText.backgroundColor = [UIColor clearColor];

	spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	[spinner setCenter:CGPointMake(itemPicView.bounds.size.width/2, itemPicView.bounds.size.height/2)]; // I do this because I'm in landscape mode
	[itemPicView addSubview:spinner]; 
	[spinner startAnimating];
		
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	NSURL *picUrl = [NSURL URLWithString:[[NSString alloc] initWithFormat:@"http://%@/uploads/images/menu/%@", [prefs stringForKey:@"server"], itemPic]];
	NSURLRequest *request=[NSURLRequest requestWithURL:picUrl
										   cachePolicy:NSURLRequestUseProtocolCachePolicy
									   timeoutInterval:60];
	
	NSURLConnection *connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
//							   [myImageString release];
//							   [imageUrl release];
//							   [myRequest release];
//							   [returnData release];
//							   [myImage release];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [responseData appendData:data];	
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [responseData release];
    [connection release];
    //[textView setString:@"Unable to fetch data"];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection 
{
	[spinner stopAnimating];
	[spinner release];
	itemPicView.image = [UIImage imageWithData:responseData];
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
	[responseData release];
    [super dealloc];
}


@end
