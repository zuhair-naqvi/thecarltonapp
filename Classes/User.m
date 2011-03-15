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

@synthesize userId, level, userName, email, status;

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
	if ([dict valueForKey:@"exists"] == @"true") {
		self.status = @"active";
		self.level = [dict valueForKey:@"level"];
		self.userName = [dict valueForKey:@"name"];
		self.email = [dict valueForKey:@"email"];
	}
}

- (void) dealloc {
	[userName release];
	[email release];
	[level release];
	[status release];
	[super dealloc];
}


@end
