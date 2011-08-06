//
//  Keychain.h
//  Unlock
//
//  Created by Justin Ridgewell on 8/5/11.
//

@interface Keychain : NSObject
- (NSMutableArray*) volumesAndPasswordsWithService: (NSString*) service;
@end