//
//  ViewController.m
//  PermissionDelegateExample
//
//  Created by David Breen on 21/10/2020.
//  Copyright © 2020 Swrve. All rights reserved.
//

#import "ViewController.h"
#import <SwrveSDK/SwrveSDK.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)requestCameraPermission:(id)sender {
    NSLog(@"requestCameraPermissionButton");
    
    [SwrveSDK event:@"trigger_permission_campaign" payload:@{
        @"permission":@"camera"
    }];
}
- (IBAction)requestContactsPermission:(id)sender {
    NSLog(@"requestContactsPermissionButton");
    
    [SwrveSDK event:@"trigger_permission_campaign" payload:@{
        @"permission":@"contacts"
    }];
}
- (IBAction)requestPhotoLibraryPermission:(id)sender {
    NSLog(@"requestPhotoLibraryPermissionButton");
    
    [SwrveSDK event:@"trigger_permission_campaign" payload:@{
        @"permission":@"photo_library"
    }];
}
- (IBAction)requestLocationAlwaysPermission:(id)sender {
    NSLog(@"requestLocationAlwaysPermissionButton");
    
    [SwrveSDK event:@"trigger_permission_campaign" payload:@{
        @"permission":@"location_always"
    }];
}
- (IBAction)requestLocationWhenInUsePermission:(id)sender {
    NSLog(@"requestLocationWhenInUsePermission");
    
    [SwrveSDK event:@"trigger_permission_campaign" payload:@{
        @"permission":@"location_when_in_use"
    }];
}

@end
