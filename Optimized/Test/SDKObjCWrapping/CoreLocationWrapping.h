//
//  Created by Nikolay Lihogrud on 18.03.17.
//  Copyright © 2017 Yandex LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(int, CLWDeviceOrientation) {
    CLWDeviceOrientationUnknown = 0,
    CLWDeviceOrientationPortrait,
    CLWDeviceOrientationPortraitUpsideDown,
    CLWDeviceOrientationLandscapeLeft,
    CLWDeviceOrientationLandscapeRight,
    CLWDeviceOrientationFaceUp,
    CLWDeviceOrientationFaceDown
};

typedef NS_ENUM(NSInteger, CLWActivityType) {
    CLWActivityTypeOther = 1,
    CLWActivityTypeAutomotiveNavigation,	// for automotive navigation
    CLWActivityTypeFitness,				// includes any pedestrian activities
    CLWActivityTypeOtherNavigation 		// for other navigation cases (excluding pedestrian navigation), e.g. navigation for boats, trains, or planes
};

typedef NS_ENUM(int, CLWAuthorizationStatus) {
    kCLWAuthorizationStatusNotDetermined = 0,
    kCLWAuthorizationStatusRestricted,
    kCLWAuthorizationStatusDenied,
    kCLWAuthorizationStatusAuthorizedAlways NS_ENUM_AVAILABLE(10_12, 8_0),
    kCLWAuthorizationStatusAuthorizedWhenInUse NS_ENUM_AVAILABLE(NA, 8_0),
    kCLWAuthorizationStatusAuthorized NS_ENUM_DEPRECATED(10_6, NA, 2_0, 8_0, "Use kCLAuthorizationStatusAuthorizedAlways") __TVOS_PROHIBITED __WATCHOS_PROHIBITED = kCLWAuthorizationStatusAuthorizedAlways
};

@class CLWLocationManager;

typedef double CLWLocationDegrees;
typedef double CLWLocationAccuracy;
typedef double CLWLocationSpeed;
typedef double CLWLocationDirection;
typedef double CLWLocationDistance;

extern CLWLocationAccuracy kCLWLocationAccuracyBestForNavigation;
extern CLWLocationAccuracy kCLWLocationAccuracyBest;
extern CLWLocationAccuracy kCLWLocationAccuracyNearestTenMeters;
extern CLWLocationAccuracy kCLWLocationAccuracyHundredMeters;
extern CLWLocationAccuracy kCLWLocationAccuracyKilometer;
extern CLWLocationAccuracy kCLWLocationAccuracyThreeKilometers;

struct CLWLocationCoordinate2D {
    CLWLocationDegrees latitude;
    CLWLocationDegrees longitude;
};
typedef struct CLWLocationCoordinate2D CLWLocationCoordinate2D;

typedef double CLWLocationDistance;

@interface CLWLocation : NSObject <NSCopying, NSSecureCoding>

- (instancetype _Nonnull)initWithLatitude:(CLWLocationDegrees)latitude
                                longitude:(CLWLocationDegrees)longitude;


- (instancetype _Nonnull)initWithCoordinate:(CLWLocationCoordinate2D)coordinate
                                   altitude:(CLWLocationDistance)altitude
                         horizontalAccuracy:(CLWLocationAccuracy)hAccuracy
                           verticalAccuracy:(CLWLocationAccuracy)vAccuracy
                                  timestamp:(NSDate *)timestamp;

- (instancetype _Nonnull)initWithCoordinate:(CLWLocationCoordinate2D)coordinate
                                   altitude:(CLWLocationDistance)altitude
                         horizontalAccuracy:(CLWLocationAccuracy)hAccuracy
                           verticalAccuracy:(CLWLocationAccuracy)vAccuracy
                                     course:(CLWLocationDirection)course
                                      speed:(CLWLocationSpeed)speed
                                  timestamp:(NSDate *)timestamp __OSX_AVAILABLE_STARTING(__MAC_10_7,__IPHONE_4_2);

@property(readonly, nonatomic) CLWLocationCoordinate2D coordinate;
@property(readonly, nonatomic) CLWLocationDistance altitude;
@property(readonly, nonatomic) CLWLocationAccuracy horizontalAccuracy;
@property(readonly, nonatomic) CLWLocationAccuracy verticalAccuracy;
@property(readonly, nonatomic) CLWLocationDirection course __OSX_AVAILABLE_STARTING(__MAC_10_7,__IPHONE_2_2) __TVOS_PROHIBITED;
@property(readonly, nonatomic) CLWLocationSpeed speed __OSX_AVAILABLE_STARTING(__MAC_10_7,__IPHONE_2_2) __TVOS_PROHIBITED;
@property(readonly, nonatomic, copy) NSDate *timestamp ;

- (CLWLocationDistance)getDistanceFrom:(const CLWLocation *)location __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_NA,__MAC_NA,__IPHONE_2_0,__IPHONE_3_2) __TVOS_PROHIBITED __WATCHOS_PROHIBITED;

- (CLWLocationDistance)distanceFromLocation:(const CLWLocation *)location __OSX_AVAILABLE_STARTING(__MAC_10_6,__IPHONE_3_2);

@end

typedef double CLWHeadingComponentValue;

NS_CLASS_AVAILABLE(10_7, 3_0) __TVOS_PROHIBITED __WATCHOS_PROHIBITED
@interface CLWHeading : NSObject <NSCopying, NSSecureCoding>

@property(readonly, nonatomic) CLWLocationDirection magneticHeading;
@property(readonly, nonatomic) CLWLocationDirection trueHeading;
@property(readonly, nonatomic) CLWLocationDirection headingAccuracy;
@property(readonly, nonatomic) CLWHeadingComponentValue x;
@property(readonly, nonatomic) CLWHeadingComponentValue y;
@property(readonly, nonatomic) CLWHeadingComponentValue z;
@property(readonly, nonatomic, copy) NSDate *timestamp;

@end

@protocol CLWLocationManagerDelegate<NSObject>

@optional

- (void)locationManager:(CLWLocationManager *)manager
    didUpdateToLocation:(CLWLocation *)newLocation
           fromLocation:(CLWLocation *)oldLocation __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_6, __MAC_NA, __IPHONE_2_0, __IPHONE_6_0) __TVOS_PROHIBITED __WATCHOS_PROHIBITED;


- (void)locationManager:(CLWLocationManager *)manager didUpdateLocations:(NSArray<CLWLocation *> *)locations
    NS_SWIFT_NAME(locationManager(_:didUpdateLocations:))
    __OSX_AVAILABLE_STARTING(__MAC_10_9,__IPHONE_6_0);

- (BOOL)locationManagerShouldDisplayHeadingCalibration:(CLWLocationManager *)manager  __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0) __TVOS_PROHIBITED __WATCHOS_PROHIBITED;

- (void)locationManager:(CLWLocationManager *)manager
       didFailWithError:(NSError *)error;

- (void)locationManager:(CLWLocationManager *)manager didChangeAuthorizationStatus:(CLWAuthorizationStatus)status
    NS_SWIFT_NAME(locationManager(_:didChangeAuthorization:))
    __OSX_AVAILABLE_STARTING(__MAC_10_7,__IPHONE_4_2);

- (void)locationManagerDidPauseLocationUpdates:(CLWLocationManager *)manager __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_6_0) __TVOS_PROHIBITED __WATCHOS_PROHIBITED;

- (void)locationManagerDidResumeLocationUpdates:(CLWLocationManager *)manager __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_6_0) __TVOS_PROHIBITED __WATCHOS_PROHIBITED;

- (void)locationManager:(CLWLocationManager *)manager
didFinishDeferredUpdatesWithError:(nullable NSError *)error __OSX_AVAILABLE_STARTING(__MAC_10_9,__IPHONE_6_0) __TVOS_PROHIBITED __WATCHOS_PROHIBITED;

- (void)locationManager:(CLWLocationManager *)manager didUpdateHeading:(CLWHeading *)newHeading
    NS_SWIFT_NAME(locationManager(_:didUpdateHeading:))
    __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0) __TVOS_PROHIBITED __WATCHOS_PROHIBITED;

@end

@interface CLWLocationManager: NSObject

+ (BOOL)locationServicesEnabled;

+ (BOOL)headingAvailable __OSX_AVAILABLE_STARTING(__MAC_10_7,__IPHONE_4_0) __TVOS_PROHIBITED __WATCHOS_PROHIBITED;

+ (BOOL)significantLocationChangeMonitoringAvailable __OSX_AVAILABLE_STARTING(__MAC_10_7,__IPHONE_4_0) __TVOS_PROHIBITED __WATCHOS_PROHIBITED;

+ (CLWAuthorizationStatus)authorizationStatus __OSX_AVAILABLE_STARTING(__MAC_10_7,__IPHONE_4_2);

@property(assign, nonatomic, nullable) id<CLWLocationManagerDelegate> delegate;

@property(readonly, nonatomic) BOOL locationServicesEnabled __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_NA,__MAC_NA,__IPHONE_2_0,__IPHONE_4_0) __TVOS_PROHIBITED __WATCHOS_PROHIBITED;

@property(assign, nonatomic) CLWActivityType activityType __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_6_0) __TVOS_PROHIBITED __WATCHOS_PROHIBITED;

@property(assign, nonatomic) CLWLocationDistance distanceFilter;

@property(assign, nonatomic) CLWLocationAccuracy desiredAccuracy;

@property(assign, nonatomic) BOOL pausesLocationUpdatesAutomatically __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_6_0) __TVOS_PROHIBITED __WATCHOS_PROHIBITED;

@property(assign, nonatomic) BOOL allowsBackgroundLocationUpdates __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_9_0) __TVOS_PROHIBITED __WATCHOS_PROHIBITED;

@property(readonly, nonatomic, copy, nullable) CLWLocation *location;

@property(readonly, nonatomic) BOOL headingAvailable __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_NA,__MAC_NA,__IPHONE_3_0,__IPHONE_4_0) __TVOS_PROHIBITED __WATCHOS_PROHIBITED;

- (void)requestWhenInUseAuthorization __OSX_AVAILABLE_STARTING(__MAC_NA, __IPHONE_8_0);

- (void)requestAlwaysAuthorization __OSX_AVAILABLE_STARTING(__MAC_NA, __IPHONE_8_0) __TVOS_PROHIBITED;

- (void)startUpdatingLocation __TVOS_PROHIBITED;

- (void)stopUpdatingLocation;

- (void)requestLocation __OSX_AVAILABLE_STARTING(__MAC_NA, __IPHONE_9_0);

- (void)startUpdatingHeading __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0) __TVOS_PROHIBITED __WATCHOS_PROHIBITED;

- (void)stopUpdatingHeading __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0) __TVOS_PROHIBITED __WATCHOS_PROHIBITED;

- (void)dismissHeadingCalibrationDisplay __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0) __TVOS_PROHIBITED __WATCHOS_PROHIBITED;

- (void)allowDeferredLocationUpdatesUntilTraveled:(CLWLocationDistance)distance
                                          timeout:(NSTimeInterval)timeout __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_6_0) __TVOS_PROHIBITED __WATCHOS_PROHIBITED;

- (void)disallowDeferredLocationUpdates __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_6_0) __TVOS_PROHIBITED __WATCHOS_PROHIBITED;

+ (BOOL)deferredLocationUpdatesAvailable __OSX_AVAILABLE_STARTING(__MAC_10_9,__IPHONE_6_0) __TVOS_PROHIBITED __WATCHOS_PROHIBITED;

@end

@interface CoreLocationWrapping: NSObject

@end

NS_ASSUME_NONNULL_END
