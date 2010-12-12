//
//  MenuRootViewController.h
//  TheCarltonApp
//
//  Created by Zuhair Naqvi on 4/12/10.
//  Copyright 2010 Fitzroy. All rights reserved.
//

#import "RemoteDictionary.h"

@interface MenuRootViewController : UITableViewController {
	NSArray *tableDataSource;
	NSString *CurrentTitle;
	NSInteger CurrentLevel;
	NSMutableData *responseData;
}

@property (nonatomic, retain) NSArray *tableDataSource;
@property (nonatomic, retain) NSString *CurrentTitle;
@property (nonatomic, readwrite) NSInteger CurrentLevel;
@property (nonatomic, retain) NSMutableData *responseData;

- (void) initMenu;
- (void) remoteDictionaryDidLoad:(NSDictionary*)dict;

@end
