#import "Landmarksid.h"
#import <LandmarksIDSDK/LandmarksIDSDK.h>

@implementation Landmarksid
{
    LandmarksIDManagerDelegate  *_landmarksIdManager;
    NSString *_appId;
    NSString *_appSecret;
    NSDictionary *_options;
}

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(initialize:(nonnull NSString *)appId
                  appSecret:(nonnull NSString *)appSecret
                  options:(NSDictionary *)options)
{
    _appId = appId;
    _appSecret = appSecret;
    _options = options;

    if (_landmarksIdManager == nil) {
        LandmarksIDManagerDelegate *mySharedManager = [LandmarksIDManagerDelegate sharedManager];
        NSString *customerId;
        if (_options == nil) {
            for (NSString *key in _options) {
                id value = _options[key];
                NSLog(@"Value: %@ for key: %@", value, key);
                if ([key isEqualToString:@"customerId"]) {
                    customerId = value;
                } else if ([value isKindOfClass:[NSString class]]) {
                    [mySharedManager setCustomString:key
                                               value:value];
                } else if ([value isKindOfClass:[NSNumber class]]) {
                    if (strcmp([value objCType], @encode(float)) == 0) {
                        [mySharedManager setCustomFloat:key
                                                  value:[(NSNumber *)value floatValue]];
                    } else if (strcmp([value objCType], @encode(int)) == 0) {
                        [mySharedManager setCustomInt:key
                                                value:[(NSNumber *)value intValue]];
                    }
                }
            }
        }

        mySharedManager.customerId = customerId;

        [[LandmarksIDManagerDelegate sharedManager] requestLocationPermissions:kCLAuthorizationStatusAuthorizedWhenInUse];
        _landmarksIdManager = [LandmarksIDManagerDelegate initialize:appId
                                                           appSecret:appSecret];

        [_landmarksIdManager setup];
        // start tracking imediately if the application is active
        if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateActive) {
            [_landmarksIdManager startTracking];
        }
    }
}

RCT_EXPORT_METHOD(startTracking)
{
    if (_landmarksIdManager != nil) {
        [_landmarksIdManager startTracking];
    }
}

RCT_EXPORT_METHOD(stopTracking)
{
    if (_landmarksIdManager != nil) {
        [_landmarksIdManager stopTracking];
    }
}

#pragma mark UIApplicationDelegate implementation

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    if (_landmarksIdManager != nil) {
        [_landmarksIdManager startTracking];
    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    if (_landmarksIdManager != nil) {
        [_landmarksIdManager startTracking];
    }
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [[LandmarksIDManagerDelegate sharedManager] applicationWillTerminate];
}

@end
