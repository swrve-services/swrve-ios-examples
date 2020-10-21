//
//  AppDelegate.m
//  PermissionDelegateExample
//
//  Created by David Breen on 21/10/2020.
//  Copyright © 2020 Swrve. All rights reserved.
//

#import "AppDelegate.h"
#import <SwrveSDK/SwrveSDK.h>
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import <CoreLocation/CoreLocation.h>
#import <Contacts/Contacts.h>

@interface AppDelegate ()<SwrvePermissionsDelegate>

@end

@implementation AppDelegate
CLLocationManager* locManager;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    SwrveConfig* config = [[SwrveConfig alloc] init];
    config.permissionsDelegate = self;

    // TODO Replace with your own app_id and api key here:
    [SwrveSDK sharedInstanceWithAppID:0
        apiKey:@"<api_key_here"
        config:config];
    
    locManager = [[CLLocationManager alloc]init];
    
    return YES;
}

/*! Status of the Camera permission.
*
* returns SwrvePermissionState State of the camera permission.
*/
- (SwrvePermissionState)cameraPermissionState {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (authStatus) {
        case AVAuthorizationStatusAuthorized:
            return SwrvePermissionStateAuthorized;
        case AVAuthorizationStatusDenied:
        case AVAuthorizationStatusRestricted:
            return SwrvePermissionStateDenied;
        case AVAuthorizationStatusNotDetermined:
            return SwrvePermissionStateUnknown;
    }
    return SwrvePermissionStateUnsupported;
}

/*! Request the Camera permission */
- (void) requestCameraPermission:(void (^)(BOOL processed))callback {
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        dispatch_async(dispatch_get_main_queue(), ^{
            callback(true);
        });
    }];
}

- (SwrvePermissionState)contactPermissionState{
  CNEntityType entityType = CNEntityTypeContacts;
  CNAuthorizationStatus authStatus = [CNContactStore authorizationStatusForEntityType:entityType];
  switch (authStatus) {
      case CNAuthorizationStatusAuthorized:
          return SwrvePermissionStateAuthorized;
      case CNAuthorizationStatusDenied:
      case CNAuthorizationStatusRestricted:
          return SwrvePermissionStateDenied;
      case CNAuthorizationStatusNotDetermined:
          return SwrvePermissionStateUnknown;
  }
  return SwrvePermissionStateUnsupported;
}

- (void) requestContactsPermission:(void (^)(BOOL processed))callback{
  CNContactStore* contact = [[CNContactStore alloc] init];
  [contact requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
    dispatch_async(dispatch_get_main_queue(), ^{
        callback(granted);
    });
  }];

}

- (SwrvePermissionState)photoLibraryPermissionState{
  PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];
  switch (authStatus) {
      case PHAuthorizationStatusAuthorized:
          return SwrvePermissionStateAuthorized;
      case PHAuthorizationStatusDenied:
      case PHAuthorizationStatusRestricted:
          return SwrvePermissionStateDenied;
      case PHAuthorizationStatusNotDetermined:
          return SwrvePermissionStateUnknown;
      break;
  }
  return SwrvePermissionStateUnsupported;
}
- (void) requestPhotoLibraryPermission:(void (^)(BOOL processed))callback{
  [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
    dispatch_async(dispatch_get_main_queue(), ^{
      if(status == PHAuthorizationStatusAuthorized){
        callback(true);
      }
    });
  }];
}

- (SwrvePermissionState)locationAlwaysPermissionState{
  CLAuthorizationStatus authStatus = [CLLocationManager authorizationStatus];
    switch (authStatus) {
        case kCLAuthorizationStatusAuthorizedAlways:
            return SwrvePermissionStateAuthorized;
        case kCLAuthorizationStatusDenied:
        case kCLAuthorizationStatusRestricted:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            return SwrvePermissionStateDenied;
        case kCLAuthorizationStatusNotDetermined:
            return SwrvePermissionStateUnknown;
        break;
    }
  return SwrvePermissionStateUnsupported;
}

- (void) requestLocationAlwaysPermission:(void (^)(BOOL processed))callback{
  [locManager requestAlwaysAuthorization];
  dispatch_async(dispatch_get_main_queue(), ^{
      callback(true);
  });
}

- (SwrvePermissionState)locationWhenInUsePermissionState{
  CLAuthorizationStatus authStatus = [CLLocationManager authorizationStatus];
  if([CLLocationManager locationServicesEnabled]){
    switch (authStatus) {
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        case kCLAuthorizationStatusAuthorizedAlways:
            return SwrvePermissionStateAuthorized;
        case kCLAuthorizationStatusDenied:
        case kCLAuthorizationStatusRestricted:
            return SwrvePermissionStateDenied;
        case kCLAuthorizationStatusNotDetermined:
            return SwrvePermissionStateUnknown;
        break;
    }
  }
  return SwrvePermissionStateUnsupported;
}

/*! Request the Location When In Use permission */
- (void) requestLocationWhenInUsePermission:(void (^)(BOOL processed))callback{
 [locManager requestWhenInUseAuthorization];
 dispatch_async(dispatch_get_main_queue(), ^{
     callback(true);
 });
}

@end
