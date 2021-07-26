#import "Landmarksid.h"
#import <LandmarksIDSDK.h>

@implementation Landmarksid
{
    LandmarksIDManagerDelegate  *_landmarksIdManager;
    NSString *_appId;
    NSString *_appSecret;
}

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(initialize:(nonnull NSString *)appId appSecret:(nonnull NSString *)appSecret)
{
    __appId = _appId;
    _appSecret = appSecret;
    if (_landmarksIdManager == nil) {
     _landmarksIdManager = LandmarksIDManagerDelegate.initialize(appId, appSecret: appSecret);

      _landmarksIdManager.setup()
    }
}

@end
