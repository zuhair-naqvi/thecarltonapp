#import "GalleryViewController.h"
#import "MockPhotoSource.h"
#import "PhotosViewController.h"
#import "Overlay.h"

//transform values for full screen support
#define CAMERA_TRANSFORM_X 1
#define CAMERA_TRANSFORM_Y 1.12412

//iphone screen dimensions
#define SCREEN_WIDTH  320
#define SCREEN_HEIGTH 480

@implementation GalleryViewController

@synthesize photosList;

- (void) updateTableLayout {	
	self.tableView.contentInset = UIEdgeInsetsMake(5, 0, 0, 0);
	self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(TTBarsHeight(), 0, 0, 0);
}

- (void)viewDidLoad {
	self.tableView.backgroundColor = [UIColor clearColor];
	self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed: @"bg.jpg"]]; 
	self.navigationBarStyle = UIBarStyleBlackTranslucent;
	self.navigationBarTintColor = [UIColor colorWithRed:0.400 green:0.568 blue:0.025 alpha:7.5];

	[self.navigationItem setRightBarButtonItem:[[[UIBarButtonItem alloc]
												 initWithBarButtonSystemItem:UIBarButtonSystemItemCamera
												 target:self action:@selector(goCamera)] autorelease] animated:YES];
	
	photosList = [[NSMutableArray alloc] init];
	[self populatePhotosList];
	self.photoSource = [[MockPhotoSource alloc]
						initWithType:MockPhotoSourceNormal
						//initWithType:MockPhotoSourceDelayed
						// initWithType:MockPhotoSourceLoadError
						// initWithType:MockPhotoSourceDelayed|MockPhotoSourceLoadError
						title:@"Photos"
						photos:photosList
						photos2:nil
						];
	[self.photoSource autorelease];
	[self goCamera];
}

- (void) populatePhotosList
{
	[photosList addObject:[[[MockPhoto alloc]
							initWithURL:@"http://farm4.static.flickr.com/3246/2957580101_33c799fc09_o.jpg"
							smallURL:@"http://farm4.static.flickr.com/3246/2957580101_d63ef56b15_t.jpg"
							size:CGSizeMake(960, 1280)] autorelease]];
	
	[photosList addObject:[[[MockPhoto alloc]
							initWithURL:@"http://farm4.static.flickr.com/3246/2957580101_33c799fc09_o.jpg"
							smallURL:@"http://farm4.static.flickr.com/3246/2957580101_d63ef56b15_t.jpg"
							size:CGSizeMake(960, 1280)] autorelease]];
	
}

- (void) goCamera
{
	//create an overlay view instance
	Overlay *overlay = [[[Overlay alloc]
							initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGTH)] autorelease];
	
	PhotosViewController *photosViewController = [[[PhotosViewController alloc] init] autorelease];
	//photosViewController.delegate = self;
	photosViewController.sourceType = UIImagePickerControllerSourceTypeCamera;
	photosViewController.cameraOverlayView = overlay;
	[self presentModalViewController:photosViewController animated:YES];
}

- (void)dealloc {
	[photosList release];
    [super dealloc];
}


@end
