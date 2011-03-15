//
//  BookingsViewController.h
//  TheCarlton
//
//  Created by James on 13/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BookingsViewController : UIViewController {
	UITextField *numGuests;
	UIDatePicker *bookingTime;
//	UIButton *bangButton;
}

@property (nonatomic, retain) IBOutlet UITextField *numGuests;
@property (nonatomic, retain) IBOutlet UIDatePicker *bookingTime;

- (IBAction) goBang:(id)sender;

@end
