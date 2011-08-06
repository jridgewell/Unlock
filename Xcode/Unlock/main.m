//
//  main.m
//  Unlock
//
//  Created by Justin Ridgewell on 8/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Keychain.h"
#import "Diskutil.h"

int main (int argc, const char * argv[])
{
	
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	
	// insert code here...
	Keychain* keychain = [[Keychain alloc] init];
	NSMutableArray* volumesAndPasswords = [keychain volumesAndPasswordsWithService:@"name.ridgewell.unlock"];
	[keychain release];
	
	for (NSMutableArray* volumeAndPassword in volumesAndPasswords) {
		NSString* uuid = [volumeAndPassword objectAtIndex:0];
		NSString* passphrase = [volumeAndPassword objectAtIndex:1];
		[Diskutil unlockVolume: uuid WithPassphrase: passphrase];
		[volumeAndPassword release];
	}
	
	[volumesAndPasswords release];
	
	[pool drain];
    return 0;
}