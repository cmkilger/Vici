// 
//  Game.m
//  Vici
//
//  Created by Dave DeLong on 10/22/09.
//  Copyright 2009 Home. All rights reserved.
//

#import "Game.h"

#import "Card.h"
#import "Continent.h"
#import "Country.h"
#import "Planet.h"
#import "Player.h"
#import "Round.h"

@implementation Game 

@synthesize currentPlayer, currentRound, currentBattle, orderedPlayers;

@dynamic numberOfTurnedInSets;
@dynamic planets;
@dynamic rounds;
@dynamic continents;
@dynamic countries;
@dynamic cards;
@dynamic players;

- (id) initWithManagedObjectContext:(NSManagedObjectContext *)moc {
	NSEntityDescription * entity = [NSEntityDescription entityForName:@"Game" inManagedObjectContext:moc];
	if (self = [super initWithEntity:entity insertIntoManagedObjectContext:moc]) {
		[self setCurrentPlayer:nil];
		[self setNumberOfTurnedInSets:[NSNumber numberWithUnsignedInteger:0]];
		[self setCurrentRound:nil];
		[self setCurrentBattle:nil];
		
		[self addObserver:self forKeyPath:@"players" options:0 context:nil];
		orderedPlayers = nil;
	}
	return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	if ([keyPath isEqual:@"players"]) {
		//the players changed!
		[orderedPlayers release];
		NSFetchRequest * playerRequest = [[NSFetchRequest alloc] init];
		[playerRequest setEntity:[NSEntityDescription entityForName:@"Player" inManagedObjectContext:[self managedObjectContext]]];
		[playerRequest setSortDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"order" ascending:YES]]];
		orderedPlayers = [[[self managedObjectContext] executeFetchRequest:playerRequest error:nil] retain];
		[playerRequest release];
	}
}

/**
 We have to override the generated implementations of the player accessors
 so that we can keep the array indicating the order remains synchronized
 */
- (void)addPlayersObject:(Player *)value {
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	
    [self willChangeValueForKey:@"players"
				withSetMutation:NSKeyValueUnionSetMutation
				   usingObjects:changedObjects];
    [[self primitivePlayers] addObject:value];
	if ([playerOrder containsObject:value] == NO) {
		[playerOrder addObject:value];
	}
    [self didChangeValueForKey:@"players"
			   withSetMutation:NSKeyValueUnionSetMutation
				  usingObjects:changedObjects];
	
    [changedObjects release];
}

- (void)removePlayersObject:(Player *)value {
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	
    [self willChangeValueForKey:@"players"
				withSetMutation:NSKeyValueMinusSetMutation
				   usingObjects:changedObjects];
    [[self primitivePlayers] removeObject:value];
	[playerOrder removeObject:value];
    [self didChangeValueForKey:@"players"
			   withSetMutation:NSKeyValueMinusSetMutation
				  usingObjects:changedObjects];
	
    [changedObjects release];
}

- (void)addPlayers:(NSSet *)value {
    [self willChangeValueForKey:@"players"
				withSetMutation:NSKeyValueUnionSetMutation
				   usingObjects:value];
    [[self primitivePlayers] unionSet:value];
	for (Player * newPlayer in value) {
		if ([playerOrder containsObject:newPlayer] == NO) {
			[playerOrder addObject:newPlayer];
		}
	}
    [self didChangeValueForKey:@"players"
			   withSetMutation:NSKeyValueUnionSetMutation
				  usingObjects:value];
}

- (void)removePlayers:(NSSet *)value {
    [self willChangeValueForKey:@"players"
				withSetMutation:NSKeyValueMinusSetMutation
				   usingObjects:value];
    [[self primitivePlayers] minusSet:value];
	[playerOrder removeObjectsInArray:[value allObjects]];
    [self didChangeValueForKey:@"players"
			   withSetMutation:NSKeyValueMinusSetMutation
				  usingObjects:value];
}

@end
