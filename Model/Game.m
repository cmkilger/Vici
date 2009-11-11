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
#import "Setting.h"

@implementation Game 

@synthesize currentPlayer, currentRound, currentBattle, orderedPlayers;

@dynamic planets;
@dynamic rounds;
@dynamic continents;
@dynamic countries;
@dynamic cards;
@dynamic players;
@dynamic settings;

- (id) initWithManagedObjectContext:(NSManagedObjectContext *)moc {
	NSEntityDescription * entity = [NSEntityDescription entityForName:@"Game" inManagedObjectContext:moc];
	if (self = [super initWithEntity:entity insertIntoManagedObjectContext:moc]) {
		[self setCurrentPlayer:nil];
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

- (NSData *) settingDataForKey:(NSString *)key {
	NSSet * matchingSettings = [[self settings] filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"key = %@", key]];
	if ([matchingSettings count] < 1) { return nil; }
	Setting * setting = [matchingSettings anyObject];
	return [setting dataValue];
}

- (void) setSettingData:(NSData *)data forKey:(NSString *)key {
	NSSet * matchingSettings = [[self settings] filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"key = %@", key]];
	Setting * setting = [matchingSettings anyObject];
	if (setting == nil) {
		setting = [[[Setting alloc] initWithManagedObjectContext:[self managedObjectContext]] autorelease];
		[setting setKey:key];
		[self addSettingsObject:setting];
	}
	[setting setDataValue:data];
}

- (Player *) advanceToNextPlayer {
	NSUInteger indexOfNextPlayer = 0;
	if ([self currentPlayer] != nil) {
		indexOfNextPlayer = [orderedPlayers indexOfObject:[self currentPlayer]] + 1;
		indexOfNextPlayer %= [orderedPlayers count];
	}
	[self setCurrentPlayer:[orderedPlayers objectAtIndex:indexOfNextPlayer]];
	return [self currentPlayer];
}

- (Round *) advanceToNextRound {
	Round * nextRound = [[Round alloc] initWithManagedObjectContext:[self managedObjectContext]];
	[nextRound setOrder:[NSNumber numberWithUnsignedInteger:[[self currentRound] order] + 1]];
	[nextRound setPlayer:[self advanceToNextPlayer]];
	[self setCurrentRound:nextRound];
	return [nextRound autorelease];
}

@end
