//
//  ViciPlugin.m
//  Vici
//
//  Created by Dave DeLong on 10/21/09.
//  Copyright 2009 Home. All rights reserved.
//

#import "ViciPlugin.h"

NSString * kViciPluginType				= @"kViciPluginType";
NSString * kViciPluginTypeMap			= @"kViciPluginTypeMap";
NSString * kViciPluginTypeGame			= @"kViciPluginTypeGame";
NSString * kViciPluginTypePlayer		= @"kViciPluginTypePlayer";

NSString * kViciPluginID				= @"kViciPluginID";
NSString * kViciPluginDisplayName		= @"kViciPluginDisplayName";

@implementation ViciPlugin

+ (NSDictionary *) pluginDescription {
	NSLog(@"ViciPlugin is an abstract class.  Implementation of +pluginDescription should be done in the subclass.");
	return nil;
}

- (void) configureWithManagedObjectContext:(NSManagedObjectContext *)context {
	NSLog(@"ViciPlugin is an abstract class.  Implementation of -configureWithManagedObjectContext: should be done in the subclass.");
	return;
}

@end
