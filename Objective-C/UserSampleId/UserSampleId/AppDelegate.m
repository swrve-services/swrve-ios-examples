#import "AppDelegate.h"
#import "swrve.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // FIXME Add your own App ID and Api Key here
    int appId = 0;
    NSString *apiKey =@"<Enter your own Api key here>";
    
    // Configure SwrveConfig as normal.  The most common steps include setting
    // the Swrve stack you'll send data to and enabling push notifications.
    SwrveConfig* config = [[SwrveConfig alloc] init];
    
    // Initialize Swrve
    [Swrve sharedInstanceWithAppID:appId apiKey:apiKey config:config launchOptions:launchOptions];
    
    // Use the SwrveSampleIdUtils to genereate a number between 1-100 for the
    // userId. This function should be called as soon as possible after
    // initializing the Swrve object.
    [SwrveSampleIdUtils sendSampleIdForUser];

    return YES;
}


@end
