#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // FIXME Add your own App ID and Api Key here
    int appId = 0;
    NSString *apiKey =@"<Enter your own Api key here>";
    
    SwrveConfig* config = [[SwrveConfig alloc] init];
    
    [Swrve sharedInstanceWithAppID:appId
                            apiKey:apiKey
                            config:config
                     launchOptions:launchOptions];
    
    // Start of cusomization for App Review Solution
    [Swrve sharedInstance].talk.showMessageDelegate = self;
    
    return YES;
}

// If we get a message containing our special string then show an alert
// But if we get something else fallback to our normal message display code.
- (void)showMessage:(SwrveMessage *)message {
    if ([message.name rangeOfString:@"appstore review" options:NSCaseInsensitiveSearch].location != NSNotFound) {
        [SKStoreReviewController requestReview];
        [message wasShownToUser];
    }
    else {
        [[Swrve sharedInstance].talk showMessage:message];
    }
}

@end
