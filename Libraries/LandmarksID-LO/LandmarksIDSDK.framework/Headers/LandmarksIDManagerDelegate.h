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

@property (nonatomic, strong, nonnull) CLLocationManager* locationManager;

@property (nonatomic, strong, nonnull) NSString *appIdentifier;
@property (nonatomic, strong, nonnull) NSString *appSecret;

@property (nonatomic, strong, nonnull) NSString* deviceId;
@property (nonatomic, strong, nullable) NSString* vendorId;
@property (nonatomic, strong, nonnull) NSString* sessionId;
@property (nonatomic, strong, nullable) NSString* appBuildVersion;
@property (nonatomic, strong, nonnull) NSString* osVersion;
@property (nonatomic) BOOL adTrackingEnabled;

// APP LEVEL CONFIG
@property BOOL locationOptimisedEnabled;
@property CLLocationDistance distanceFilter;
@property int batchSize;
@property int terminatedBatchSize;
@property long terminatedEventsSize;
@property BOOL shouldCollectData;
@property (nonatomic, strong, nonnull) NSString* clientId;
@property (nonatomic, strong, nonnull) NSMutableArray* monitoredApps;

@property (nonatomic, strong, nullable) NSString* customerId;

@property (nonatomic, strong, nonnull) NSMutableDictionary *trackLastLocation;
@property (nonatomic, strong, nonnull) NSMutableDictionary *usedEventIds;
@property (nonatomic, strong, nullable) NSDictionary *lastDeviceInfo;
@property (nonatomic, strong, nonnull) NSMutableArray *customData;
@property (nonatomic, strong, nullable) NSString *customDataType;
@property (nonatomic, strong, nullable) NSString *customDataKey;
@property (nonatomic, strong, nullable) NSString *customDataValue;
@property (nonatomic, strong, nullable) CLLocation *lastLORELocation;
@property (nonatomic) BOOL LOTrackingEnabled;
@property (nonatomic) BOOL LODTrackingEnabled;

@property (nonatomic) BOOL allowsTerminatedTracking;

@property (nonatomic) BOOL significantLocationTrackingEnabled;
@property (nonatomic) BOOL foregroundTrackingEnabled;

@property (nonatomic) BOOL enableNetworkName;
@property (nonatomic) BOOL enableAdvertisingId;
@property (nonatomic) BOOL enableSimOperator;

@property (nonatomic, strong, nonnull) NSMutableArray *events;
@property (assign) int LOCount;
@property (assign) int LODCount;

@property (nonatomic, strong, nonnull) NSString *allLogs;

@property (nonatomic) BOOL serverConfigLoaded;
@property (nonatomic) BOOL loreRequestStatus;

@property (nonatomic) BOOL debug;
@property (nonatomic) BOOL notify;

- (instancetype _Nonnull)init;

+ (LandmarksIDManagerDelegate* _Nonnull)initialize:(NSString * _Nonnull)appIdentifier
                                  appSecret:(NSString * _Nonnull)appSecret;


+ (LandmarksIDManagerDelegate* _Nonnull)sharedManager;

- (void)setup;
- (void)startTracking;
- (void)stopTracking;
- (void)applicationWillTerminate;
- (void)applicationTerminated;

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


