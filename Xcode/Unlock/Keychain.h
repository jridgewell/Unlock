//
//  Keychain.h
//  Unlock
//
//  Created by Justin Ridgewell on 8/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

@interface Keychain : NSObject
- (NSMutableArray*) volumesAndPasswordsWithService: (NSString*) service;
@end