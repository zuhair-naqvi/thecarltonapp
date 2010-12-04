//
//  ContactTableController.h
//  TheCarltonApp
//
//  Created by Zuhair Naqvi on 27/11/10.
//  Copyright 2010 Fitzroy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Three20/Three20.h"
#import "LocateViewController.h"

@interface ContactTableController : UITableViewController {
	NSMutableArray *contactMenu;
}

@property (nonatomic, retain) NSMutableArray *contactMenu;

@end
