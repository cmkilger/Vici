//
//  ViciGameEngine.m
//  Vici
//
//  Created by Dave DeLong on 11/3/09.
//  Copyright 2009 Home. All rights reserved.
//

#import "ViciGameEngine.h"

#define PLUGIN_INVOKE(o,s) (([o respondsToSelector:@selector(s)]) ? [o s game] : 0)
#define PLUGIN_INVOKE2(o,s,p) (([o respondsToSelector:@selector(s)]) ? [o performSelector:@selector(s) withObject:(p) withObject:game] : 0)

enum {
	ViciGameStateStart = 0,			//!< The game engine is still being initialized (players being added)
	ViciGameStateSetup,				//!< Control has been given to the engine, initial armies are given out and other custom rules
	
	ViciGameStateRoundBegin,		//!< Begin a player's turn
	ViciGameStatePlaceArmies,		//!< The player has armies to place
	ViciGameStateTurnInSets,		//!< The phase at the beginning of a turn where a user can/must turn in cards
	
	ViciGameStateSelectAttacker,	//!< During the attacking phase when the engine is waiting for the user to select an attacking country
	ViciGameStateSelectDefender,	//!< During the attacking phase when the engine is waiting for the user to select a defending country
	ViciGameStateAttack,			//!< ???: What exactly is this?
	ViciGameStateMoveArmies,		//!< Any time when a user has armies to place
	
	ViciGameStateFortify,			//!< The phase at the end of a turn where a user can fortify armies
	ViciGameStateRoundEnd,			//!< After a user ends his/her turn, before the next user begins
	
	ViciGameStateGameOver			//!< After a game has been determined to be over
};

@interface ViciGameEngine ()

- (void) beginNewRound;

@end


@implementation ViciGameEngine

- (id) initWithManagedObjectContext:(NSManagedObjectContext *)aContext mapPlugin:(id<ViciMapPlugin>)aMap gamePlugin:(id<ViciGamePlugin>)aGame {
	if (self = [super init]) {
		state = ViciGameStateStart;
		context = [aContext retain];
		mapPlugin = [aMap retain];
		gamePlugin = [aGame retain];
		players = [[NSMutableArray alloc] init];
		game = [[Game alloc] initWithManagedObjectContext:context];
	}
	return self;
}

- (void) dealloc {
	[context release], context = nil;
	[mapPlugin release], mapPlugin = nil;
	[gamePlugin release], gamePlugin = nil;
	[players release], players = nil;
	[super dealloc];
}

- (BOOL) addPlayer:(id<ViciPlayerPlugin>)aPlayer name:(NSString *)name color:(ViciColor *)color {
	if (state == ViciGameStateStart) {
		Player * newPlayer = [[Player alloc] initWithManagedObjectContext:context];
		[newPlayer setName:name];
		[newPlayer setColor:[NSKeyedArchiver archivedDataWithRootObject:color]];
		
		//use a keypath instead of -count, because we need the answer as an NSNumber, not an NSUInteger
		[newPlayer setOrder:[players valueForKeyPath:@"@count"]];
		[players addObject:newPlayer];
		[game addPlayersObject:newPlayer];
		
		[newPlayer release];
		return YES;
	}
	return NO;
}

- (void) beginGame {
	if (state == ViciGameStateStart) {
		state = ViciGameStateSetup;
		PLUGIN_INVOKE(gamePlugin, gameWillBegin:);
		[self beginNewRound];
	}
}

- (void) beginNewRound {
	if (state == ViciGameStateSetup || state == ViciGameStateRoundEnd) {
		state = ViciGameStateRoundBegin;
		Round * nextRound = [game advanceToNextRound];
		PLUGIN_INVOKE2(gamePlugin, round:willBeginInGame:, nextRound);
	}
}

- (void) didSelectCountry:(Country *)country {
	//TODO: what happens when a country is selected?
	/*
	 different things can happen based on what the current state of the game is.
	 for example, if not all of the countries belong to a player, then this will assign the country to the current player
	 */
}

- (BOOL) canFortify {
	BOOL canFortify = YES;
	
	canFortify = PLUGIN_INVOKE(gamePlugin, canFortifyInGame:);
	
	return (state == ViciGameStateSelectAttacker || state == ViciGameStateSelectDefender) && canFortify;
}

- (void) willBeginFortifications {
	if (state == ViciGameStateSelectAttacker || state == ViciGameStateSelectDefender) {
		state = ViciGameStateFortify;
	}
}

- (void) didSelectCard:(Card *)card {
	
}

@end
