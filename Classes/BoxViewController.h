//
//  BoxViewController.h
//  TheCarltonApp
//
//  Created by Zuhair Naqvi on 5/12/10.
//  Copyright 2010 Fitzroy. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BoxViewController : UIViewController {
	IBOutlet UITextView *description;
	NSTimer *timer;
}

@property (nonatomic, retain) IBOutlet UITextView *description;
@property (nonatomic, retain) NSTimer *timer;

@end
