//
//  User.m
//  TheCarlton
//
//  Created by Zuhair Naqvi on 26/12/10.
//  Copyright 2010 Fitzroy. All rights reserved.
//

#import "User.h"
#import "RemoteDictionary.h"

static User *sharedUser = nil;

@implementation User

@synthesize userId, level, userName, email, status, fbUser;

#pragma mark Singleton Methonds

+ (id) sharedUser {
	@synchronized(self){
		if (sharedUser == nil) {
			sharedUser = [[super allocWithZone:NULL] init];
		}
	}
	return sharedUser;
}

+ (id) allocWithZone:(NSZone *)zone {
	return [[self sharedUser] retain];
}

- (id) copyWithZone:(NSZone *)zone {
	return self;
}

- (id) retain {
	return self;
}

- (void) release {
}

- (id) init {
	if (self = [super init]) {
		status = [[NSString alloc] initWithString:@"Not Logged In"];
	}
	return self;
}

- (void) loginWithUserId:(NSInteger*)uid {
	RemoteDictionary *userInfo = [[RemoteDictionary alloc] init];
	[userInfo setDelegate:self];	
	[userInfo dictionaryFromServer:[NSString stringWithFormat:@"members/plist/id/%d",uid]];
}

- (void) remoteDictionaryDidLoad:(NSDictionary*)dict
{
	//[self setName:[dict valueForKey:@""]]
	NSLog(@"raw %@", dict);
	
	if ([[dict valueForKey:@"exists"] isEqualToString:@"true"]) {
		[self setLevel:[dict valueForKey:@"level"]];
		[self setStatus:@"active"];
		[self setUserName:[dict valueForKey:@"name"]];
		[self setEmail:[dict valueForKey:@"email"]];
	}
	
}

- (void) dealloc {
	[userName release];
	[email release];
	[level release];
	[status release];
	[fbUser release];
	[super dealloc];
}


@end
