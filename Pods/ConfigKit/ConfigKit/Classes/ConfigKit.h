//
//  ConfigKit.h
//  ConfigKit
//
//  CREATED BY LUO YU ON 2016-09-13.
//  COPYRIGHT © 2016 LUO YU. ALL RIGHTS RESERVED.
//

#import <Foundation/Foundation.h>
#import <ConfigKit/NSBundle+ConfigKit.h>
#import <ConfigKit/NSString+ConfigKit.h>

FOUNDATION_EXPORT NSString *const LIB_CONFIGKIT_BUNDLE_ID;
FOUNDATION_EXPORT NSString *const NAME_CONF_SYSTEM_STYLE;

FOUNDATION_EXPORT NSString *const CONFIGKIT_LANG;
FOUNDATION_EXPORT NSString *const NOTIF_LANGUAGE_CHANGED;

// MARK: - CONFIGKIT

@interface ConfigKit : NSObject

/**
 target datetime
 */
@property (nonatomic, weak) NSDate *target;

/**
 shared instance

 @return shared instance of ConfigKit
 */
+ (instancetype)kit;

// MARL: STYLE

/**
 *  CONFIGURE SYSTEM STYLE
 */
- (void)systemStyle;

// MARK: LOCALE

/**
 *  LANGUAGES
 */
- (void)setLocale:(NSString *)localeName;

- (NSInteger)selectedLocaleIndex;

- (NSArray *)availableLanguages;

#pragma mark CHECK

- (BOOL)isFirstTimeRunApp;
- (void)appRunned;

#pragma mark - LIB'S CONFIGURATION READER

- (NSDictionary *)readConfigurationNamed:(NSString *)plistFilename andLibBundleIdentifier:(NSString *)libBundleID;

#pragma mark -

- (void)excuteInSimulator:(void (^)())blockSimulator inDevice:(void (^)())blockDevice;

// MARK: SOUND

- (void)playSoundWavFileNamed:(NSString *)soundName;

- (void)playSoundWavFileNamed:(NSString *)soundName inBundle:(NSBundle *)bundle;

@end
