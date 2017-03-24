#import <Foundation/Foundation.h>

@interface UserSampleIdUtils : NSObject{}

+ (int) generateNumberForUser:(NSString*) userID;
+ (NSString*) createStringWithMD5:(NSString*)source;

@end
