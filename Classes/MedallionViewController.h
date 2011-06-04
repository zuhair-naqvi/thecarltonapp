//
//  MedallionViewController.h
//  TheCarlton
//
//  Created by James on 11/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MedallionViewController : UIViewController {
	IBOutlet UILabel *memberId;
	IBOutlet UILabel *memberLevel;
	IBOutlet UILabel *deviceId;
	IBOutlet UIImage *medallionImage;
}

@property (nonatomic, retain) IBOutlet UILabel *memberId;
@property (nonatomic, retain) IBOutlet UILabel *memberLevel;
@property (nonatomic, retain) IBOutlet UILabel *deviceId;
@property (nonatomic, retain) IBOutlet UIImage *medallionImage;

@end
