//
//  LandmarksIDManagerDelegate.h
//  LandmarksID-ObjectiveC
//
//  Created by Nisal Periyapperuma on 28/2/18.
//  Copyright © 2018 Nisal Periyapperuma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@interface LandmarksIDManagerDelegate : NSObject <CLLocationManagerDelegate, NSURLSessionDelegate, NSURLSessionDataDelegate>

@property (nonatomic, strong) CLLocationManager* locationManager;

@property (nonatomic, strong) NSString *appIdentifier;
@property (nonatomic, strong) NSString *appSecret;
@property (nonatomic, strong) NSString* apiURL;
@property (nonatomic, strong) NSString* debugURL;
@property (nonatomic, strong) NSString* apiKey;
@property (nonatomic, strong) NSString* username;
@property (nonatomic, strong) NSString* packageName;

@property (nonatomic, strong) NSString* deviceId;
@property (nonatomic, strong) NSString* vendorId;
@property (nonatomic, strong) NSString* sessionId;
@property (nonatomic, strong) NSString* appBuildVersion;
@property (nonatomic, strong) NSString* osVersion;
@property (nonatomic) BOOL adTrackingEnabled;

// APP LEVEL CONFIG
@property BOOL discoveryEnabled;
@property BOOL locationOptimisedEnabled;
@property CLLocationDistance distanceFilter;
@property int batchSize;
@property int terminatedBatchSize;
@property long terminatedEventsSize;
@property BOOL shouldCollectData;
@property NSString* clientId;
@property NSMutableArray* monitoredApps;

@property (nonatomic, strong) NSString* customerId;

@property (nonatomic, strong) NSURLSession *requestSession;
@property (nonatomic) UIBackgroundTaskIdentifier *backgroundUpdateTask;

@property NSString *lastSourceEventId;

@property NSMutableDictionary *trackLastLocation;
@property NSMutableDictionary *usedEventIds;
@property NSDictionary *lastDeviceInfo;
@property NSMutableArray *customData;
@property NSString *customDataType;
@property NSString *customDataKey;
@property NSString *customDataValue;
@property CLLocation *lastLORELocation;
@property (nonatomic) BOOL LOTrackingEnabled;
@property (nonatomic) BOOL LODTrackingEnabled;

@property (nonatomic) BOOL allowsTerminatedTracking;

@property (nonatomic) BOOL discoveryTrackingEnabled;
@property (nonatomic) BOOL significantLocationTrackingEnabled;
@property (nonatomic) BOOL foregroundTrackingEnabled;

@property (nonatomic) BOOL enableNetworkName;
@property (nonatomic) BOOL enableAdvertisingId;
@property (nonatomic) BOOL enableSimOperator;

@property (nonatomic, strong) NSMutableArray *events;
@property (assign) int LOCount;
@property (assign) int LODCount;

@property (nonatomic, strong) NSString *allLogs;

@property (nonatomic) BOOL serverConfigLoaded;
@property (nonatomic) BOOL loreRequestStatus;

@property (nonatomic) BOOL debug;
@property (nonatomic) BOOL notify;

- (id)init;

+ (LandmarksIDManagerDelegate* _Nonnull)initialize:(NSString * _Nonnull)appIdentifier
                                  appSecret:(NSString * _Nonnull)appSecret
                                    apiKey:(NSString * _Nonnull)apiKey;


+ (LandmarksIDManagerDelegate* _Nonnull)sharedManager;

- (void)setup;
- (void)startTracking;
- (void)stopTracking;
- (void)applicationWillTerminate;
- (void)applicationTerminated;
- (void)testRequest;

// Handle Custom Data

- (void) setCustomInt: (NSString * _Nonnull)key
                value: (int) value;

- (void) setCustomFloat: (NSString * _Nonnull)key
                value: (float) value;

- (void) setCustomString: (NSString * _Nonnull)key
                  value: (NSString* _Nullable) value;


- (NSString * _Nullable) customerId;
- (void) setCustomerId: (NSString * _Nullable)customerId;

// Handle Location Permissions

- (void)requestLocationPermissions: (CLAuthorizationStatus)locationPermissionType;

// Client side kill switch

- (void)stopRecordingData;
- (void)restartRecordingData;
- (BOOL)isAllowedToRecordData;

- (void) requestPermissionForIDFA;

@end


