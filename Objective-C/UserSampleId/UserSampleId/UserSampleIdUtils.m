#import "UserSampleIdUtils.h"
#import "swrve.h"
#import <CommonCrypto/CommonHMAC.h>

@implementation UserSampleIdUtils

/**
 * A utility to send a user_property update to Swrve. The user property should be a number
 * from 1-100.
 * This number can then be used to separate users into target groups and compare different
 * marketing strategies.
 * e.g. To target 1/4 of users you would use the filter "user_sample_id between 1 and 25 inclusive"
 */
+ (void) generateNumberForUser:(NSString *) userId {
    
    NSString *hash = [self createStringWithMD5:userId];
    hash = [hash substringToIndex:8];
    double user_number = 0;
    unsigned long long user_number_long = 0;
    
    // Convert the string to an unsigned long long
    NSScanner *scanner = [NSScanner scannerWithString:hash];
    [scanner scanHexLongLong:&user_number_long];
    
    // Convert result to a double and calcualte the User Sample Id
    user_number = (double) user_number_long;
    double max_md5 = 4294967295.0;
    double user_range = user_number / max_md5;
    
    // Ceiling method - round up to the the next integer value
    // returns an integer from 1-100 inclusive
    int userSampleId = ceil(user_range * 100.0);
    
    // Update the user user_sample_id user property in Swrve
    [[Swrve sharedInstance] userUpdate:@{@"user_sample_id": [NSString stringWithFormat:@"%d", userSampleId]}];
}

// Method to return an MD5 hash of a string
+ (NSString*) createStringWithMD5:(NSString*)source
{
#define C "%02x"
#define CCCC C C C C
#define DIGEST_FORMAT CCCC CCCC CCCC CCCC
    
    NSString* digestFormat = [NSString stringWithFormat:@"%s", DIGEST_FORMAT];
    
    NSData* buffer = [source dataUsingEncoding:NSUTF8StringEncoding];
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH] = {0};
    unsigned int length = (unsigned int)[buffer length];
    CC_MD5_CTX context;
    CC_MD5_Init(&context);
    CC_MD5_Update(&context, [buffer bytes], length);
    CC_MD5_Final(digest, &context);
    
    NSString* result = [NSString stringWithFormat:digestFormat,
                        digest[ 0], digest[ 1], digest[ 2], digest[ 3],
                        digest[ 4], digest[ 5], digest[ 6], digest[ 7],
                        digest[ 8], digest[ 9], digest[10], digest[11],
                        digest[12], digest[13], digest[14], digest[15]];
    
    return result;
}

+ (id)alloc {
    [NSException raise:@"Cannot be instantiated!" format:@"Static class 'UserSampleIdUtils' cannot be instantiated!"];
    return nil;
}

@end
