//
//  GalleryViewController.h
//  TheCarltonApp
//
//  Created by Zuhair on 7/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Three20/Three20.h"
#import "FBConnect.h"

@interface GalleryViewController : TTThumbsViewController <UIImagePickerControllerDelegate, FBRequestDelegate, FBSessionDelegate, FBDialogDelegate> {
	NSMutableArray *photosList;
}

@property (nonatomic, retain) NSMutableArray *photosList;

- (void) goCamera;
- (void) populatePhotosList;

@end
