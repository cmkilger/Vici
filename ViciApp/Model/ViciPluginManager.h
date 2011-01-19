//
//  ViciGameFactory.h
//  Vici
//
//  Created by Dave DeLong on 10/12/09.
//  Copyright 2009 Home. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ViciPluginManager : NSObject {
	NSMutableSet * pluginDirectories;
	NSMutableArray * gameTypes;
	NSMutableArray * maps;
	NSMutableArray * players;
}

+ (ViciPluginManager *) sharedManager;

- (void) addPluginDirectory:(NSString *)path;

#pragma mark -

/**
 return an array of NSDictionaries.  Each NSDictionary should have at least three keys:
 kViciPluginType - kViciPluginTypeGame.
 kViciPluginID - a reverse-DNS-style string uniquely identifying the plugin.  Example: edu.byu.cocoaheads.Game.ClassicRisk
 kViciPluginDisplayName - a localized string for displaying to the user.  Example: Classic Risk
 */
- (NSArray *) availableGameTypes;

/**
 return an array of NSDictionaries.  Each NSDictionary should have at least three keys:
 kViciPluginType - kViciPluginTypeMap.
 kViciPluginID - a reverse-DNS-style string uniquely identifying the plugin.  Example: edu.byu.cocoaheads.Map.Risk
 kViciPluginDisplayName - a localized string for displaying to the user.  Example: Risk
 */
- (NSArray *) availableMaps;

/**
 return an array of NSDictionaries.  Each NSDictionary should have at least three keys:
 kViciPluginType - kViciPluginTypePlayer.
 kViciPluginID - a reverse-DNS-style string uniquely identifying the plugin.  Example: edu.byu.cocoaheads.Player.Human
 kViciPluginDisplayName - a localized string for displaying to the user.  Example: Human
 */
- (NSArray *) availablePlayers;

@end
