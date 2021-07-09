#import "AppDelegate.h"
#import "SwrveSDK.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // FIXME Add your own App ID and Api Key here
    int appId = 0;
    NSString *apiKey =@"<Enter your own Api key here>";
    
    SwrveConfig* config = [[SwrveConfig alloc] init];
    
    // Configure the callback for Embedded Campaigns
    SwrveEmbeddedMessageConfig *embeddedMessageConfig = [SwrveEmbeddedMessageConfig new];
    [embeddedMessageConfig setEmbeddedMessageCallback:^(SwrveEmbeddedMessage *message) {

        // Parse the JSON for the embedded campaign into a dictionary
        NSData * jsonData = [message.data dataUsingEncoding:NSUTF8StringEncoding];
        NSError * error=nil;
        NSDictionary * parsedData = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
        
        // Check if the campaign_type is set to app_review in the campaign JSON
        // If it is call the requestReview API
        if ([parsedData[@"campaign_type"] isEqualToString:@"app_review"]) {
            [SKStoreReviewController requestReview];
        }
        
        // Trigger an impression event - in this case it doesn't actually mean that
        // they saw the reveiw dialog. It means that requestReview was called.
        [SwrveSDK embeddedMessageWasShownToUser:message];
    }];
    
    // set the embeddedMessageConfig in the main SwrveConfig object
    config.embeddedMessageConfig = embeddedMessageConfig;
    
    [SwrveSDK sharedInstanceWithAppID:appId
    apiKey:apiKey
    config:config];
    
    return YES;
}

@end
