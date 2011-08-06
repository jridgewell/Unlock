//
//  Diskutil.h
//  Unlock
//
//  Created by Justin Ridgewell on 8/6/11.
//

@interface Diskutil : NSObject
+ (void) unlockVolume: (NSString*) uuid WithPassphrase: (NSString*) passphrase;
@end
