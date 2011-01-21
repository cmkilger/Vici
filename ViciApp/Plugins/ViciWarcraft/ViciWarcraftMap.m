//
//  ViciWarcraftMap.m
//  Vici
//
//  Created by Cory Kilger on 10/21/09.
//  Copyright 2009 Cory Kilger. All rights reserved.
//

#import "ViciWarcraftMap.h"


@implementation ViciWarcraftMap

+ (NSDictionary *) pluginDescription {
	NSBundle * pluginBundle = [NSBundle bundleForClass:self];
	if (pluginBundle == nil) { return nil; }
	
	NSString * localizedName = NSLocalizedStringWithDefaultValue(kViciPluginDisplayName, nil, pluginBundle, @"Warcraft", nil);
	
	return [NSDictionary dictionaryWithObjectsAndKeys:kViciPluginTypeMap, kViciPluginType,
			[pluginBundle bundleIdentifier], kViciPluginID,
			localizedName, kViciPluginDisplayName,
			nil];
}

- (id) init {
	if (self = [super init]) {
		countriesCache = [[NSMutableDictionary alloc] init];
		continentsCache = [[NSMutableDictionary alloc] init];
	}
	return self;
}

- (void) dealloc {
	[countriesCache release];
	[continentsCache release];
	[super dealloc];
}

- (void) configureWithGame:(Game *)game {
	
}

@end
