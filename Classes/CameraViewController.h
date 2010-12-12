//
//  CameraViewController.h
//  TheCarlton
//
//  Created by Zuhair Naqvi on 12/12/10.
//  Copyright 2010 Fitzroy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioServices.h>

#import "OverlayViewController.h"

@interface CameraViewController : UIViewController <UIImagePickerControllerDelegate,
OverlayViewControllerDelegate>
{
    UIImageView *imageView;
    
    OverlayViewController *overlayViewController; // the camera custom overlay view
	
    NSMutableArray *capturedImages; // the list of images captures from the camera (either 1 or multiple)
}

@property (nonatomic, retain) IBOutlet UIImageView *imageView;

@property (nonatomic, retain) OverlayViewController *overlayViewController;

@property (nonatomic, retain) NSMutableArray *capturedImages;

// toolbar buttons
- (IBAction)photoLibraryAction:(id)sender;
- (IBAction)cameraAction:(id)sender;

@end
