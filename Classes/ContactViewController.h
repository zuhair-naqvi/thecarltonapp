//
//  ContactViewController.h
//  TheCarltonApp
//
//  Created by Zuhair on 6/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Three20/Three20.h"
#import "ContactTableController.h"

@interface ContactViewController : UIViewController {
	UIBarButtonItem *homeButton;
	ContactTableController *contactTableController;
	IBOutlet UITableView *contactMainTable;
}

@property (nonatomic, retain) UIBarButtonItem *homeButton;
@property (nonatomic, retain) ContactTableController *contactTableController;
@property (nonatomic, retain) UITableView *contactMainTable;

- (void) goHome;

@end
