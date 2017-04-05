#import "AppDelegate.h"
#import "swrve.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // FIXME Add your own App ID and Api Key here
    int appId = 0;
    NSString *apiKey =@"<Enter your own Api key here>";
    
    //  Configure SwrveConfig as normal.  The most common steps include setting the
    //  Swrve stack you'll send data to and enabling push notifications.
    SwrveConfig* config = [[SwrveConfig alloc] init];
    
    // Uncomment these lines to test the correct values are returned for these user_id's'
    // config.userId = @"01a94aec-d8ba-4292-8ab3-04edef4d1d71"; // returns 1
    // config.userId = @"018bb009-db2c-4feb-9c61-ec5871cd1cea"; // returns 50
    // config.userId = @"01b2d2e6-3fa5-4abb-aad8-d0aed0ece9b8";   // returns 100
    
    // Initialize Swrve
    [Swrve sharedInstanceWithAppID:appId apiKey:apiKey config:config launchOptions:launchOptions];
    
    // Get the Swrve UserId
    NSString *swrveUserId = [[Swrve sharedInstance] userID];
    
    // Use the UserSampleIdUtils to genereate a number between 1-100 for the userId
    [UserSampleIdUtils generateNumberForUser:swrveUserId];
    
    return YES;
}


@end
