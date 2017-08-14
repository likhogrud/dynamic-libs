//
//  Created by Nikolay Lihogrud on 14.08.17.
//  Copyright © 2017 Yandex LLC. All rights reserved.
//

#import "LazyYandexMetrica.h"
#import <YandexMobileMetrica/YandexMobileMetrica.h>
#import <dlfcn.h>

// Lib loading

static void *getLib() {
    static dispatch_once_t once;
    static void *dlopenResult;
    dispatch_once(&once, ^{
        NSString *frameworksPath = [[NSBundle mainBundle] privateFrameworksPath];
        NSString *dyLib = @"YandexMobileMetrica.framework/YandexMobileMetrica";
        NSString *path = [NSString stringWithFormat:@"%@/%@", frameworksPath, dyLib];
        dlopenResult = dlopen([path cStringUsingEncoding:NSASCIIStringEncoding], RTLD_LAZY);
        if (!dlopenResult) {
            assert(false);
        }
    });
    return dlopenResult;
}

static Class getYMMYandexMetricaClass() {
    static dispatch_once_t once;
    static Class class;
    dispatch_once(&once, ^{
        class = (__bridge Class)dlsym(getLib(), "OBJC_CLASS_$_YMMYandexMetrica");
        if (!class) {
            assert(false);
        }
    });
    return class;
}

@implementation LazyYandexMetrica

+ (void)activateWithApiKey:(NSString *)apiKey {
    [getYMMYandexMetricaClass() activateWithApiKey: apiKey];
}

@end
