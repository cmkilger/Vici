//
//  ViciGameFactory.m
//  Vici
//
//  Created by Dave DeLong on 10/12/09.
//  Copyright 2009 Home. All rights reserved.
//

// The pattern for creating this singleton came from Peter Hosey's blog.
// http://boredzo.org/blog/archives/2009-06-17/doing-it-wrong

#import "ViciPluginManager.h"
#import "ViciCore.h"

static ViciPluginManager *sharedManager = nil;

@interface ViciPluginManager ()

- (void) clearPlugins;
- (void) findPlugins;
- (NSArray *) descriptionsOfPlugins:(NSArray *)plugins;

@end

@implementation ViciPluginManager

+ (void) initialize {
	//+initialize can get called multiple times, but we only want to create a single instance of ViciGameFactory
    if (!sharedManager && self == [ViciPluginManager class]) {
		//init will assign sharedInstance for us.
		sharedManager = [[ViciPluginManager alloc] init];
    }
}

+ (id) sharedManager {
    //Already set by +initialize.
    return sharedManager;
}

+ (id) allocWithZone:(NSZone *)zone {
    //Usually already set by +initialize.
    if (sharedManager) {
        //The caller expects to receive a new object, so implicitly retain it to balance out the caller's eventual release message.
        return [sharedManager retain];
    } else {
        //When not already set, +initialize is our caller—it's creating the shared instance. Let this go through.
        return [super allocWithZone:zone];
    }
}

- (id) init {
    //If sharedInstance is nil, +initialize is our caller, so initialize the instance.
    //Conversely, if it is not nil, release this instance (if it isn't the shared instance) and return the shared instance.
    if (!sharedManager) {
        if ((self = [super init])) {
            //Initialize the instance here.
			pluginDirectories = [[NSMutableSet alloc] init];
			gameTypes = [[NSMutableArray alloc] init];
			maps = [[NSMutableArray alloc] init];
			players = [[NSMutableArray alloc] init];
			[self findPlugins];
			
        }
		
        //Assign sharedInstance here so that we don't end up with multiple instances if a caller calls +alloc/-init without going through +sharedInstance.
        //This isn't foolproof, however (especially if you involve threads). The only correct way to get an instance of a singleton is through the +sharedInstance method.
        sharedManager = self;
    } else if (self != sharedManager) {
        [self release];
        self = sharedManager;
    }
	
    return self;
}

- (void) addPluginDirectory:(NSString *)path {
	[pluginDirectories addObject:[path stringByStandardizingPath]];
	[self findPlugins];
}

- (void) clearPlugins {
	for (NSBundle * plugin in gameTypes) {
		[plugin unload];
	}
	for (NSBundle * plugin in maps) {
		[plugin unload];
	}
	for (NSBundle * plugin in players) {
		[plugin unload];
	}
	[gameTypes removeAllObjects];
	[maps removeAllObjects];
	[players removeAllObjects];
}

- (void) findPlugins {
	[self clearPlugins];
	
	NSString * internalPluginsDirectory = [[NSBundle mainBundle] builtInPlugInsPath];
	NSError * error = nil;
	NSArray * allPlugins = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:internalPluginsDirectory error:&error];
	if (error != nil) { 
		NSLog(@"%@", error);
		/* something bad happened */
	}
	
	if (!allPlugins)
		allPlugins = [NSArray array];
	
	for (NSString * path in pluginDirectories) {
		NSError * error = nil;
		allPlugins = [allPlugins arrayByAddingObjectsFromArray:[[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:&error]];
		if (error != nil) { 
			NSLog(@"%@", error);
			/* something bad happened */
		}
	}
	
	for (NSString * foundPlugin in allPlugins) {
		NSBundle * plugin = [NSBundle bundleWithPath:foundPlugin];
		if (plugin != nil) {
			//this url points to a valid plugin
			[plugin load];
			
			//do some more validation on the bundle
			Class principalClass = [plugin principalClass];
			NSDictionary * pluginDescription = [principalClass pluginDescription];
			NSString * pluginType = [pluginDescription objectForKey:kViciPluginType];
			
			if ([pluginType isEqualToString:kViciPluginTypeGame]) {
				[gameTypes addObject:plugin];
			} else if ([pluginType isEqualToString:kViciPluginTypeMap]) {
				[maps addObject:plugin];
			} else if ([pluginType isEqualToString:kViciPluginTypePlayer]) {
				[players addObject:plugin];
			} else {
				//the plugin is neither a game plugin, player plugin nor a map plugin.  skip it.
				[plugin unload];
			}
		}
	}
}

- (NSArray *) descriptionsOfPlugins:(NSArray *)plugins {
	NSMutableArray * types = [NSMutableArray array];
	for (NSBundle * plugin in plugins) {
		Class principalClass = [plugin principalClass];
		[types addObject:[principalClass pluginDescription]];
	}
	return types;
}

- (NSArray *) availableGameTypes {
	return [self descriptionsOfPlugins:gameTypes];
}

- (NSArray *) availableMaps {
	return [self descriptionsOfPlugins:maps];
}

- (NSArray *) availablePlayers {
	return [self descriptionsOfPlugins:players];
}

@end
