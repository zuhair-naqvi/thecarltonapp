//
//  ShitsMeListShitsMeListDetailViewController.h
//  TheCarlton
//
//  Created by Zuhair Naqvi on 28/12/10.
//  Copyright 2010 Fitzroy. All rights reserved.
//

#import "RemoteImage.h"

@interface ShitsMeListDetailViewController : UIViewController {
	NSString *itemDesc;
	IBOutlet UITextView *itemDescText;	
}

@property (nonatomic, retain) NSString *itemDesc;
@property (nonatomic, retain) IBOutlet UITextView *itemDescText;

@end
