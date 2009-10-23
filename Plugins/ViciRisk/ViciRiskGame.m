//
//  ViciRiskGame.m
//  Vici
//
//  Created by Dave DeLong on 10/19/09.
//  Copyright 2009 Home. All rights reserved.
//

#import "ViciRiskGame.h"

@implementation ViciRiskGame

+ (NSDictionary *) pluginDescription {
	NSBundle * pluginBundle = [NSBundle bundleForClass:self];
	if (pluginBundle == nil) { return nil; }
	
	NSString * localizedName = NSLocalizedStringWithDefaultValue(kViciPluginDisplayName, nil, pluginBundle, @"Classic Risk", nil);
	
	return [NSDictionary dictionaryWithObjectsAndKeys:kViciPluginTypeMap, kViciPluginType,
			[pluginBundle bundleIdentifier], kViciPluginID,
			localizedName, kViciPluginDisplayName,
			nil];
}

- (id) init {
	if (self = [super init]) {
		
	}
	return self;
}

- (void) configureWithGame:(Game *)game {
	
}

- (void) gameWillBegin:(Game *)game {
	NSManagedObjectContext * context = [game managedObjectContext];
	
	NSUInteger numberOfPlayers = [[[game players] count] unsignedIntegerValue];
	//2 players => 40 armies, 3 => 35, 4 => 30, 5 => 25, etc
	NSUInteger numberOfArmiesPerPlayer = 40 - ((numberOfPlayers-2)*5);
	
	//create the to-be-placed armies for each player
	for (Player * player in [game players]) {
		for (NSUInteger i = 0; i < numberOfArmiesPerPlayer; ++i) {
			Army * newArmy = [[Army alloc] initWithManagedObjectContext:context];
			//if an army's country is nil, it means it hasn't been placed yet
			[newArmy setCountry:nil];
			[player addArmiesObject:newArmy];
			[newArmy release];
		}
	}
}

@end
