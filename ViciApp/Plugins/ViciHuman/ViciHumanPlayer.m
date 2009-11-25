//
//  ViciHumanPlayer.m
//  Vici
//
//  Created by Cory Kilger on 11/17/09.
//  Copyright 2009 Cory Kilger. All rights reserved.
//

#import "ViciHumanPlayer.h"


@implementation ViciHumanPlayer

+ (NSDictionary *) pluginDescription {
	NSBundle * pluginBundle = [NSBundle bundleForClass:self];
	if (pluginBundle == nil) { return nil; }
	
	NSString * localizedName = NSLocalizedStringWithDefaultValue(kViciPluginDisplayName, nil, pluginBundle, @"Human", nil);
	
	return [NSDictionary dictionaryWithObjectsAndKeys:kViciPluginTypePlayer, kViciPluginType,
			[pluginBundle bundleIdentifier], kViciPluginID,
			localizedName, kViciPluginDisplayName,
			nil];
}

- (void) configureWithGame:(Game *)game {}

//! The human player does nothing in the -playRound method, since all decisions are made in the human's brain and are communicated via the user interface
- (void) playRound:(Round *)aRound inGameEngine:(ViciGameEngine *)game {}

@end
