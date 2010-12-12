//
//  DetailViewController.h
//  TheCarltonApp
//
//  Created by Zuhair Naqvi on 4/12/10.
//  Copyright 2010 Fitzroy. All rights reserved.
//

#import "RemoteImage.h"

@interface DetailViewController : UIViewController {
	NSString *itemDesc;
	NSString *itemPic;
	UIActivityIndicatorView *spinner;
	IBOutlet UIImageView *itemPicView;
	IBOutlet UITextView *itemDescText;	
}

@property (nonatomic, retain) NSString *itemDesc;
@property (nonatomic, retain) NSString *itemPic;
@property (nonatomic, retain) UIActivityIndicatorView *spinner;
@property (nonatomic, retain) IBOutlet UIImageView *itemPicView;
@property (nonatomic, retain) IBOutlet UITextView *itemDescText;

- (void) remoteImageDidLoad:(UIImage*)img;

@end
