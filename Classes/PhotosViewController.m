    //
//  PhotosViewController.m
//  TheCarltonApp
//
//  Created by Zuhair on 7/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PhotosViewController.h"


@implementation PhotosViewController


- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	// Access the uncropped image from info dictionary
	UIImage *image = [[info objectForKey:@"UIImagePickerControllerOriginalImage"] autorelease];
	
	// Save image
	UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
	
	[picker release];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
	UIAlertView *alert;
	
	// Unable to save the image  
	if (error)
	{
		alert = [[UIAlertView alloc] initWithTitle:@"Error" 
										   message:@"Unable to save image to Photo Album." 
										  delegate:self cancelButtonTitle:@"Ok" 
								 otherButtonTitles:nil];
	}
	else 
	{
		alert = [[UIAlertView alloc] initWithTitle:@"Success" 
										   message:@"Image saved to Photo Album." 
										  delegate:self cancelButtonTitle:@"Ok" 
								 otherButtonTitles:nil];
	}
	[alert show];
	[alert release];
}


// as a delegate we are told to finished with the camera
- (void)didFinishWithCamera
{
    [self dismissModalViewControllerAnimated:YES];
}
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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
    [super dealloc];
}


@end
