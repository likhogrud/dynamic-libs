//
//  Created by Nikolay Lihogrud on 18.03.17.
//  Copyright © 2017 Yandex LLC. All rights reserved.
//

#ifndef AVFoundationWrapping_h
#define AVFoundationWrapping_h

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSUInteger, AVWAudioSessionSetActiveOptions)
{
    AVWAudioSessionSetActiveOptionNotifyOthersOnDeactivation = 1
} NS_AVAILABLE_IOS(6_0);

typedef NS_OPTIONS(NSUInteger, AVWAudioSessionCategoryOptions)
{
    /* MixWithOthers is only valid with AVAudioSessionCategoryPlayAndRecord, AVAudioSessionCategoryPlayback, and  AVAudioSessionCategoryMultiRoute */
    AVWAudioSessionCategoryOptionMixWithOthers			= 0x1,
    /* DuckOthers is only valid with AVAudioSessionCategoryAmbient, AVAudioSessionCategoryPlayAndRecord, AVAudioSessionCategoryPlayback, and AVAudioSessionCategoryMultiRoute */
    AVWAudioSessionCategoryOptionDuckOthers				= 0x2,
    /* AllowBluetooth is only valid with AVAudioSessionCategoryRecord and AVAudioSessionCategoryPlayAndRecord */
    AVWAudioSessionCategoryOptionAllowBluetooth	__TVOS_PROHIBITED __WATCHOS_PROHIBITED		= 0x4,
    /* DefaultToSpeaker is only valid with AVAudioSessionCategoryPlayAndRecord */
    AVWAudioSessionCategoryOptionDefaultToSpeaker __TVOS_PROHIBITED __WATCHOS_PROHIBITED		= 0x8,
    /* InterruptSpokenAudioAndMixWithOthers is only valid with AVAudioSessionCategoryPlayAndRecord, AVAudioSessionCategoryPlayback, and AVAudioSessionCategoryMultiRoute */
    AVWAudioSessionCategoryOptionInterruptSpokenAudioAndMixWithOthers NS_AVAILABLE_IOS(9_0) 	= 0x11,
    /* AllowBluetoothA2DP is only valid with AVAudioSessionCategoryPlayAndRecord */
    AVWAudioSessionCategoryOptionAllowBluetoothA2DP NS_AVAILABLE_IOS(10_0) = 0x20,
    /* AllowAirPlay is only valid with AVAudioSessionCategoryPlayAndRecord */
    AVWAudioSessionCategoryOptionAllowAirPlay NS_AVAILABLE_IOS(10_0) __WATCHOS_PROHIBITED = 0x40,
} NS_AVAILABLE_IOS(6_0);

typedef NS_ENUM(NSUInteger, AVWAudioSessionPortOverride)
{
    AVWAudioSessionPortOverrideNone    = 0,
    AVWAudioSessionPortOverrideSpeaker __TVOS_PROHIBITED __WATCHOS_PROHIBITED = 'spkr'
} NS_AVAILABLE_IOS(6_0);

typedef NS_OPTIONS(NSUInteger, AVWAudioSessionRecordPermission)
{
    AVWAudioSessionRecordPermissionUndetermined		= 'undt',
    AVWAudioSessionRecordPermissionDenied			= 'deny',
    AVWAudioSessionRecordPermissionGranted			= 'grnt'
} NS_AVAILABLE_IOS(8_0) __TVOS_PROHIBITED __WATCHOS_PROHIBITED;

typedef NS_ENUM(NSInteger, AVWKeyValueStatus) {
    AVWKeyValueStatusUnknown,
    AVWKeyValueStatusLoading,
    AVWKeyValueStatusLoaded,
    AVWKeyValueStatusFailed,
    AVWKeyValueStatusCancelled
};

typedef NS_ENUM(NSInteger, AVWPlayerStatus) {
    AVWPlayerStatusUnknown,
    AVWPlayerStatusReadyToPlay,
    AVWPlayerStatusFailed
};


extern NSString *AVWAudioSessionInterruptionTypeKey NS_AVAILABLE_IOS(6_0);
/* Only present for end interruption events.  Value is of type AVAudioSessionInterruptionOptions.*/
extern NSString *AVWAudioSessionInterruptionOptionKey NS_AVAILABLE_IOS(6_0);

/* keys for AVAudioSessionRouteChangeNotification */
/* value is an NSNumber representing an AVAudioSessionRouteChangeReason */
extern NSString *AVWAudioSessionRouteChangeReasonKey NS_AVAILABLE_IOS(6_0);
/* value is AVAudioSessionRouteDescription * */
extern NSString *AVWAudioSessionRouteChangePreviousRouteKey NS_AVAILABLE_IOS(6_0);

/* keys for AVAudioSessionSilenceSecondaryAudioHintNotification */
/* value is an NSNumber representing an AVAudioSessionSilenceSecondaryAudioHintType */
extern NSString *AVWAudioSessionSilenceSecondaryAudioHintTypeKey NS_AVAILABLE_IOS(8_0);

/*  Use this category for background sounds such as rain, car engine noise, etc.
 Mixes with other music. */
extern NSString *AVWAudioSessionCategoryAmbient;

/*  Use this category for background sounds.  Other music will stop playing. */
extern NSString *AVWAudioSessionCategorySoloAmbient;

/* Use this category for music tracks.*/
extern NSString *AVWAudioSessionCategoryPlayback;

/*  Use this category when recording audio. */
extern NSString *AVWAudioSessionCategoryRecord;

/*  Use this category when recording and playing back audio. */
extern NSString *AVWAudioSessionCategoryPlayAndRecord;

/*  Use this category when using a hardware codec or signal processor while
 not playing or recording audio. */
extern NSString *AVWAudioSessionCategoryAudioProcessing NS_DEPRECATED_IOS(3_0, 10_0) __TVOS_PROHIBITED __WATCHOS_PROHIBITED;

extern NSString *AVWPlayerItemTimeJumpedNotification			 NS_AVAILABLE(10_7, 5_0);	// the item's current time has changed discontinuously
extern NSString *AVWPlayerItemDidPlayToEndTimeNotification      NS_AVAILABLE(10_7, 4_0);   // item has played to its end time
extern NSString *AVWPlayerItemFailedToPlayToEndTimeNotification NS_AVAILABLE(10_7, 4_3);   // item has failed to play to its end time
extern NSString *AVWPlayerItemPlaybackStalledNotification       NS_AVAILABLE(10_9, 6_0);    // media did not arrive in time to continue playback
extern NSString *AVWPlayerItemNewAccessLogEntryNotification	 NS_AVAILABLE(10_9, 6_0);	// a new access log entry has been added
extern NSString *AVWPlayerItemNewErrorLogEntryNotification		 NS_AVAILABLE(10_9, 6_0);	// a new error log entry has been added

// notification userInfo key                                                                    type
extern NSString *AVWPlayerItemFailedToPlayToEndTimeErrorKey     NS_AVAILABLE(10_7, 4_3);   // NSError

@interface AVWAudioSession : NSObject

@property(readonly) NSString * _Nonnull category;

+ (AVWAudioSession* _Nonnull)sharedInstance;

- (BOOL)setActive:(BOOL)active error:(NSError **)outError;
- (BOOL)setActive:(BOOL)active withOptions:(AVWAudioSessionSetActiveOptions)options error:(NSError **)outError NS_AVAILABLE_IOS(6_0);

- (BOOL)setCategory:(NSString *)category error:(NSError **)outError;
- (BOOL)setCategory:(NSString *)category withOptions:(AVWAudioSessionCategoryOptions)options error:(NSError **)outError NS_AVAILABLE_IOS(6_0);
/* set session category and mode with options */
- (BOOL)setCategory:(NSString *)category mode:(NSString *)mode options:(AVWAudioSessionCategoryOptions)options error:(NSError **)outError NS_AVAILABLE_IOS(10_0);

- (AVWAudioSessionRecordPermission)recordPermission NS_AVAILABLE_IOS(8_0) __TVOS_PROHIBITED __WATCHOS_PROHIBITED;

- (BOOL)overrideOutputAudioPort:(AVWAudioSessionPortOverride)portOverride  error:(NSError **)outError NS_AVAILABLE_IOS(6_0);

typedef void (^PermissionBlock)(BOOL granted);

- (void)requestRecordPermission:(PermissionBlock)response NS_AVAILABLE_IOS(7_0) __TVOS_PROHIBITED __WATCHOS_PROHIBITED;

@end

@interface AVWAsset : NSObject <NSCopying>

- (instancetype _Nonnull)initWithURL:(NSURL * _Nonnull)URL;

- (AVWKeyValueStatus)statusOfValueForKey:(NSString *)key error:(NSError * _Nullable * _Nullable)outError;
- (void)loadValuesAsynchronouslyForKeys:(NSArray<NSString *> *)keys completionHandler:(nullable void (^)(void))handler;

- (void)cancelLoading;

@end

@interface AVWPlayerItem : NSObject <NSCopying>

@property (nonatomic, readonly) AVWAsset *asset;

- (instancetype _Nonnull)initWithAsset:(AVWAsset *)asset;
- (id)getRaw;

@end

@interface AVWQueuePlayer : NSObject

@property (nonatomic, readonly) AVWPlayerStatus status;

- (instancetype _Nonnull)initWithItems:(NSArray<AVWPlayerItem *> *)items;

- (NSArray<AVWPlayerItem *> *)items;

- (BOOL)canInsertItem:(AVWPlayerItem *)item afterItem:(nullable AVWPlayerItem *)afterItem;
- (void)insertItem:(AVWPlayerItem *)item afterItem:(nullable AVWPlayerItem *)afterItem;

- (void)removeAllItems;

- (void)play;
- (void)pause;

@end

NS_ASSUME_NONNULL_END

#endif /* AVFoundationWrapping_h */
