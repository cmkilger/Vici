//
//  ViciGameEngine.m
//  Vici
//
//  Created by Dave DeLong on 11/3/09.
//  Copyright 2009 Home. All rights reserved.
//

#import "ViciGameEngine.h"

enum {
	ViciGameStateStart = 0,
	
	ViciGameStateRoundBegin,
	ViciGameStatePlaceArmies,
	ViciGameStateTurnInSets,
	
	ViciGameStateSelectAttacker,
	ViciGameStateSelectDefender,
	ViciGameStateAttack,
	ViciGameStateMoveArmies,
	
	ViciGameStateFortify,
	ViciGameStateRoundEnd,
	
	ViciGameStateGameOver
};

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

- (void) didSelectCountry:(Country *)country {
	//TODO: what happens when a country is selected?
	/*
	 different things can happen based on what the current state of the game is.
	 for example, if not all of the countries belong to a player, then this will assign the country to the current player
	 */
}

- (BOOL) canFortify {
	BOOL canFortify = YES;
	if ([gamePlugin respondsToSelector:@selector(canFortify)]) {
		canFortify = [gamePlugin canFortifyInGame:game];
	}
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
