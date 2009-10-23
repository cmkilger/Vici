// 
//  Game.m
//  Vici
//
//  Created by Dave DeLong on 10/22/09.
//  Copyright 2009 Home. All rights reserved.
//

#import "Game.h"
#import "Game_Private.h"

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

@end
