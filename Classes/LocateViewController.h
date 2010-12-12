//
//  LocateViewController.h
//  TheCarltonApp
//
//  Created by Zuhair Naqvi on 27/11/10.
//  Copyright 2010 Fitzroy. All rights reserved.
//

#import "Three20/Three20.h"

@interface LocateViewController : UIViewController {
	UIBarButtonItem *homeButton;	
}

@property (nonatomic, retain) UIBarButtonItem *homeButton;

- (void) goHome;
- (IBAction) goMaps:(id)sender;

@end
