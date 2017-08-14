//
//  Created by Nikolay Lihogrud on 18.03.17.
//  Copyright © 2017 Yandex LLC. All rights reserved.
//

#import "CoreLocationWrapping.h"
#import <CoreLocation/CoreLocation.h>

CLWLocationAccuracy kCLWLocationAccuracyBestForNavigation = kCLLocationAccuracyBestForNavigation;
CLWLocationAccuracy kCLWLocationAccuracyBest = kCLLocationAccuracyBest;
CLWLocationAccuracy kCLWLocationAccuracyNearestTenMeters = kCLLocationAccuracyNearestTenMeters;
CLWLocationAccuracy kCLWLocationAccuracyHundredMeters = kCLLocationAccuracyHundredMeters;
CLWLocationAccuracy kCLWLocationAccuracyKilometer = kCLLocationAccuracyKilometer;
CLWLocationAccuracy kCLWLocationAccuracyThreeKilometers = kCLLocationAccuracyThreeKilometers;

@interface CLWLocation()

@property(nonnull, strong) CLLocation *impl;

@end

@implementation CLWLocation

@dynamic coordinate, altitude, horizontalAccuracy, verticalAccuracy, course, speed, timestamp;

- (CLWLocationCoordinate2D)coordinate {
    CLWLocationCoordinate2D clwCoordinate = { _impl.coordinate.latitude, _impl.coordinate.longitude };
    return clwCoordinate;
}

- (CLWLocationDistance)altitude {
    return [_impl altitude];
}

- (CLWLocationAccuracy)horizontalAccuracy {
    return [_impl horizontalAccuracy];
}

- (CLWLocationAccuracy)verticalAccuracy {
    return [_impl verticalAccuracy];
}

- (CLWLocationDirection)course {
    return [_impl course];
}

- (CLWLocationSpeed)speed {
    return [_impl speed];
}

- (NSDate *)timestamp {
    return [_impl timestamp];
}

+ (BOOL)supportsSecureCoding {
    return [CLLocation supportsSecureCoding];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _impl = [[CLLocation alloc] initWithCoder:aDecoder];
    }
    return self;
}

- (instancetype)initWithCLLocation:(CLLocation *)location {
    assert(location != nil);
    self = [super init];
    if (self) {
        _impl = location;
    }
    return self;
}

- (instancetype)initWithLatitude:(CLWLocationDegrees)latitude
                       longitude:(CLWLocationDegrees)longitude
{
    self = [super init];
    if (self) {
        _impl = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    }
    return self;
}

- (instancetype)initWithCoordinate:(CLWLocationCoordinate2D)coordinate
                          altitude:(CLWLocationDistance)altitude
                horizontalAccuracy:(CLWLocationAccuracy)hAccuracy
                  verticalAccuracy:(CLWLocationAccuracy)vAccuracy
                         timestamp:(NSDate *)timestamp
{
    self = [super init];
    if (self) {
        CLLocationCoordinate2D clCoordinate = { coordinate.latitude, coordinate.longitude };
        _impl = [[CLLocation alloc] initWithCoordinate:clCoordinate altitude:altitude horizontalAccuracy:hAccuracy verticalAccuracy:vAccuracy timestamp:timestamp];
    }
    return self;
}

- (instancetype)initWithCoordinate:(CLWLocationCoordinate2D)coordinate
                          altitude:(CLWLocationDistance)altitude
                horizontalAccuracy:(CLWLocationAccuracy)hAccuracy
                  verticalAccuracy:(CLWLocationAccuracy)vAccuracy
                            course:(CLWLocationDirection)course
                             speed:(CLWLocationSpeed)speed
                         timestamp:(NSDate *)timestamp __OSX_AVAILABLE_STARTING(__MAC_10_7,__IPHONE_4_2)
{
    self = [super init];
    if (self) {
        CLLocationCoordinate2D clCoordinate = { coordinate.latitude, coordinate.longitude };
        _impl = [[CLLocation alloc] initWithCoordinate:clCoordinate altitude:altitude horizontalAccuracy:hAccuracy verticalAccuracy:vAccuracy course:course speed:speed timestamp:timestamp];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [_impl encodeWithCoder:aCoder];
}

- (CLWLocationDistance)getDistanceFrom:(const CLWLocation *)location __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_NA,__MAC_NA,__IPHONE_2_0,__IPHONE_3_2) __TVOS_PROHIBITED __WATCHOS_PROHIBITED {
    CLLocation *other = location->_impl;
    return [_impl getDistanceFrom:other];
}

- (CLWLocationDistance)distanceFromLocation:(const CLWLocation *)location __OSX_AVAILABLE_STARTING(__MAC_10_6,__IPHONE_3_2) {
    CLLocation *other = location->_impl;
    return [_impl distanceFromLocation:other];
}

- (id)copyWithZone:(NSZone *)zone {
    CLLocation *implCopy = [_impl copyWithZone:zone];
    return [[CLWLocation allocWithZone:zone] initWithCLLocation:implCopy];
}

+ (CLWLocationAccuracy)locationAccuracyBestForNavigation __OSX_AVAILABLE_STARTING(__MAC_10_7,__IPHONE_4_0) {
    return kCLLocationAccuracyBestForNavigation;
}

+ (CLWLocationAccuracy)locationAccuracyBest {
    return kCLLocationAccuracyBest;
}

+ (CLWLocationAccuracy)locationAccuracyNearestTenMeters {
    return kCLLocationAccuracyNearestTenMeters;
}

+ (CLWLocationAccuracy)locationAccuracyHundredMeters {
    return kCLLocationAccuracyHundredMeters;
}

+ (CLWLocationAccuracy)locationAccuracyKilometer {
    return kCLLocationAccuracyKilometer;
}

+ (CLWLocationAccuracy)locationAccuracyThreeKilometers {
    return kCLLocationAccuracyThreeKilometers;
}

@end

@interface CLWHeading()

@property(nonnull, strong) CLHeading *impl;

@end

@implementation CLWHeading

@dynamic magneticHeading, trueHeading, headingAccuracy, x, y, z, timestamp;

- (CLWLocationDirection)magneticHeading {
    return [_impl magneticHeading];
}

- (CLWLocationDirection)trueHeading {
    return [_impl trueHeading];
}

- (CLWLocationDirection)headingAccuracy {
    return [_impl headingAccuracy];
}

- (CLWHeadingComponentValue)x {
    return [_impl x];
}

- (CLWHeadingComponentValue)y {
    return [_impl y];
}

- (CLWHeadingComponentValue)z {
    return [_impl z];
}

- (NSDate *)timestamp {
    return [_impl timestamp];
}

+ (BOOL)supportsSecureCoding {
    return [CLHeading supportsSecureCoding];
}

- (nullable instancetype)init {
    self = [super init];
    if (self) {
        _impl = [[CLHeading alloc] init];
    }
    return self;
}

- (instancetype)initWithCLHeading:(CLHeading *)heading {
    self = [super init];
    if (self) {
        _impl = heading;
    }
    return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _impl = [[CLHeading alloc] initWithCoder:aDecoder];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [_impl encodeWithCoder:aCoder];
}

- (id)copyWithZone:(NSZone *)zone {
    CLHeading *implCopy = [_impl copyWithZone:zone];
    return [[CLWHeading allocWithZone:zone] initWithCLHeading:implCopy];
}

@end

@interface CLWLocationManager() <CLLocationManagerDelegate>

@property(nonatomic, strong) CLLocationManager *impl;

@end

@implementation CLWLocationManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        _impl = [[CLLocationManager alloc] init];
        _impl.delegate = self;
    }
    return self;
}

+ (BOOL)locationServicesEnabled {
    return [CLLocationManager locationServicesEnabled];
}

+ (BOOL)headingAvailable __OSX_AVAILABLE_STARTING(__MAC_10_7,__IPHONE_4_0) __TVOS_PROHIBITED __WATCHOS_PROHIBITED {
    return [CLLocationManager headingAvailable];
}

+ (BOOL)significantLocationChangeMonitoringAvailable __OSX_AVAILABLE_STARTING(__MAC_10_7,__IPHONE_4_0) __TVOS_PROHIBITED __WATCHOS_PROHIBITED {
    return  [CLLocationManager significantLocationChangeMonitoringAvailable];
}

+ (CLWAuthorizationStatus)authorizationStatus __OSX_AVAILABLE_STARTING(__MAC_10_7,__IPHONE_4_2) {
    return (CLWAuthorizationStatus)[CLLocationManager authorizationStatus];
}

@dynamic locationServicesEnabled;

- (BOOL)locationServicesEnabled __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_NA,__MAC_NA,__IPHONE_2_0,__IPHONE_4_0) __TVOS_PROHIBITED __WATCHOS_PROHIBITED {
    return [_impl locationServicesEnabled];
}

@dynamic activityType;
- (CLWActivityType)activityType __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_6_0) __TVOS_PROHIBITED __WATCHOS_PROHIBITED {
    return (CLWActivityType)[_impl activityType];
}
- (void)setActivityType:(CLWActivityType)activityType {
    [_impl setActivityType:(CLActivityType)activityType];
}

@dynamic distanceFilter;
- (CLWLocationDistance)distanceFilter {
    return [_impl distanceFilter];
}
-(void)setDistanceFilter:(CLWLocationDistance)distanceFilter {
    [_impl setDistanceFilter:distanceFilter];
}

@dynamic desiredAccuracy;
- (CLWLocationAccuracy) desiredAccuracy {
    return [_impl desiredAccuracy];
}
-(void)setDesiredAccuracy:(CLWLocationAccuracy)desiredAccuracy {
    [_impl setDesiredAccuracy:desiredAccuracy];
}

@dynamic pausesLocationUpdatesAutomatically;
- (BOOL)pausesLocationUpdatesAutomatically {
    return [_impl pausesLocationUpdatesAutomatically];
}
- (void)setPausesLocationUpdatesAutomatically:(BOOL)pausesLocationUpdatesAutomatically {
    [_impl pausesLocationUpdatesAutomatically];
}

@dynamic allowsBackgroundLocationUpdates;
- (BOOL)allowsBackgroundLocationUpdates {
    return [_impl allowsBackgroundLocationUpdates];
}
- (void)setAllowsBackgroundLocationUpdates:(BOOL)allowsBackgroundLocationUpdates {
    [_impl setAllowsBackgroundLocationUpdates:allowsBackgroundLocationUpdates];
}

@dynamic location;
- (CLWLocation *)location {
    CLLocation *implLocation = _impl.location;
    if (implLocation == nil) {
        return nil;
    } else {
        return [[CLWLocation alloc] initWithCLLocation:implLocation];
    }
}

@dynamic headingAvailable;
- (BOOL)isHeadingAvailable __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_NA,__MAC_NA,__IPHONE_3_0,__IPHONE_4_0) __TVOS_PROHIBITED __WATCHOS_PROHIBITED;
{
    return [_impl headingAvailable];
}

- (void)requestWhenInUseAuthorization __OSX_AVAILABLE_STARTING(__MAC_NA, __IPHONE_8_0)
{
    [_impl requestWhenInUseAuthorization];
}

- (void)requestAlwaysAuthorization __OSX_AVAILABLE_STARTING(__MAC_NA, __IPHONE_8_0) __TVOS_PROHIBITED
{
    [_impl requestAlwaysAuthorization];
}

- (void)startUpdatingLocation __TVOS_PROHIBITED
{
    [_impl startUpdatingLocation];
}

- (void)stopUpdatingLocation
{
    [_impl stopUpdatingLocation];
}

- (void)requestLocation __OSX_AVAILABLE_STARTING(__MAC_NA, __IPHONE_9_0)
{
    [_impl requestLocation];
}

- (void)startUpdatingHeading __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0) __TVOS_PROHIBITED __WATCHOS_PROHIBITED
{
    [_impl startUpdatingHeading];
}

- (void)stopUpdatingHeading __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0) __TVOS_PROHIBITED __WATCHOS_PROHIBITED
{
    [_impl stopUpdatingHeading];
}

- (void)dismissHeadingCalibrationDisplay __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0) __TVOS_PROHIBITED __WATCHOS_PROHIBITED
{
    [_impl dismissHeadingCalibrationDisplay];
}

- (void)allowDeferredLocationUpdatesUntilTraveled:(CLWLocationDistance)distance
                                          timeout:(NSTimeInterval)timeout __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_6_0) __TVOS_PROHIBITED __WATCHOS_PROHIBITED
{
    [_impl allowDeferredLocationUpdatesUntilTraveled:distance timeout:timeout];
}

- (void)disallowDeferredLocationUpdates __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_6_0) __TVOS_PROHIBITED __WATCHOS_PROHIBITED
{
    [_impl disallowDeferredLocationUpdates];
}

+ (BOOL)deferredLocationUpdatesAvailable __OSX_AVAILABLE_STARTING(__MAC_10_9,__IPHONE_6_0) __TVOS_PROHIBITED __WATCHOS_PROHIBITED
{
    return [CLLocationManager deferredLocationUpdatesAvailable];
}












- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_6, __MAC_NA, __IPHONE_2_0, __IPHONE_6_0) __TVOS_PROHIBITED __WATCHOS_PROHIBITED
{

    if([_delegate respondsToSelector:@selector(locationManager:didUpdateToLocation:fromLocation:)]) {
        CLWLocation *newLocationWrapped = nil;
        CLWLocation *oldLocationWrapped = nil;
        if (newLocation != nil) {
            newLocationWrapped = [[CLWLocation alloc] initWithCLLocation: newLocation];
        }

        if (oldLocation != nil) {
            oldLocationWrapped = [[CLWLocation alloc] initWithCLLocation: oldLocation];
        }

        [_delegate locationManager:self didUpdateToLocation:newLocationWrapped fromLocation:oldLocationWrapped];
    }
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations __OSX_AVAILABLE_STARTING(__MAC_10_9,__IPHONE_6_0)
{
    if([_delegate respondsToSelector:@selector(locationManager:didUpdateLocations:)]) {
        NSMutableArray<CLWLocation *> *clwLocations = [[NSMutableArray<CLWLocation *> alloc] initWithCapacity:locations.count];
        for (CLLocation *clLocation in locations) {
            CLWLocation *clwLocation = nil;
            if (clLocation != nil) {
                clwLocation = [[CLWLocation alloc] initWithCLLocation:clLocation];
            }

            [clwLocations addObject:clwLocation];
        }

        [_delegate locationManager:self didUpdateLocations:clwLocations];
    }
}

- (void)locationManager:(CLLocationManager *)manager
       didUpdateHeading:(CLHeading *)newHeading __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0) __TVOS_PROHIBITED __WATCHOS_PROHIBITED;
{
    if([_delegate respondsToSelector:@selector(locationManager:didUpdateHeading:)]) {
        [_delegate locationManager:self didUpdateHeading:[[CLWHeading alloc] initWithCLHeading: newHeading]];
    }
}

- (BOOL)locationManagerShouldDisplayHeadingCalibration:(CLLocationManager *)manager  __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0) __TVOS_PROHIBITED __WATCHOS_PROHIBITED
{
    if([_delegate respondsToSelector:@selector(locationManagerShouldDisplayHeadingCalibration:)]) {
        return [_delegate locationManagerShouldDisplayHeadingCalibration:self];
    } else {
        return false;
    }
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    if([_delegate respondsToSelector:@selector(locationManager:didFailWithError:)]) {
        [_delegate locationManager:self didFailWithError:error];
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status __OSX_AVAILABLE_STARTING(__MAC_10_7,__IPHONE_4_2)
{
    if([_delegate respondsToSelector:@selector(locationManager:didChangeAuthorizationStatus:)]) {
        [_delegate locationManager:self didChangeAuthorizationStatus:(CLWAuthorizationStatus)status];
    }
}

- (void)locationManagerDidPauseLocationUpdates:(CLLocationManager *)manager __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_6_0) __TVOS_PROHIBITED __WATCHOS_PROHIBITED
{
    if([_delegate respondsToSelector:@selector(locationManagerDidPauseLocationUpdates:)]) {
        [_delegate locationManagerDidPauseLocationUpdates:self];
    }
}

- (void)locationManagerDidResumeLocationUpdates:(CLLocationManager *)manager __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_6_0) __TVOS_PROHIBITED __WATCHOS_PROHIBITED
{
    if([_delegate respondsToSelector:@selector(locationManagerDidResumeLocationUpdates:)]) {
        [_delegate locationManagerDidResumeLocationUpdates:self];
    }
}

- (void)locationManager:(CLLocationManager *)manager
didFinishDeferredUpdatesWithError:(nullable NSError *)error __OSX_AVAILABLE_STARTING(__MAC_10_9,__IPHONE_6_0) __TVOS_PROHIBITED __WATCHOS_PROHIBITED
{
    if([_delegate respondsToSelector:@selector(locationManager:didFinishDeferredUpdatesWithError:)] ) {
        [_delegate locationManager:self didFinishDeferredUpdatesWithError:error];
    }
}

@end

@implementation CoreLocationWrapping

@end
