//
//  LandmarksIDLocationManager.h
//  LandmarksID-iOS-SDK
//
//  Created by Nisal Periyapperuma on 4/3/18.
//  Copyright © 2018 Nisal Periyapperuma. All rights reserved.
//

#import <Foundation/Foundation.h>
@import BDPointSDK;

@interface LandmarksIDLocationManager : BDLocationManager

+ (LandmarksIDLocationManager *) getInstance;

@end

