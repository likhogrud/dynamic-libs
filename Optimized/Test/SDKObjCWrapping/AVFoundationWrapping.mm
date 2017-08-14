//
//  Created by Nikolay Lihogrud on 18.03.17.
//  Copyright © 2017 Yandex LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "AVFoundationWrapping.h"

NSString *AVWAudioSessionInterruptionTypeKey NS_AVAILABLE_IOS(6_0) = AVWAudioSessionInterruptionTypeKey;
NSString *AVWAudioSessionInterruptionOptionKey NS_AVAILABLE_IOS(6_0) = AVAudioSessionInterruptionOptionKey;
NSString *AVWAudioSessionRouteChangeReasonKey NS_AVAILABLE_IOS(6_0) = AVAudioSessionRouteChangeReasonKey;
NSString *AVWAudioSessionRouteChangePreviousRouteKey NS_AVAILABLE_IOS(6_0) = AVAudioSessionRouteChangePreviousRouteKey;
NSString *AVWAudioSessionSilenceSecondaryAudioHintTypeKey NS_AVAILABLE_IOS(8_0) = AVAudioSessionSilenceSecondaryAudioHintTypeKey;
NSString *AVWAudioSessionCategoryAmbient = AVAudioSessionCategoryAmbient;
NSString *AVWAudioSessionCategorySoloAmbient = AVAudioSessionCategorySoloAmbient;
NSString *AVWAudioSessionCategoryPlayback = AVAudioSessionCategoryPlayback;
NSString *AVWAudioSessionCategoryRecord = AVAudioSessionCategoryRecord;
NSString *AVWAudioSessionCategoryPlayAndRecord = AVAudioSessionCategoryPlayAndRecord;
NSString *AVWAudioSessionCategoryAudioProcessing NS_DEPRECATED_IOS(3_0, 10_0) __TVOS_PROHIBITED __WATCHOS_PROHIBITED = AVAudioSessionCategoryAudioProcessing;


NSString *AVWPlayerItemTimeJumpedNotification			 NS_AVAILABLE(10_7, 5_0) = AVPlayerItemTimeJumpedNotification;
NSString *AVWPlayerItemDidPlayToEndTimeNotification      NS_AVAILABLE(10_7, 4_0) = AVPlayerItemDidPlayToEndTimeNotification;
NSString *AVWPlayerItemFailedToPlayToEndTimeNotification NS_AVAILABLE(10_7, 4_3) = AVPlayerItemFailedToPlayToEndTimeNotification;
NSString *AVWPlayerItemPlaybackStalledNotification       NS_AVAILABLE(10_9, 6_0) = AVPlayerItemPlaybackStalledNotification;
NSString *AVWPlayerItemNewAccessLogEntryNotification	 NS_AVAILABLE(10_9, 6_0) = AVPlayerItemNewAccessLogEntryNotification;
NSString *AVWPlayerItemNewErrorLogEntryNotification		 NS_AVAILABLE(10_9, 6_0) = AVPlayerItemNewErrorLogEntryNotification;

// notification userInfo key                                                                    type
extern NSString *AVWPlayerItemFailedToPlayToEndTimeErrorKey     NS_AVAILABLE(10_7, 4_3);   // NSError

@interface AVWAudioSession()

@property(nonnull, strong) AVAudioSession *impl;

@end

@implementation AVWAudioSession

@dynamic category;
- (NSString * _Nonnull)category {
    return _impl.category;
}

+ (AVWAudioSession*)sharedInstance {
    static dispatch_once_t token = 0;
    __strong static id _sharedObject = nil;

    dispatch_once(&token, ^{
        _sharedObject = [[AVWAudioSession alloc] initWithAVAudioSession:[AVAudioSession sharedInstance]];
    });

    return _sharedObject;
}

- (instancetype)initWithAVAudioSession:(AVAudioSession *)session {
    self = [super init];
    if (self) {
        _impl = session;
    }
    return self;
}

- (BOOL)setActive:(BOOL)active error:(NSError **)outError {
    return [_impl setActive:active error:outError];
}

- (BOOL)setActive:(BOOL)active withOptions:(AVWAudioSessionSetActiveOptions)options error:(NSError **)outError NS_AVAILABLE_IOS(6_0)
{
    return [_impl setActive:active withOptions:(AVAudioSessionSetActiveOptions)options error:outError];
}

- (BOOL)setCategory:(NSString *)category error:(NSError **)outError {
    return [_impl setCategory:category error:outError];
}

- (BOOL)setCategory:(NSString *)category withOptions:(AVWAudioSessionCategoryOptions)options error:(NSError **)outError NS_AVAILABLE_IOS(6_0)
{
    return [_impl setCategory:category withOptions:(AVAudioSessionCategoryOptions)options error:outError];
}

- (BOOL)setCategory:(NSString *)category mode:(NSString *)mode options:(AVWAudioSessionCategoryOptions)options error:(NSError **)outError NS_AVAILABLE_IOS(10_0)
{
    return [_impl setCategory:category mode:mode options:(AVAudioSessionCategoryOptions)options error:outError];
}

- (AVWAudioSessionRecordPermission)recordPermission NS_AVAILABLE_IOS(8_0) __TVOS_PROHIBITED __WATCHOS_PROHIBITED {
    return [_impl recordPermission];
}

- (BOOL)overrideOutputAudioPort:(AVWAudioSessionPortOverride)portOverride  error:(NSError **)outError NS_AVAILABLE_IOS(6_0) {
    return [_impl overrideOutputAudioPort:(AVAudioSessionPortOverride)(portOverride) error:outError];
}

- (void)requestRecordPermission:(PermissionBlock)response NS_AVAILABLE_IOS(7_0) __TVOS_PROHIBITED __WATCHOS_PROHIBITED {
    [_impl requestRecordPermission:response];
}

@end

@interface AVWAsset()

@property(nonnull, strong) AVAsset *impl;

@end

@implementation AVWAsset

- (instancetype)initWithAVAsset:(AVAsset *)asset {
    self = [super init];
    if (self) {
        _impl = asset;
    }
    return self;
}

- (instancetype _Nonnull)initWithURL:(NSURL * _Nonnull)URL {
    self = [super init];
    if (self) {
        _impl = [AVAsset assetWithURL:URL];
    }
    return self;
}

- (AVWKeyValueStatus)statusOfValueForKey:(NSString *)key error:(NSError * _Nullable * _Nullable)outError {
    return (AVWKeyValueStatus)[_impl statusOfValueForKey:key error:outError];
}

- (void)loadValuesAsynchronouslyForKeys:(NSArray<NSString *> *)keys completionHandler:(nullable void (^)(void))handler {
    [_impl loadValuesAsynchronouslyForKeys:keys completionHandler:handler];
}

- (void)cancelLoading {
    [_impl cancelLoading];
}

@end

@interface AVWPlayerItem()

@property(nonnull, strong) AVPlayerItem *impl;

@end

@implementation AVWPlayerItem

@dynamic asset;
- (AVWAsset *)asset {
    return [[AVWAsset alloc] initWithAVAsset:_impl.asset];
}

- (instancetype _Nonnull)initWithAVPlayerItem:(AVPlayerItem *)item {
    self = [super init];
    if (self) {
        _impl = item;
    }
    return self;
}

- (instancetype _Nonnull)initWithAsset:(AVWAsset *)asset {
    self = [super init];
    if (self) {
        _impl = [[AVPlayerItem alloc] initWithAsset: asset.impl];
    }
    return self;
}

- (id)getRaw {
    return _impl;
}

@end

@interface AVWQueuePlayer()
    
@property(nonnull, strong) AVQueuePlayer *impl;
    
@end

@implementation AVWQueuePlayer

@dynamic status;
- (AVWPlayerStatus)status {
    return (AVWPlayerStatus)_impl.status;
}

- (instancetype _Nonnull)initWithItems:(NSArray<AVWPlayerItem *> *)items {
    self = [super init];
    if (self) {
        NSMutableArray<AVPlayerItem *> *implItems = [[NSMutableArray<AVPlayerItem *> alloc] initWithCapacity:items.count];
        for (AVWPlayerItem *wrappedItem in items) {
            [implItems addObject:wrappedItem.impl];
        }

        _impl = [[AVQueuePlayer alloc] initWithItems:implItems];
    }
    return self;
}

- (NSArray<AVWPlayerItem *> *)items {
    NSArray<AVPlayerItem *> *implItems = _impl.items;
    NSMutableArray<AVWPlayerItem *> *wrappedItems = [[NSMutableArray<AVWPlayerItem *> alloc] initWithCapacity:implItems.count];
    for (AVPlayerItem *implItem in implItems) {
        [wrappedItems addObject:[[AVWPlayerItem alloc] initWithAVPlayerItem:implItem]];
    }

    return wrappedItems;
}

- (BOOL)canInsertItem:(AVWPlayerItem *)item afterItem:(nullable AVWPlayerItem *)afterItem {
    return [_impl canInsertItem:item.impl afterItem:afterItem.impl];
}

- (void)insertItem:(AVWPlayerItem *)item afterItem:(nullable AVWPlayerItem *)afterItem {
    [_impl insertItem:item.impl afterItem:afterItem.impl];
}

- (void)removeAllItems {
    [_impl removeAllItems];
}

- (void)play {
    [_impl play];
}
- (void)pause {
    [_impl pause];
}

@end
