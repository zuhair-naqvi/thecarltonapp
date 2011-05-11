//
//  LauncherViewController.m
//  TheCarltonApp
//
//  Created by User on 2/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

//transform values for full screen support
#define CAMERA_TRANSFORM_X 1
#define CAMERA_TRANSFORM_Y 1.12412

//iphone screen dimensions
#define SCREEN_WIDTH  320
#define SCREEN_HEIGTH 480

#import "LauncherViewController.h"
#import "User.h"
#import "TheCarltonAppDelegate.h"
#import "MockPhotoSource.h"
#import "PhotosViewController.h"
#import "Overlay.h"

@implementation LauncherViewController


@synthesize logoView, facebook;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		self.title = @"Loading...";
		//NSLog(@"Fb id: %d", [[User sharedUser] fbUid]);
			
		[[NSNotificationCenter defaultCenter]
		addObserver:self
		selector:@selector(fbConnected:)
		name:@"fbConnectEvent"
		object:nil];
		self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed: @"bg.jpg"]]; 
	}
	return self;
}

- (void) fbConnected:(id) sender {
	NSLog(@"FbDidLogin");	
	TheCarltonAppDelegate *appDelegate = (TheCarltonAppDelegate *)[[UIApplication sharedApplication] delegate];
	[[appDelegate facebook] requestWithGraphPath:@"me" andDelegate:self];
}

- (void)request:(FBRequest *)request didLoad:(id)result
{
	NSLog(@"My result: %@", result);
	if ([result valueForKey:@"first_name"] != nil) {
		[[User sharedUser] setFbUser:result];
		self.title = [NSString stringWithFormat:@"Hi %@", [result valueForKey:@"first_name"]];
	}
	else if([result valueForKey:@"src"] != nil) {
		UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Photo uploaded Facebook" message:@"The photo you just shot has been uploaded to your Facebook Album" delegate:self cancelButtonTitle:@"Done" otherButtonTitles:nil] autorelease];
		[alert show];
	}
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
	if (buttonIndex == 1) {
		[self fbConnected:self];
	}
}


- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
	//[self.label setText:[error localizedDescription]];
	UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Can't connect to Facebook" message:@"This could be temporary issue with your network or Facebook's servers." delegate:self cancelButtonTitle:@"Continue Without" otherButtonTitles:nil] autorelease];
    [alert addButtonWithTitle:@"Try Again"];
    [alert show];
	NSLog(@"FBRequest Error %@", [error localizedDescription]);
};

- (void) goCamera
{
	//create an overlay view instance
	Overlay *overlay = [[[Overlay alloc]
						 initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGTH)] autorelease];
	
	PhotosViewController *photosViewController = [[[PhotosViewController alloc] init] autorelease];
	//photosViewController.delegate = self;
	photosViewController.sourceType = UIImagePickerControllerSourceTypeCamera;
	photosViewController.cameraOverlayView = overlay;
	photosViewController.delegate = self;
	[self presentModalViewController:photosViewController animated:YES];
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	// Access the uncropped image from info dictionary
	UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
	
	// Save image
	//UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
	
	[self uploadPhoto:[self correctImageOrientation:image]];
	
	[picker dismissModalViewControllerAnimated:YES];
	
	//[picker release];
}

- (UIImage*) correctImageOrientation:(UIImage*)image1
{
    int kMaxResolution = 640;
	
	UIImage *logo = [UIImage imageNamed:@"logogreen_vertical.png"];
	
	CGImageRef imgRef = image1.CGImage;
	CGImageRef logoRef = logo.CGImage;
	CGFloat width = CGImageGetWidth(imgRef);
	CGFloat height = CGImageGetHeight(imgRef);
	
	CGAffineTransform transform = CGAffineTransformIdentity;
	CGRect bounds = CGRectMake(0, 0, width, height);
	if (width > kMaxResolution || height > kMaxResolution) {
		CGFloat ratio = width/height;
		if (ratio > 1) {
			bounds.size.width = kMaxResolution;
			bounds.size.height = bounds.size.width / ratio;
		}
		else {
			bounds.size.height = kMaxResolution;
			bounds.size.width = bounds.size.height * ratio;
		}
	}
	
	CGFloat scaleRatio = bounds.size.width / width;
	CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
	CGFloat boundHeight;
	UIImageOrientation orient = image1.imageOrientation;
	switch(orient) {
			
		case UIImageOrientationUp: //EXIF = 1
			NSLog(@"1");
			transform = CGAffineTransformIdentity;
			break;
			
		case UIImageOrientationUpMirrored: //EXIF = 2
			NSLog(@"2");
			transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
			transform = CGAffineTransformScale(transform, -1.0, 1.0);
			break;
			
		case UIImageOrientationDown: //EXIF = 3
			NSLog(@"3");
			transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
			transform = CGAffineTransformRotate(transform, M_PI);
			break;
			
		case UIImageOrientationDownMirrored: //EXIF = 4
			NSLog(@"4");
			transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
			transform = CGAffineTransformScale(transform, 1.0, -1.0);
			break;
			
		case UIImageOrientationLeftMirrored: //EXIF = 5
			NSLog(@"5");
			boundHeight = bounds.size.height;
			bounds.size.height = bounds.size.width;
			bounds.size.width = boundHeight;
			transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
			transform = CGAffineTransformScale(transform, -1.0, 1.0);
			transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
			break;
			
		case UIImageOrientationLeft: //EXIF = 6
			NSLog(@"6");
			boundHeight = bounds.size.height;
			bounds.size.height = bounds.size.width;
			bounds.size.width = boundHeight;
			transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
			transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
			break;
			
		case UIImageOrientationRightMirrored: //EXIF = 7
			NSLog(@"7");
			boundHeight = bounds.size.height;
			bounds.size.height = bounds.size.width;
			bounds.size.width = boundHeight;
			transform = CGAffineTransformMakeScale(-1.0, 1.0);
			transform = CGAffineTransformRotate(transform, M_PI / 2.0);
			break;
			
		case UIImageOrientationRight: //EXIF = 8
			NSLog(@"8");
			boundHeight = bounds.size.height;
			bounds.size.height = bounds.size.width;
			bounds.size.width = boundHeight;
			transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
			transform = CGAffineTransformRotate(transform, M_PI / 2.0);
			break;
			
		default:
			[NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
			
	}
	
	UIGraphicsBeginImageContext(bounds.size);
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
		CGContextScaleCTM(context, -scaleRatio, scaleRatio);
		CGContextTranslateCTM(context, -height, 0);
	}
	else {
		CGContextScaleCTM(context, scaleRatio, -scaleRatio);
		CGContextTranslateCTM(context, 0, -height);
	}
	
	CGContextConcatCTM(context, transform);
	
	CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
	CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeNormal);
	CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(2050, 580, 396, 822), logoRef);
	
	UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return imageCopy;
	
}

- (UIImage*) rotateImage:(CGImageRef*) imgRef
{
	CGSize size = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
	UIGraphicsBeginImageContext(size);
	CGContextRotateCTM(UIGraphicsGetCurrentContext(), 1.57079633);
	CGContextDrawImage(UIGraphicsGetCurrentContext(),
					   CGRectMake(0,0,size.width, size.height),
					   imgRef);
	
	UIImage *copy = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return copy;
}

- (void) uploadPhoto:(UIImage*) image{
	NSLog(@"Hello from upload");
	TheCarltonAppDelegate *appDelegate = (TheCarltonAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
								   image, @"picture",
								   nil];
	[[appDelegate facebook] requestWithMethodName:@"photos.upload"
										andParams:params
									andHttpMethod:@"POST"
									  andDelegate:self];
}

- (void)loadView {
	[super loadView];
	self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed: @"bg.jpg"]]; 
	self.navigationBarStyle = UIBarStyleBlackTranslucent;
	self.navigationBarTintColor = [UIColor colorWithRed:0.400 green:0.568 blue:0.025 alpha:7.5]; 
	
	logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.png"]];
	[logoView setCenter:CGPointMake((TTScreenBounds().size.width/2),40.0)];
	
	CGRect launcherRect = CGRectMake(0, 65, TTScreenBounds().size.width, (TTScreenBounds().size.height - 140));
	
	_launcherView = [[TTLauncherView alloc] initWithFrame:launcherRect];		
	_launcherView.delegate = self;
	_launcherView.columnCount = 3;
	_launcherView.pages = [NSArray arrayWithObjects:
						   [NSArray arrayWithObjects:
							[[[TTLauncherItem alloc] initWithTitle:@"Contact"
															 image:@"bundle://contact.png"
															   URL:@"tt://contact/" canDelete:NO] autorelease],
							[[[TTLauncherItem alloc] initWithTitle:@"Bookings"
															 image:@"bundle://bookings.png"
															   URL:@"tt://bookings/" canDelete:NO] autorelease],
							[[[TTLauncherItem alloc] initWithTitle:@"Food & Drinks"
															 image:@"bundle://menu.png"
															   URL:@"tt://menu/" canDelete:NO] autorelease],
							[[[TTLauncherItem alloc] initWithTitle:@"The Box"
															 image:@"bundle://free.png"
															   URL:@"tt://box/" canDelete:NO] autorelease],
							[[[TTLauncherItem alloc] initWithTitle:@"News"
															 image:@"bundle://news.png"
															   URL:@"tt://news/" canDelete:NO] autorelease],
							[[[TTLauncherItem alloc] initWithTitle:@"Photos"
															 image:@"bundle://cameraimg.png"
															   URL:@"tt://photos/" canDelete:NO] autorelease],	
							[[[TTLauncherItem alloc] initWithTitle:@"Check In"
															 image:@"bundle://checkin.png"
															   URL:nil canDelete:NO] autorelease],
							[[[TTLauncherItem alloc] initWithTitle:@"Share"
															 image:@"bundle://share.png"
															   URL:@"tt://share/" canDelete:NO] autorelease],
							[[[TTLauncherItem alloc] initWithTitle:@"Sync"
															 image:@"bundle://sync_01.png"
															   URL:@"tt://sync/" canDelete:NO] autorelease],								
							nil],
						   nil
						   ];
	[self.view addSubview:logoView];
	[self.view addSubview:_launcherView];
	[logoView retain];
	TTLauncherItem* box = [_launcherView itemWithURL:@"tt://box/"];
	box.badgeNumber = 1;
	
	TTLauncherItem* photos = [_launcherView itemWithURL:@"tt://photos/"];
	photos.badgeNumber = 5;	
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// TTLauncherViewDelegate

- (void)launcherView:(TTLauncherView*)launcher didSelectItem:(TTLauncherItem*)item {
	if ([item.title isEqualToString:@"Share"]) {
		TheCarltonAppDelegate *appDelegate = (TheCarltonAppDelegate *)[[UIApplication sharedApplication] delegate];
		
		SBJSON *jsonWriter = [[SBJSON new] autorelease];
		
		NSDictionary* actionLinks = [NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:
															   @"Always Running",@"text",@"http://itsti.me/",@"href", nil], nil];
		
		NSString *actionLinksStr = [jsonWriter stringWithObject:actionLinks];
		NSDictionary* attachment = [NSDictionary dictionaryWithObjectsAndKeys:
									@"a long run", @"name",
									@"The Facebook Running app", @"caption",
									@"it is fun", @"description",
									@"http://itsti.me/", @"href", nil];
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
	else if([item.title isEqualToString:@"Photos"])
	{
		[self goCamera];
	}
	else {
		[[TTNavigator navigator] openURLAction:[[TTURLAction actionWithURLPath:item.URL] applyAnimated:YES]];
	}    
}

- (void)launcherViewDidBeginEditing:(TTLauncherView*)launcher {
	[self.navigationItem setRightBarButtonItem:[[[UIBarButtonItem alloc]
												 initWithBarButtonSystemItem:UIBarButtonSystemItemDone
												 target:_launcherView action:@selector(endEditing)] autorelease] animated:YES];
}

- (void)launcherViewDidEndEditing:(TTLauncherView*)launcher {
	[self.navigationItem setRightBarButtonItem:nil animated:YES];
}


- (void)dealloc {
	[logoView release];
	[super dealloc];
}


@end
