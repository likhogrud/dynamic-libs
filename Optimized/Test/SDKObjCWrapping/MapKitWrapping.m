//
//  Created by Nikolay Lihogrud on 18.03.17.
//  Copyright © 2017 Yandex LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "MapKitWrapping.h"

@interface MKWPlacemark()

@property(nonnull, strong) MKPlacemark *impl;

@end

@implementation MKWPlacemark

@dynamic coordinate;
- (CLWLocationCoordinate2D)coordinate {
    CLLocationCoordinate2D implCoordinate = _impl.coordinate;
    CLWLocationCoordinate2D wrappedCoordinate = { implCoordinate.latitude, implCoordinate.longitude };
    return wrappedCoordinate;
}

- (instancetype)initWithMKPlacemark:(MKPlacemark *)placemark {
    self = [super init];
    if (self) {
        _impl = placemark;
    }
    return self;
}

@end

@interface MKWMapItem()

@property(nonnull, strong) MKMapItem *impl;

@end

@implementation MKWMapItem

@dynamic isCurrentLocation;
- (BOOL)isCurrentLocation {
    return _impl.isCurrentLocation;
}

@dynamic placemark;
- (MKWPlacemark *)placemark {
    return [[MKWPlacemark alloc] initWithMKPlacemark:_impl.placemark];
}

- (instancetype)initWithMKMapItem:(MKMapItem *)item {
    self = [super init];
    if (self) {
        _impl = item;
    }
    return self;
}

@end

@interface MKWDirectionsRequest()

@property(nonnull, strong) MKDirectionsRequest *impl;

@end

@implementation MKWDirectionsRequest

@dynamic source;
- (MKWMapItem *)source {
    return [[MKWMapItem alloc] initWithMKMapItem:_impl.source];
}

@dynamic destination;
- (MKWMapItem *)destination {
    return [[MKWMapItem alloc] initWithMKMapItem:_impl.destination];
}

@dynamic transportType;
- (MKWDirectionsTransportType)transportType NS_AVAILABLE(10_9, 7_0) {
    return (MKWDirectionsTransportType)[_impl transportType];
}
- (void)setTransportType:(MKWDirectionsTransportType)transportType {
    [_impl setTransportType:(MKDirectionsTransportType)transportType];
}

- (instancetype)initWithContentsOfURL:(NSURL *)url NS_AVAILABLE(10_9, 6_0) {
    self = [super init];
    if (self) {
        _impl = [[MKDirectionsRequest alloc] initWithContentsOfURL:url];
    }
    return self;
}

+ (BOOL)isDirectionsRequestURL:(NSURL *)url NS_AVAILABLE(10_9, 6_0) {
    return [MKDirectionsRequest isDirectionsRequestURL:url];
}

@end
