#import <Foundation/Foundation.h>

@interface UserSampleIdUtils : NSObject{}

+ (void) generateNumberForUser:(NSString*) userID;
+ (NSString*) createStringWithMD5:(NSString*)source;

@end
