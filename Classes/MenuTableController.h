//
//  MenuTableController.h
//  TheCarltonApp
//
//  Created by Zuhair on 6/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Three20/Three20.h"
#import "WineViewController.h"


@interface MenuTableController : UITableViewController {
	NSMutableArray *mainMenu;
}

@property (nonatomic, retain) NSMutableArray *mainMenu;

@end
