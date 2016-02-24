//
//  AppDelegate.m
//  Emergency
//
//  Created by star on 2/24/16.
//  Copyright © 2016 samule. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate () <CLLocationManagerDelegate>

@end

@implementation AppDelegate
@synthesize locationManager;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self startUpdatingLocation];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Location Services.

- (void)startUpdatingLocation
{
    if(locationManager == nil)
    {
        locationManager=[[CLLocationManager alloc] init];
        locationManager.delegate=self;
        locationManager.distanceFilter=kCLDistanceFilterNone;
        locationManager.desiredAccuracy=kCLLocationAccuracyHundredMeters;
        
        // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
        if ([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
            [locationManager requestAlwaysAuthorization];
        }
        
        [locationManager startUpdatingLocation];
    }
}

#pragma mark CLLocationManagerDelegate

+(AppDelegate*) getDelegate
{
    return (AppDelegate*)[[UIApplication sharedApplication] delegate];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"location services error = %@", error);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    if(locations != nil && [locations count] > 0)
    {
        CLLocation *current = [locations lastObject];
        self.currentLat = current.coordinate.latitude;
        self.currentLng = current.coordinate.longitude;
        
        if(TEST_FLAG)
        {
            if(self.currentLat >= 90)
            {
                self.currentLat = 90;
            }
            else if(self.currentLat <= -90)
            {
                self.currentLat = -90;
            }
            
            if(self.currentLng >= 90)
            {
                self.currentLng = 90;
            }
            else if(self.currentLng <= -90)
            {
                self.currentLng = -90;
            }
        }
    }
}

@end