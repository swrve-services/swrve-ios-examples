import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let config = SwrveConfig()
        config.pushEnabled = true;
        
        // You need to disable method Swizzling for this solution to work
        config.autoCollectDeviceToken = false;
        
        //  Set the user_id to the last known user
        //  If it is the first session set it to nil which will initialize an empty SDK
        
        let userID = UserDefaults.standard.string(forKey: "userID")
        
        // To use the EU stack, include this in your config.
        // config.stack = SWRVE_STACK_EU

        //  ----------------------------------------
        //  |ENTER YOUR OWN APP_ID AND API KEY HERE |
        //  ----------------------------------------
        
        let appID: Int32 = 0
        let apiKey = "your_api_key_here"
        
        let swrveIdentityUtils = SwrveIdentityUtils()
        swrveIdentityUtils.createSDKInstance(appID, apiKey: apiKey, config: config, userID: userID, launchOptions: launchOptions)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    //  Needed to disable Method Swizzling. This is sends the device token to Swrve
    //  to allow Push Notifications
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        if (SwrveSDK.messaging() != nil) {
            SwrveSDK.setDeviceToken(deviceToken);
        }
    }

    //  Needed to disable Method Swizzling. This is used to send the push engaged
    //  event to Swrve for tracking campaign metrics
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        SwrveSDK.pushNotificationReceived(userInfo);
    }
}
