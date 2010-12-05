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
	
	self.photoSource = [[MockPhotoSource alloc]
						initWithType:MockPhotoSourceNormal
						//initWithType:MockPhotoSourceDelayed
						// initWithType:MockPhotoSourceLoadError
						// initWithType:MockPhotoSourceDelayed|MockPhotoSourceLoadError
						title:@"Photos"
						photos:[[NSArray alloc] initWithObjects:
								[[[MockPhoto alloc]
								  initWithURL:@"http://farm4.static.flickr.com/3246/2957580101_33c799fc09_o.jpg"
								  smallURL:@"http://farm4.static.flickr.com/3246/2957580101_d63ef56b15_t.jpg"
								  size:CGSizeMake(960, 1280)] autorelease],
								[[[MockPhoto alloc]
								  initWithURL:@"http://farm4.static.flickr.com/3444/3223645618_13fe36887a_o.jpg"
								  smallURL:@"http://farm4.static.flickr.com/3444/3223645618_f5e2fa7fea_t.jpg"
								  size:CGSizeMake(320, 480)
								  caption:@"These are the wood tiles that we had installed after the accident."] autorelease],
								[[[MockPhoto alloc]
								  initWithURL:@"http://farm2.static.flickr.com/1124/3164979509_bcfdd72123.jpg?v=0"
								  smallURL:@"http://farm2.static.flickr.com/1124/3164979509_bcfdd72123_t.jpg"
								  size:CGSizeMake(320, 480)
								  caption:@"A hike."] autorelease],
								[[[MockPhoto alloc]
								  initWithURL:@"http://farm4.static.flickr.com/3106/3203111597_d849ef615b.jpg?v=0"
								  smallURL:@"http://farm4.static.flickr.com/3106/3203111597_d849ef615b_t.jpg"
								  size:CGSizeMake(320, 480)] autorelease],
								[[[MockPhoto alloc]
								  initWithURL:@"http://farm4.static.flickr.com/3099/3164979221_6c0e583f7d.jpg?v=0"
								  smallURL:@"http://farm4.static.flickr.com/3099/3164979221_6c0e583f7d_t.jpg"
								  size:CGSizeMake(320, 480)] autorelease],
								[[[MockPhoto alloc]
								  initWithURL:@"http://farm4.static.flickr.com/3081/3164978791_3c292029f2.jpg?v=0"
								  smallURL:@"http://farm4.static.flickr.com/3081/3164978791_3c292029f2_t.jpg"
								  size:CGSizeMake(320, 480)] autorelease],
								
								[[[MockPhoto alloc]
								  initWithURL:@"http://farm3.static.flickr.com/2358/2179913094_3a1591008e.jpg"
								  smallURL:@"http://farm3.static.flickr.com/2358/2179913094_3a1591008e_t.jpg"
								  size:CGSizeMake(383, 500)] autorelease],
								[[[MockPhoto alloc]
								  initWithURL:@"http://farm4.static.flickr.com/3162/2677417507_e5d0007e41.jpg"
								  smallURL:@"http://farm4.static.flickr.com/3162/2677417507_e5d0007e41_t.jpg"
								  size:CGSizeMake(391, 500)] autorelease],
								[[[MockPhoto alloc]
								  initWithURL:@"http://farm4.static.flickr.com/3334/3334095096_ffdce92fc4.jpg"
								  smallURL:@"http://farm4.static.flickr.com/3334/3334095096_ffdce92fc4_t.jpg"
								  size:CGSizeMake(407, 500)] autorelease],
								[[[MockPhoto alloc]
								  initWithURL:@"http://farm4.static.flickr.com/3118/3122869991_c15255d889.jpg"
								  smallURL:@"http://farm4.static.flickr.com/3118/3122869991_c15255d889_t.jpg"
								  size:CGSizeMake(500, 406)] autorelease],
								[[[MockPhoto alloc]
								  initWithURL:@"http://farm2.static.flickr.com/1004/3174172875_1e7a34ccb7.jpg"
								  smallURL:@"http://farm2.static.flickr.com/1004/3174172875_1e7a34ccb7_t.jpg"
								  size:CGSizeMake(500, 372)] autorelease],
								[[[MockPhoto alloc]
								  initWithURL:@"http://farm3.static.flickr.com/2300/2179038972_65f1e5f8c4.jpg"
								  smallURL:@"http://farm3.static.flickr.com/2300/2179038972_65f1e5f8c4_t.jpg"
								  size:CGSizeMake(391, 500)] autorelease],

								
								nil
								]
						
						//photos2:nil
						  photos2:[[NSArray alloc] initWithObjects:
						    [[[MockPhoto alloc]
						      initWithURL:@"http://farm4.static.flickr.com/3280/2949707060_e639b539c5_o.jpg"
						      smallURL:@"http://farm4.static.flickr.com/3280/2949707060_8139284ba5_t.jpg"
						      size:CGSizeMake(800, 533)] autorelease],
						    nil]
						];
	[self.photoSource autorelease];
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
    [super dealloc];
}


@end
