//
//  ShitsMeListViewController.h
//  TheCarlton
//
//  Created by Zuhair Naqvi on 28/12/10.
//  Copyright 2010 Fitzroy. All rights reserved.
//

#import "RemoteDictionary.h"

@interface ShitsMeListViewController : UITableViewController {
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
