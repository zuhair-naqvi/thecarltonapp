//
//  RemoteDictionary.h
//  TheCarlton
//
//  Created by Zuhair Naqvi on 12/12/10.
//  Copyright 2010 Fitzroy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Three20/Three20.h"

@protocol RemoteDictionaryDelegate <NSObject>
@optional
- (void) remoteDictionaryDidLoad:(NSDictionary*)dictionary;
- (void) remoteDictionaryDidNotLoad:(NSError*)error;
@end


@interface RemoteDictionary : NSObject <TTURLRequestDelegate> {
	id <RemoteDictionaryDelegate> delegate;
}

- (id) delegate;
- (void) setDelegate:(id)newDelegate;
- (void) dictionaryFromServer:(NSString*)route;
- (void) notifySuccess:(NSDictionary*)dictionary;
- (void) notifyFailure:(NSError*)error;

@end
