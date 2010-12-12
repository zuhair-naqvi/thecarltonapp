//
//  RemoteImage.m
//  TheCarlton
//
//  Created by Zuhair Naqvi on 12/12/10.
//  Copyright 2010 Fitzroy. All rights reserved.
//

#import "RemoteImage.h"

@implementation RemoteImage


- (id) delegate {
    return delegate;
}

- (void)setDelegate:(id)newDelegate {
    delegate = newDelegate;
}

- (void) notifySuccess:(UIImage*)img {
    if ((delegate != nil) &&  [delegate respondsToSelector:@selector(remoteImageDidLoad:)] ) {		
		[delegate remoteImageDidLoad:img];
    }
}

- (void) notifyFailure:(NSError*)error {
    if ((delegate != nil) &&  [delegate respondsToSelector:@selector(remoteImageDidNotLoad:)] ) {
		
		[delegate remoteImageDidNotLoad:error];
    }
}


- (void) imageFromServer:(NSString*)route{
	
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	NSString *imageUrl = [NSString stringWithFormat:@"http://%@/%@", [prefs stringForKey:@"server"], route];
	TTURLRequest* request = [TTURLRequest requestWithURL: imageUrl
												delegate: self];
	
	// TTURLImageResponse is just one of a set of response types you can use.
	// Also available are TTURLDataResponse and TTURLXMLResponse.
	request.response = [[[TTURLImageResponse alloc] init] autorelease];
	
	[request send];		
}


#pragma mark -
#pragma mark TTURLRequestDelegate


- (void)requestDidStartLoad:(TTURLRequest*)request {
	
}

- (void)requestDidFinishLoad:(TTURLRequest*)request {
	TTURLImageResponse* imageResponse = (TTURLImageResponse*)request.response;
	
	[self notifySuccess:imageResponse.image];
}


- (void)request:(TTURLRequest*)request didFailLoadWithError:(NSError*)error {
	[self notifyFailure:error];
}

- (void) dealloc
{
	[super dealloc];
}


@end
