//
//  Created by Nikolay Lihogrud on 14.08.17.
//  Copyright © 2017 Yandex LLC. All rights reserved.
//

#import "LazyYandexMetricaPush.h"
#import <YandexMobileMetricaPush/YandexMobileMetricaPush.h>
#import <dlfcn.h>

// Lib loading

static void *getLib() {
    static dispatch_once_t once;
    static void *dlopenResult;
    dispatch_once(&once, ^{
        NSString *frameworksPath = [[NSBundle mainBundle] privateFrameworksPath];
        NSString *dyLib = @"YandexMobileMetricaPush.framework/YandexMobileMetricaPush";
        NSString *path = [NSString stringWithFormat:@"%@/%@", frameworksPath, dyLib];
        dlopenResult = dlopen([path cStringUsingEncoding:NSASCIIStringEncoding], RTLD_LAZY);
        if (!dlopenResult) {
            assert(false);
        }
    });
    return dlopenResult;
}

static Class getYMPYandexMetricaPushClass() {
    static dispatch_once_t once;
    static Class class;
    dispatch_once(&once, ^{
        class = (__bridge Class)dlsym(getLib(), "OBJC_CLASS_$_YMPYandexMetricaPush");
        if (!class) {
            assert(false);
        }
    });
    return class;
}

@implementation LazyYandexMetricaPush

+ (void)setDeviceTokenFromData:(NSData *)data {
    [getYMPYandexMetricaPushClass() setDeviceTokenFromData: data];
}

@end
