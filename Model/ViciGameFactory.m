//
//  ViciGameFactory.m
//  Vici
//
//  Created by Dave DeLong on 10/12/09.
//  Copyright 2009 Home. All rights reserved.
//

// The pattern for creating this singleton came from Peter Hosey's blog.
// http://boredzo.org/blog/archives/2009-06-17/doing-it-wrong

#import "ViciGameFactory.h"
#import <dispatch/dispatch.h>

static NSString * kViciGameTypeID = @"kViciGameTypeID";
static NSString * kViciGameTypeDisplayName = @"kViciGameTypeDisplayName";
static NSString * kViciMapID = @"kViciMapID";
static NSString * kViciMapDisplayName = @"kViciMapDisplayName";

static ViciGameFactory *sharedFactory = nil;

@interface ViciGameFactory ()

- (void) findPlugins;

@end


@implementation ViciGameFactory

+ (void) initialize {
	//+initialize can get called multiple times, but we only want to create a single instance of ViciGameFactory
    if (!sharedFactory) {
		static dispatch_once_t singleton;
		dispatch_once(&singleton, ^{
			//init will assign sharedInstance for us.
			[[ViciGameFactory alloc] init];
		});
    }
}

+ (id) sharedFactory {
    //Already set by +initialize.
    return sharedFactory;
}

+ (id) allocWithZone:(NSZone *)zone {
    //Usually already set by +initialize.
    if (sharedFactory) {
        //The caller expects to receive a new object, so implicitly retain it to balance out the caller's eventual release message.
        return [sharedFactory retain];
    } else {
        //When not already set, +initialize is our caller—it's creating the shared instance. Let this go through.
        return [super allocWithZone:zone];
    }
}

- (id) init {
    //If sharedInstance is nil, +initialize is our caller, so initialize the instance.
    //Conversely, if it is not nil, release this instance (if it isn't the shared instance) and return the shared instance.
    if (!sharedFactory) {
        if ((self = [super init])) {
            //Initialize the instance here.
			
			gameTypes = [[NSMutableArray alloc] init];
			maps = [[NSMutableArray alloc] init];
			[self findPlugins];
			
        }
		
        //Assign sharedInstance here so that we don't end up with multiple instances if a caller calls +alloc/-init without going through +sharedInstance.
        //This isn't foolproof, however (especially if you involve threads). The only correct way to get an instance of a singleton is through the +sharedInstance method.
        sharedFactory = self;
    } else if (self != sharedFactory) {
        [self release];
        self = sharedFactory;
    }
	
    return self;
}

- (void) findPlugins {
	[gameTypes removeAllObjects];
	[maps removeAllObjects];
	
	NSURL * internalPluginsDirectory = [[NSBundle mainBundle] builtInPlugInsURL];
	NSArray * internalPlugins = [[NSFileManager defaultManager] contentsOfDirectoryAtURL:internalPluginsDirectory
															  includingPropertiesForKeys:nil 
																				 options:NSDirectoryEnumerationSkipsSubdirectoryDescendants 
																				   error:nil];
	for (NSURL * foundPlugin in internalPlugins) {
		NSBundle * plugin = [NSBundle bundleWithURL:foundPlugin];
	}
}

@end
