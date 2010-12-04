//
//  MenuViewController.h
//  TheCarltonApp
//
//  Created by Zuhair on 6/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Three20/Three20.h"
#import "MenuTableController.h"

@interface MenuViewController : UIViewController {
	UIBarButtonItem *contactButton;
	MenuTableController *menuTableController;
	IBOutlet UITableView *menuMainTable;
}

@property (nonatomic, retain) UIBarButtonItem *contactButton;
@property (nonatomic, retain) MenuTableController *menuTableController;
@property (nonatomic, retain) UITableView *menuMainTable;

- (void) goContact;

@end
