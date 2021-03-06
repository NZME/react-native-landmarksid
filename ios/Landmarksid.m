#import "Landmarksid.h"
#import <LandmarksIDSDK/LandmarksIDSDK.h>

@implementation Landmarksid
{
    LandmarksIDManagerDelegate  *_landmarksIdManager;
    NSString *_appId;
    NSString *_appSecret;
    NSDictionary *_options;
}

- (void) dealloc
{
    // If you don't remove yourself as an observer, the Notification Center
    // will continue to try and send notification objects to the deallocated
    // object.
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id) init
{
    self = [super init];
    if (!self) return nil;

    for (NSString *name in @[
             UIApplicationDidBecomeActiveNotification,
             UIApplicationDidEnterBackgroundNotification,
             UIApplicationWillTerminateNotification
           ]) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleAppStateDidChange:)
                                                     name:name
                                                   object:nil];
      }

    return self;
}

RCT_EXPORT_MODULE()

+ (BOOL)requiresMainQueueSetup
{
    return YES;
}

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

RCT_EXPORT_METHOD(initialize:(nonnull NSString *)appId
                  appSecret:(nonnull NSString *)appSecret
                  options:(NSDictionary *)options)
{
    _appId = appId;
    _appSecret = appSecret;
    _options = options;

    if (_landmarksIdManager == nil) {
        [[LandmarksIDManagerDelegate sharedManager] requestLocationPermissions:kCLAuthorizationStatusAuthorizedWhenInUse];
        _landmarksIdManager = [LandmarksIDManagerDelegate initialize:appId
                                                           appSecret:appSecret];

        [_landmarksIdManager setup];

        NSString *customerId;
        if (_options != nil) {
            for (NSString *key in _options) {
                id value = _options[key];
                if ([key isEqualToString:@"customerId"]) {
                    customerId = value;
                    [[LandmarksIDManagerDelegate sharedManager] setCustomerId:customerId];
                } else if ([value isKindOfClass:[NSString class]]) {
                    [[LandmarksIDManagerDelegate sharedManager] setCustomString:key
                                                                          value:value];
                } else if ([value isKindOfClass:[NSNumber class]]) {
                    if (strcmp([value objCType], @encode(float)) == 0) {
                        [[LandmarksIDManagerDelegate sharedManager] setCustomFloat:key
                                                                             value:[(NSNumber *)value floatValue]];
                    } else if (strcmp([value objCType], @encode(int)) == 0) {
                        [[LandmarksIDManagerDelegate sharedManager] setCustomInt:key
                                                                           value:[(NSNumber *)value intValue]];
                    }
                }
            }
        }

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

RCT_EXPORT_METHOD(setCustomData:(NSDictionary *)options)
{
    if (_landmarksIdManager != nil) {
        if (_options != nil) {
            for (NSString *key in _options) {
                id value = _options[key];
                if ([value isKindOfClass:[NSString class]]) {
                    [[LandmarksIDManagerDelegate sharedManager] setCustomString:key
                                                                          value:value];
                } else if ([value isKindOfClass:[NSNumber class]]) {
                    if (strcmp([value objCType], @encode(float)) == 0) {
                        [[LandmarksIDManagerDelegate sharedManager] setCustomFloat:key
                                                                             value:[(NSNumber *)value floatValue]];
                    } else if (strcmp([value objCType], @encode(int)) == 0) {
                        [[LandmarksIDManagerDelegate sharedManager] setCustomInt:key
                                                                           value:[(NSNumber *)value intValue]];
                    }
                }
            }
        }
    }
}

- (void)handleAppStateDidChange:(NSNotification *)notification
{
    if ([notification.name isEqualToString:UIApplicationDidBecomeActiveNotification]) {
        if (_landmarksIdManager != nil) {
            [_landmarksIdManager startTracking];
        }
    } else if ([notification.name isEqualToString:UIApplicationDidEnterBackgroundNotification]) {
        if (_landmarksIdManager != nil) {
            [_landmarksIdManager startTracking];
        }
    } else if ([notification.name isEqualToString:UIApplicationWillTerminateNotification]) {
        [[LandmarksIDManagerDelegate sharedManager] applicationWillTerminate];
    }
}

@end
