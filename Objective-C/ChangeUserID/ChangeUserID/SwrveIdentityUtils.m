//  A utility to manage user identity with the Swrve SDK. This utility gives you the ability
//  to (a) initialize Swrve if you don't have a user ID yet (i.e. first session or before the
//  user has logged in), set the identity of the user once you have it and (c) change the
//  identity in case the user logs out an another logs in.

#import "SwrveIdentityUtils.h"
#import <UIKit/UIKit.h>

@interface SwrveIdentityUtils()

@end

@implementation SwrveIdentityUtils {

int _appID;
NSString * _apiKey;
SwrveConfig * _config;
NSString* _eventsUrl;
NSString* _contentUrl;
    
}

//  Call this method to initialize the Swrve SDK.  After you call this method you no longer
//  need to call SwrveSDK.createInstance.  You must call this method before you can call
//  changeUserID.
- (void) createSDKInstance:(int) appID apiKey:(NSString*)apiKey config:(SwrveConfig*)config userID:(NSString*) userID launchOptions:(NSDictionary*) launchOptions
{
    _appID = appID;
    _apiKey = apiKey;
    _config = config;
    _eventsUrl = _config.eventsServer;
    _contentUrl = _config.contentServer;
    
    //  Method Swizzling must be turned off for this solution to work. For instructions on how to
    //  do this go to the "Disabling Push Notification Method Swizzling" section of our iOS
    //  implementation guide: https://docs.swrve.com/developer-documentation/integration/ios#Push_Notifications
    
    if( config.pushEnabled == YES && config.autoCollectDeviceToken == YES ) {
        NSException* myException = [NSException
                                    exceptionWithName:@"SwrveIdentityUtilsException"
                                    reason:@"You must disable method swizzling for this solution to work. Please see our documentation on disabling method swizzling."
                                    userInfo:nil];
        @throw myException;
    }
    
    [self initializeSDK:userID launchOptions:launchOptions];
}

//  Call this method to change the user ID referenced in the Swrve SDK. Calling this method
//  will do several things.  First it will attempt to send all events for the current user
//  to Swrve's servers.  If this fails the events will be saved to disk and be sent the next
//  time the Swrve SDK is initialized with the user ID.  Next, the Swrve SDK will be shut down
//  and it will detach from the current ActivityContext.  As a result, in-app messages or
//  conversations will be dismissed.  Next, the Swrve SDK will be re-initialized and it will
//  reattach itself to the activity provided.
- (void) changeUserID:(NSString *) userID {
    [self initializeSDK:userID launchOptions:nil];
}

- (void) initializeSDK:(NSString*) userID launchOptions:(NSDictionary*) launchOptions
{
    // Destory old instance, if it exists
    if( [SwrveSDK sharedInstance] != nil )
    {
        // Save events to disk.
        [SwrveSDK saveEventsToDisk];
        
        // Try to send the events to Swrves servers.  If this fails the events won't be sent
        // until the SDK is initialized with the old user's ID again.
        [SwrveSDK sendQueuedEvents];
        
        // Shutdown the SDK
        [[SwrveSDK class] performSelector:@selector(resetSwrveSharedInstance)];
    }
    
    // Add the user id to the name of the local DB for the SDK.  This will 'namespace'
    // all of the events raised and content to the user ID.
    _config.userId = (userID == nil) ? @"invalid_user_id" : userID;

    
    // Don't send any data to Swrve servers if userID is nil
    if(userID == nil){
        _config.eventsServer = @"";
        _config.contentServer = @"";
    } else {
        _config.eventsServer = _eventsUrl;
        _config.contentServer = _contentUrl;
    }
    
    // Create the Swrve Instance
    [SwrveSDK sharedInstanceWithAppID:_appID apiKey:_apiKey config:_config launchOptions:launchOptions];
    // Call beginSession to finish initialization of the SDK
    [[SwrveSDK sharedInstance] performSelector:@selector(appDidBecomeActive:) withObject:nil];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)newDeviceToken {
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
}
@end
