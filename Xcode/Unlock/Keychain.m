//
//  Keychain.m
//  Unlock
//
//  Created by Justin Ridgewell on 8/5/11.
//

#import "Keychain.h"
#import <Security/Security.h>

@interface Keychain (Private)
- (NSMutableDictionary*) queryOfAllItemsWithService: (NSString*) service;
- (NSMutableDictionary*) queryOfItemWithAccount: (NSString*) account WithService: (NSString*) service;
@end

@implementation Keychain

- (id) init {
	if (self = [super init]) {
	}

	return self;
}

- (void) dealloc {
	[super dealloc];
}

- (NSMutableArray*) volumesAndPasswordsWithService:(NSString*) service {
	NSMutableArray* volumesAndPasswords = [[NSMutableArray alloc] init];
	CFArrayRef results = nil;
	NSMutableDictionary* query = [self queryOfAllItemsWithService:service];
	OSStatus status = SecItemCopyMatching((CFDictionaryRef) query, (CFTypeRef*) &results);
	
	if (status == errSecSuccess) {
		CFIndex resultCount = CFArrayGetCount(results);
		
		for (CFIndex i = 0; i < resultCount; i++) {
			NSMutableArray* volumeAndPassword = [[NSMutableArray alloc] init];
			NSData* passwordData = nil;
			NSDictionary*  result = (NSDictionary*) CFArrayGetValueAtIndex(results, i);
			NSString* account = [result objectForKey:@"acct"];

			[query release];
			query = [self queryOfItemWithAccount:account WithService:service];
			SecItemCopyMatching((CFDictionaryRef) query, (CFTypeRef*) &passwordData);

			NSString* password = [[NSString alloc] initWithData:passwordData encoding:NSUTF8StringEncoding];

			[volumeAndPassword addObject:account];
			[volumeAndPassword addObject:password];
			[volumesAndPasswords addObject:volumeAndPassword];
		}
	} else {
		NSLog(@"Error: SecItemCopyMatching returned %d!", status);
	}

	[query release];
	if (results != nil) {
		CFRelease(results);
	}

	return volumesAndPasswords;
}

- (NSMutableDictionary*) queryOfAllItemsWithService: (NSString*) service {
	NSMutableDictionary* query = [[NSMutableDictionary alloc] init];
	[query setObject:(id) kSecClassGenericPassword forKey:(id) kSecClass];
	[query setObject:service forKey:(id) kSecAttrService];
	[query setObject:(id) kSecMatchLimitAll forKey:(id) kSecMatchLimit];
	[query setObject:(id) kCFBooleanTrue forKey:(id) kSecReturnAttributes];
	[query setObject:(id) kCFBooleanTrue forKey:(id) kSecReturnRef];

	return query;
}

- (NSMutableDictionary*) queryOfItemWithAccount: (NSString*) account WithService: (NSString*) service {
	NSMutableDictionary* query = [[NSMutableDictionary alloc] init];
	[query setObject:(id) kSecClassGenericPassword forKey:(id) kSecClass];
	[query setObject:account forKey:(id) kSecAttrAccount];
	[query setObject:service forKey:(id) kSecAttrService];
	[query setObject:(id) kCFBooleanTrue forKey:(id) kSecReturnData];

	return query;
}

@end
