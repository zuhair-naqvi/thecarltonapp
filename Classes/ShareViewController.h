//
//  ShareViewController.h
//  TheCarlton
//
//  Created by James on 19/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ShareViewController : UIViewController {
	UITextView *shareText;
}

@property (nonatomic, retain) IBOutlet UITextView *shareText;

@end
