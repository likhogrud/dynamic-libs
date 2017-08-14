//
//  Created by Nikolay Lihogrud on 18.03.17.
//  Copyright © 2017 Yandex LLC. All rights reserved.
//

#ifndef MapKitWrapping_h
#define MapKitWrapping_h

#import <Foundation/Foundation.h>
#import "CoreLocationWrapping.h"

typedef NS_ENUM(unsigned int, MKWDirectionsTransportType) {
    MKWDirectionsTransportTypeAutomobile = 1 << 0,
    MKWDirectionsTransportTypeWalking = 1 << 1,
    MKWDirectionsTransportTypeTransit NS_ENUM_AVAILABLE(10_11, 9_0) = 1 << 2, // Only supported for ETA calculations
    MKWDirectionsTransportTypeAny = 0x0FFFFFFF
} NS_ENUM_AVAILABLE(10_9, 7_0) __TVOS_AVAILABLE(9_2) __WATCHOS_PROHIBITED;

@interface MKWPlacemark : NSObject

@property (nonatomic, readonly) CLWLocationCoordinate2D coordinate;

@end

@interface MKWMapItem : NSObject

@property (nonatomic, readonly) MKWPlacemark * _Null_unspecified placemark;
@property (nonatomic, readonly) BOOL isCurrentLocation;

@end

@interface MKWDirectionsRequest : NSObject

@property (nonatomic, strong, nullable) MKWMapItem *source;
@property (nonatomic, strong, nullable) MKWMapItem *destination;
@property(assign, nonatomic) MKWDirectionsTransportType transportType NS_AVAILABLE(10_9, 7_0); // Default is MKDirectionsTransportTypeAny

- (instancetype _Nonnull)initWithContentsOfURL:(NSURL * _Null_unspecified)url NS_AVAILABLE(10_9, 6_0);
+ (BOOL)isDirectionsRequestURL:(NSURL * _Null_unspecified)url NS_AVAILABLE(10_9, 6_0);

@end

#endif /* MapKitWrapping_h */
