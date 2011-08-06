//
//  Diskutil.h
//  Unlock
//
//  Created by Justin Ridgewell on 8/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

@interface Diskutil : NSObject
+ (void) unlockVolume: (NSString*) uuid WithPassphrase: (NSString*) passphrase;
@end
