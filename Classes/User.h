//
//  User.h
//  TheCarlton
//
//  Created by Zuhair Naqvi on 26/12/10.
//  Copyright 2010 Fitzroy. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface User : NSObject {
	NSInteger *userId;
	NSString *userName;
	NSString *email;
	NSString *status;
	NSString *level;
	NSInteger *boxOpen;
	NSObject *fbUser;
}

@property (assign, nonatomic) NSInteger *userId;
@property (nonatomic, retain) NSObject *fbUser;
@property (nonatomic, retain) NSString *level;
@property (nonatomic, retain) NSString *userName;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *status;
@property (nonatomic, assign) NSInteger *boxOpen;

//- (void) initWithUserId:(NSInteger*)uid;

+ (id) sharedUser;

- (void) loginWithUserId:(NSInteger*)uid;

@end
