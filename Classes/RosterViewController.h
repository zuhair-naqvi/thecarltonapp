//
//  RosterViewController.h
//  TheCarlton
//
//  Created by Zuhair Naqvi on 28/12/10.
//  Copyright 2010 Fitzroy. All rights reserved.
//

#import "RemoteDictionary.h"


@interface RosterViewController : UIViewController {
	IBOutlet UILabel *monday;
	IBOutlet UILabel *tuesday;
	IBOutlet UILabel *wednesday;
	IBOutlet UILabel *thursday;
	IBOutlet UILabel *friday;
	IBOutlet UILabel *saturday;
	IBOutlet UILabel *sunday;
}

@property (nonatomic, retain) UILabel *monday;
@property (nonatomic, retain) UILabel *tuesday;
@property (nonatomic, retain) UILabel *wednesday;
@property (nonatomic, retain) UILabel *thursday;
@property (nonatomic, retain) UILabel *friday;
@property (nonatomic, retain) UILabel *saturday;
@property (nonatomic, retain) UILabel *sunday;

@end
