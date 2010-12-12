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
}

@property (nonatomic, retain) IBOutlet UITextView *description;
@property (nonatomic, retain) IBOutlet UIImageView *promoImage;
@property (nonatomic, retain) NSString *imageUrl;

- (void) remoteDictionaryDidLoad:(NSDictionary*)dict;
- (void) remoteImageDidLoad:(UIImage*)image;

@end
