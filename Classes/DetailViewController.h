//
//  DetailViewController.h
//  TheCarltonApp
//
//  Created by Zuhair Naqvi on 4/12/10.
//  Copyright 2010 Fitzroy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController {
	NSString *itemDesc;
	NSString *itemPic;
	NSString *imageUrlPrefix;
	IBOutlet UIImageView *itemPicView;
	IBOutlet UITextView *itemDescText;
}

@property (nonatomic, retain) NSString *itemDesc;
@property (nonatomic, retain) NSString *itemPic;
@property (nonatomic, retain) NSString *imageUrlPrefix;
@property (nonatomic, retain) IBOutlet UIImageView *itemPicView;
@property (nonatomic, retain) IBOutlet UITextView *itemDescText;

@end
