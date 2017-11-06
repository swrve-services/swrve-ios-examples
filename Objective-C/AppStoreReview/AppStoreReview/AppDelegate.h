#import <UIKit/UIKit.h>

//--AppStoreReviewSolution-- Add the following two imports
#import <StoreKit/StoreKit.h>
#import "swrve.h"


//--AppStoreReviewSolution-- Add SwrveMessageDelegate to the protocals
@interface AppDelegate : UIResponder <UIApplicationDelegate, SwrveMessageDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

