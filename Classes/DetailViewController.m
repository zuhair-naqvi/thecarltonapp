//
//  DetailViewController.m
//  DrillDownApp
//
//  Created by iPhone SDK Articles on 3/8/09.
//  Copyright www.iPhoneSDKArticles.com 2009. 
//

#import "DetailViewController.h"


@implementation DetailViewController

@synthesize itemDesc, itemPic, itemDescText, itemPicView, imageUrlPrefix;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	//self.navigationItem.title = @"Detail View";
	itemDescText.text = itemDesc;
	itemDescText.backgroundColor = [UIColor clearColor];
	
	imageUrlPrefix = @"http://ec2-184-72-186-159.compute-1.amazonaws.com/uploads/images/menu";
	
	NSString *myImageString = [NSString stringWithFormat:@"%@/%@",imageUrlPrefix,itemPic];
	NSURL * imageUrl = [[NSURL alloc] initWithString:myImageString];
	NSURLRequest *myRequest = [ [NSURLRequest alloc] initWithURL: imageUrl ];
	NSData *returnData = [ NSURLConnection sendSynchronousRequest:myRequest returningResponse: nil error: nil ];
	UIImage *myImage  = [[UIImage alloc] initWithData:returnData];	
	itemPicView.image = myImage;
	NSLog(@"%@", myImageString);
//							   [myImageString release];
//							   [imageUrl release];
//							   [myRequest release];
//							   [returnData release];
//							   [myImage release];
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
	[imageUrlPrefix release];
    [super dealloc];
}


@end
