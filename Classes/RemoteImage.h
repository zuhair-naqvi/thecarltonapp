//
//  RemoteImage.h
//  TheCarlton
//
//  Created by Zuhair Naqvi on 12/12/10.
//  Copyright 2010 Fitzroy. All rights reserved.
//

#import "Three20/Three20.h"

@protocol RemoteImageDelegate <NSObject>
@optional
- (void) remoteImageDidLoad:(UIImage*)image;
- (void) remoteImageDidNotLoad:(NSError*)error;
@end


@interface RemoteImage : NSObject <TTURLRequestDelegate> {
	id <RemoteImageDelegate> delegate;
}

- (id) delegate;
- (void) setDelegate:(id)newDelegate;
- (void) imageFromServer:(NSString*)URL;
- (void) notifySuccess:(UIImage*)img;
- (void) notifyFailure:(NSError*)error;

@end
