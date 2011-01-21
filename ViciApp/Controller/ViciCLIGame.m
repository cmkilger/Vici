//
//  ViciCLIGame.m
//  Vici
//
//  Created by Cory Kilger on 1/20/11.
//  Copyright 2011 Cory Kilger All rights reserved.
//

#import "ViciCLIGame.h"
#import "ViciCore.h"
#import "NSBundle+ViciAdditions.h"

@interface ViciCLIGame ()

@property (nonatomic, retain) ViciGameEngine * game;
@property (nonatomic, retain) NSDictionary * gameType;

- (NSManagedObjectContext *) context;

@end


@implementation ViciCLIGame

@synthesize game, gameType;

- (BOOL) handleCommand:(NSString *)command needsMore:(BOOL *)needsMore {
	*needsMore = NO;
	
	if ([command hasPrefix:@"new game "]) {
		NSArray * gameTypes = [[ViciPluginManager sharedManager] availableGameTypes];
		NSString * subcommand = [command substringFromIndex:9];
		
		if ([subcommand isEqualToString:@"list"]) {
			int i = 1;
			for (NSDictionary * type in gameTypes) {
				printf("%d: %s\n", i++, [[type objectForKey:kViciPluginDisplayName] cStringUsingEncoding:NSUTF8StringEncoding]);
			}
			return YES;
		}
		else {
			NSInteger gameIndex = [subcommand integerValue];
			if (gameIndex > 0 && gameIndex <= [gameTypes count]) {
				self.gameType = [gameTypes objectAtIndex:gameIndex-1];
				
				printf("What map would you like to use?\n");
				NSArray * maps = [[ViciPluginManager sharedManager] availableMaps];
				int i = 1;
				for (NSDictionary * map in maps) {
					printf("%d: %s\n", i++, [[gameType objectForKey:kViciPluginDisplayName] cStringUsingEncoding:NSUTF8StringEncoding]);
				}
				*needsMore = YES;
				state = ViciCLIGameStateMap;
				
				return YES;
			}
		}
	}
	
	return NO;
}

- (NSString *) help {
	NSString * help = @"Game Commands\n";
	help = [help stringByAppendingString:@"  new game list\t\tDisplays a list of all available game types.\n"];
	help = [help stringByAppendingString:@"  new game <num>\t\tCreates a new game using the number from 'new game list'.\n"];
	return help;
}

#pragma mark -

- (NSManagedObjectContext *) context {
	NSURL * modelURL = [NSURL fileURLWithPath:[[NSBundle viciBundle] pathForResource:@"model.momd" ofType:nil]];
	NSManagedObjectModel * model = [[[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL] autorelease];
	
	NSPersistentStoreCoordinator * store = [[[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model] autorelease];
	[store addPersistentStoreWithType:NSInMemoryStoreType configuration:nil URL:nil options:nil error:nil];
	
	NSManagedObjectContext * context = [[[NSManagedObjectContext alloc] init] autorelease];
	[context setPersistentStoreCoordinator:store];
	return context;
}

- (void) startGame {
	
	printf("Chose game type: %s\n", [[gameType objectForKey:kViciPluginDisplayName] cStringUsingEncoding:NSUTF8StringEncoding]);
		
	id<ViciMapPlugin> mapPlugin = [[ViciPluginManager sharedManager] instanceOfPluginWithIdentifier:[mapType objectForKey:kViciPluginID]];
	id<ViciGamePlugin> gamePlugin = [[ViciPluginManager sharedManager] instanceOfPluginWithIdentifier:[gameType objectForKey:kViciPluginID]];
	
	self.game = [[[ViciGameEngine alloc] initWithManagedObjectContext:[self context] mapPlugin:mapPlugin gamePlugin:gamePlugin] autorelease];
}

@end
