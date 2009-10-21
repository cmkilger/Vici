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

- (void) configureWithManagedObjectContext:(NSManagedObjectContext *)context {
	
}

@end
