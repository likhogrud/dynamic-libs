//
//  Created by Nikolay Lihogrud on 11.08.17.
//  Copyright © 2017 Yandex LLC. All rights reserved.
//

#import "LazyDynamicLib.h"
#import <DynamicLib/DynamicLib.h>
#import <dlfcn.h>

// Lib loading

static void *getLib() {
    static dispatch_once_t once;
    static void *dlopenResult;
    dispatch_once(&once, ^{
        NSString *frameworksPath = [[NSBundle mainBundle] privateFrameworksPath];
        NSString *dyLib = @"DynamicLib.framework/DynamicLib";
        NSString *path = [NSString stringWithFormat:@"%@/%@", frameworksPath, dyLib];
        dlopenResult = dlopen([path cStringUsingEncoding:NSASCIIStringEncoding], RTLD_LAZY);
        if (!dlopenResult) {
            assert(false);
        }
    });
    return dlopenResult;
}

// Symbols Loading

static Class getSomeDynamicClass() {
    static dispatch_once_t once;
    static Class class;
    dispatch_once(&once, ^{
        class = (__bridge Class)dlsym(getLib(), "OBJC_CLASS_$__TtC10DynamicLib16SomeDynamicClass");;
        if (!class) {
            assert(false);
        }
    });
    return class;
}

typedef int (*SomeGlobalFuncPtr)();
static SomeGlobalFuncPtr getSomeGlobalFuncPtr() {
    static dispatch_once_t once;
    static SomeGlobalFuncPtr ptr;
    dispatch_once(&once, ^{
        ptr = dlsym(getLib(), "someGlobalFunc");
        if (!ptr) {
            assert(false);
        }
    });
    return ptr;
}

static int *getSomeGlobalVarPtr() {
    static dispatch_once_t once;
    static int *ptr;
    dispatch_once(&once, ^{
        ptr = (int *)dlsym(getLib(), "someGlobalVar");
        if (!ptr) {
            assert(false);
        }
    });
    return ptr;
}

static NSString * __autoreleasing *getSomeGlobalStringVarPtr() {
    static dispatch_once_t once;
    static NSString *__autoreleasing *ptr;
    dispatch_once(&once, ^{
        ptr = (NSString *__autoreleasing *)dlsym(getLib(), "someGlobalStringVar");;
        if (!ptr) {
            assert(false);
        }
    });
    return ptr;
}

// Wrappers

@interface LazySomeDynamicClass()
@property(nonatomic, strong) SomeDynamicClass *impl;
@end

@implementation LazySomeDynamicClass

- (instancetype)init
{
    self = [super init];
    if (self) {
        _impl = [(SomeDynamicClass *)[getSomeDynamicClass() alloc] init];
    }
    return self;
}

@dynamic someVar;
- (NSInteger)someVar {
    return self.impl.someVar;
}
- (void)setSomeVar:(NSInteger)someVar {
    self.impl.someVar = someVar;
}

- (void)someFunc {
    [self.impl someFunc];
}

+ (void)someClassFunc {
    [getSomeDynamicClass() someClassFunc];
}

@end

int lazySomeGlobalFunc() {
    return getSomeGlobalFuncPtr()();
}

int getLazySomeGlobalVar() {
    return *getSomeGlobalVarPtr();
}

void setLazySomeGlobalVar(int value) {
    *getSomeGlobalVarPtr() = value;
}

NSString * _Nonnull getLazySomeGlobalStringVar() {
    return *getSomeGlobalStringVarPtr();
}

