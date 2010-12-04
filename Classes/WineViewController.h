//
//  WineViewController.h
//  TheCarltonApp
//
//  Created by Zuhair Naqvi on 28/11/10.
//  Copyright 2010 Fitzroy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WineTableController.h"
//#import "Three20/Three20.h"

@interface WineViewController : UIViewController {
	//UIBarButtonItem *contactButton;
	WineTableController *wineTableController;
	IBOutlet UITableView *wineMainTable;
}

//@property (nonatomic, retain) UIBarButtonItem *contactButton;
@property (nonatomic, retain) WineTableController *wineTableController;
@property (nonatomic, retain) UITableView *wineMainTable;

//- (void) goContact;

@end
