//
//  ViciGameEngine.m
//  Vici
//
//  Created by Dave DeLong on 11/3/09.
//  Copyright 2009 Home. All rights reserved.
//

#import "ViciGameEngine.h"
//#import "ViciPlayerPlugin.h"

#define PLUGIN_INVOKE(o,s) (([o respondsToSelector:@selector(s)]) ? [o s game] : 0)
#define PLUGIN_INVOKE2(o,s,p) (([o respondsToSelector:@selector(s)]) ? [o performSelector:@selector(s) withObject:(p) withObject:game] : 0)

enum {
	ViciGameStateStart = 0,			//!< The game engine is still being initialized (players being added)
	ViciGameStateSetup,				//!< Control has been given to the engine, initial armies are given out and other custom rules
	
	ViciGameStateRoundBegin,		//!< Begin a player's turn, calculate armies for the player, etc.
	ViciGameStatePlaceArmies,		//!< The player has armies to place at the beginning of the turn, can turn in cards if desired
	
	ViciGameStateAttack,			//!< The phase where the user is attacking other players
	ViciGameStateMoveArmies,		//!< When a player has armies to place after winning a battle
	
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
		game = [[Game alloc] initWithManagedObjectContext:context];
	}
	return self;
}

- (void) dealloc {
	[context release], context = nil;
	[mapPlugin release], mapPlugin = nil;
	[gamePlugin release], gamePlugin = nil;
	[super dealloc];
}

- (BOOL) addPlayer:(id<ViciPlayerPlugin>)aPlayer name:(NSString *)name color:(ViciColor *)color {
	if (state == ViciGameStateStart) {
		Player * newPlayer = [[Player alloc] initWithManagedObjectContext:context];
		[newPlayer setName:name];
		[newPlayer setColor:[NSKeyedArchiver archivedDataWithRootObject:color]];
		[newPlayer setPlugin:aPlayer];
		
		//use a keypath instead of -count, because we need the answer as an NSNumber, not an NSUInteger
		[newPlayer setOrder:[[game players] valueForKeyPath:@"@count"]];
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
		
		// Tells the player plugin for the current player to play the round
		[[[game currentPlayer] plugin] playRound:nextRound inGameEngine:self];
	}
}

- (void) didSelectCountry:(Country *)country {
	/*
	 different things can happen based on what the current state of the game is.
	 for example, if not all of the countries belong to a player, then this will assign the country to the current player
	 */
		
	switch (state) {
		case ViciGameStatePlaceArmies: {
			// If the player has no armies to place and the selected country is an attackable country, move to the next phase and recall this method, otherwise attempt to place the army
			if ([[[game currentPlayer] unplacedArmies] count] == 0 && [gamePlugin player:[game currentPlayer] canAttackCountry:country fromCountry:selectedCountry inGame:game]) {
				state = ViciGameStateAttack;
				[self didSelectCountry:country];
			}
			
			// Attempt to place an army in the country.  If succesful, check if we're still in the country choosing phase, and if so end the round.
			else {
				if ([gamePlugin placeArmyInCountry:country inGame:game]) {
					selectedCountry = country;
					if ([[[game countries] filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"player == nil"]] count] > 0) {
						state == ViciGameStateRoundEnd;
						[self beginNewRound];
					}
				}
			}
			
			break;
		}
		case ViciGameStateAttack: {
			// Select country if it is owned by the current player
			if ([country player] == [game currentPlayer])
				selectedCountry = country;
			
			// Attack the country if able to
			else if ([gamePlugin player:[game currentPlayer] canAttackCountry:country fromCountry:selectedCountry inGame:game]) {
				Battle * battle = [[Battle alloc] initWithManagedObjectContext:context];
				[battle setRound:[game currentRound]];
				[battle setOrder:[[[game currentRound] battles] valueForKeyPath:@"@count"]];
				[battle setAttackingCountry:selectedCountry];
				[battle setDefendingCountry:country];
				[battle setDefender:[country player]];
				[gamePlugin executeBattle:battle inGame:game];
				[battle release];
				
				// if the attacked country is now owned by the current player he obviously conquered it
				if ([country player] == [game currentPlayer]) {
					selectedCountry = country;
					if ([gamePlugin isGameOverInGame:game])
						[self gameOver];
				}
				
				// If there are now armies to be placed we move to the moving phase
				if ([[[game currentPlayer] unplacedArmies] count] > 0)
					state = ViciGameStateMoveArmies;
			}

			break;
		}
		case ViciGameStateMoveArmies: {
			// We are only in this phase after a country is conquered, so the only possible countries are from the previous battle
			Battle * battle = [[game currentRound] lastBattle];
			if (country == [battle attackingCountry] || country == [battle defendingCountry])
				[gamePlugin placeArmyInCountry:country inGame:game];
			if ([[[game currentPlayer] unplacedArmies] count] == 0)
				state = ViciGameStateAttack;
			break;
		}
		case ViciGameStateFortify: {
			//???: Should fortifying be controlled by the plugin since it could change with rule sets?			
			//Selects the country to move armies from if it is owned by the player.
			if (!selectedCountry && [country player] == [game currentPlayer]) {
				selectedCountry = country;
				NSSet * armiesToFortify = [selectedCountry armies];
				for (Army * army in armiesToFortify)
					[army setCountry:nil];
				[[armiesToFortify anyObject] setCountry:country];
			}
			
			// Move one army into the country if it can be fortified to there
			else if (selectedCountry && [country player] == [game currentPlayer]) {
				// Defaults to YES just in case the map plugin hasn't implemented the country:connectsToCountry:inGame: method.
				/*
				 * TODO: Determining whether or not a armies can be fortified can be more involved than simply checking if they're connected.
				 *  We should have a plugin method to check if the fortification is valid.
				 */
				BOOL countriesConnected = YES;
				if([mapPlugin respondsToSelector:@selector(country:connectsToCountry:inGame:)])
					countriesConnected = [mapPlugin country:selectedCountry connectsToCountry:country inGame:game];				
				if (countriesConnected)
					[[[[game currentPlayer] unplacedArmies] anyObject] setCountry:country];
				if ([[[game currentPlayer] unplacedArmies] count] == 0)
					selectedCountry = nil;
			}
			break;
		}
	}
}

- (BOOL) canFortify {
	BOOL canFortify = YES;
	
	canFortify = PLUGIN_INVOKE(gamePlugin, canFortifyInGame:);
	
	return ViciGameStateAttack && canFortify;
}

- (void) willBeginFortifications {
	if (state == ViciGameStateAttack) {
		state = ViciGameStateFortify;
		selectedCountry = nil;
	}
}

- (void) didSelectCard:(Card *)card {
	
}

- (void)gameOver {
	// TODO: Do whatever it's supposed to do when the game is over
}

@end
