//
//  BoxViewController.h
//  TheCarltonApp
//
//  Created by Zuhair Naqvi on 5/12/10.
//  Copyright 2010 Fitzroy. All rights reserved.
//

#import "Three20/Three20.h"


@interface BoxViewController : UIViewController <TTURLRequestDelegate> {
	IBOutlet UITextView *description;
	IBOutlet UIImageView *promoImage;
	NSString *imageUrl;
	IBOutlet UITextField *textField;
	UIAlertView *ticketalert;
}

@property (nonatomic, retain) IBOutlet UITextView *description;
@property (nonatomic, retain) IBOutlet UIImageView *promoImage;
@property (nonatomic, retain) IBOutlet UITextField *textField;
@property (nonatomic, retain) NSString *imageUrl;
@property (nonatomic, retain) UIAlertView *ticketalert;

- (void) remoteDictionaryDidLoad:(NSDictionary*)dict;
- (void) remoteImageDidLoad:(UIImage*)image;

@end
