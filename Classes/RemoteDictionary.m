//
//  RemoteDictionary.m
//  TheCarlton
//
//  Created by Zuhair Naqvi on 12/12/10.
//  Copyright 2010 Fitzroy. All rights reserved.
//

#import "RemoteDictionary.h"

@implementation RemoteDictionary

- (id) delegate {
    return delegate;
}

- (void)setDelegate:(id)newDelegate {
    delegate = newDelegate;
}

- (void) notifySuccess:(NSDictionary*)dictionary {
    if ((delegate != nil) &&  [delegate respondsToSelector:@selector(remoteDictionaryDidLoad:)] ) {		
		[delegate remoteDictionaryDidLoad:dictionary];
    }
}

- (void) notifyFailure:(NSError*)error {
    if ((delegate != nil) &&  [delegate respondsToSelector:@selector(remoteDictionaryDidNotLoad:)] ) {		
		[delegate remoteDictionaryDidNotLoad:error];
    }
}


- (void) dictionaryFromServer:(NSString*)route{
	
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	NSString *dictionaryUrl = [NSString stringWithFormat:@"http://%@/%@", [prefs stringForKey:@"server"], route];
	
	TTURLRequest* request = [TTURLRequest requestWithURL: dictionaryUrl
												delegate: self];
	
	// TTURLImageResponse is just one of a set of response types you can use.
	// Also available are TTURLDataResponse and TTURLXMLResponse.
	request.response = [[[TTURLDataResponse alloc] init] autorelease];
	
	[request send];
}


#pragma mark -
#pragma mark TTURLRequestDelegate


- (void)requestDidStartLoad:(TTURLRequest*)request {
	
}

- (void)requestDidFinishLoad:(TTURLRequest*)request {
	TTURLDataResponse* plistResponse = (TTURLDataResponse*)request.response;
	NSString *listFile = [[NSString alloc] initWithData:plistResponse.data encoding:NSASCIIStringEncoding];
	NSDictionary *remoteDict = [[NSDictionary alloc] initWithDictionary:[listFile propertyList]];
	[self notifySuccess:remoteDict];
}


- (void)request:(TTURLRequest*)request didFailLoadWithError:(NSError*)error {
	[self notifyFailure:error];
}

- (void) dealloc
{
	[super dealloc];
}

@end
