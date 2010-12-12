//
//  SyncViewController.h
//  TheCarlton
//
//  Created by Zuhair Naqvi on 12/12/10.
//  Copyright 2010 Fitzroy. All rights reserved.
//

#import "RemoteDictionary.h"
#import "RemoteImage.h"

@interface SyncViewController : UIViewController {
	IBOutlet UILabel *syncStatus;
	IBOutlet UIActivityIndicatorView *spinner;
	RemoteDictionary *rdict;
	RemoteImage *rimg;
}

@property (nonatomic, retain) IBOutlet UILabel *syncStatus;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *spinner;
@property (nonatomic, retain) RemoteDictionary *rdict;
@property (nonatomic, retain) RemoteImage *rimg;

- (IBAction) sync:(id)sender;
- (void) syncMenu;
- (void) syncBox;

@end
