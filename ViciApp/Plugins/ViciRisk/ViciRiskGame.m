//
//  ViciRiskGame.m
//  Vici
//
//  Created by Dave DeLong on 10/19/09.
//  Copyright 2009 Home. All rights reserved.
//

#import "ViciRiskGame.h"

NSString * numberOfSetsTurnedInKey = @"numberOfSetsTurnedInKey";

@implementation ViciRiskGame

+ (NSDictionary *) pluginDescription {
	NSBundle * pluginBundle = [NSBundle bundleForClass:self];
	if (pluginBundle == nil) { return nil; }
	
	NSString * localizedName = NSLocalizedStringWithDefaultValue(kViciPluginDisplayName, nil, pluginBundle, @"Classic Risk", nil);
	
	return [NSDictionary dictionaryWithObjectsAndKeys:kViciPluginTypeGame, kViciPluginType,
			[pluginBundle bundleIdentifier], kViciPluginID,
			localizedName, kViciPluginDisplayName,
			nil];
}

- (void) configureWithGame:(Game *)game {
	NSManagedObjectContext * context = [game managedObjectContext];
	
	numberOfTurnedInSets = 0;
	
#pragma mark Create the cards for each country
	NSString * cardTypes[3] = { kViciCardTypeInfantry, kViciCardTypeCavalry, kViciCardTypeArtillery };
	NSUInteger cardType = 0;
	
	NSSet * countries = [game countries];
	for (Country * country in countries) {
		
		//create the card for the country
		Card * card = [[Card alloc] initWithManagedObjectContext:context];
		[card setType:cardTypes[cardType]];
		[country setCard:card];
		[game addCardsObject:card];
		
		//memory management
		[card release];
		cardType++;
		cardType %= 3;
	}
	
	Card * wild1 = [[Card alloc] initWithManagedObjectContext:context];
	[wild1 setType:kViciCardTypeWild];
	[game addCardsObject:wild1];
	[wild1 release];
	
	Card * wild2 = [[Card alloc] initWithManagedObjectContext:context];
	[wild2 setType:kViciCardTypeWild];
	[game addCardsObject:wild2];
	[wild2 release];
}

- (void) gameWillBegin:(Game *)game {
	NSManagedObjectContext * context = [game managedObjectContext];
	
	NSUInteger numberOfPlayers = [[game players] count];
	//2 players => 40 armies, 3 => 35, 4 => 30, 5 => 25, etc
	NSUInteger numberOfArmiesPerPlayer = 40 - ((numberOfPlayers-2)*5);
	
	//create the to-be-placed armies for each player
	for (Player * player in [game players]) {
		for (NSUInteger i = 0; i < numberOfArmiesPerPlayer; ++i) {
			Army * newArmy = [[Army alloc] initWithManagedObjectContext:context];
			//if an army's country is nil, it means it hasn't been placed yet
			[newArmy setCountry:nil];
			[player addArmiesObject:newArmy];
			[newArmy release];
		}
	}
}

//called whenever a player wants to save the game
- (void) gameWillSave:(Game *)game {
	NSData * setsTurnedIn = [NSKeyedArchiver archivedDataWithRootObject:[NSNumber numberWithUnsignedInteger:numberOfTurnedInSets]];
	[game setSettingData:setsTurnedIn forKey:numberOfSetsTurnedInKey];
}

//called when a player is about to place an army in a country
- (BOOL) placeArmyInCountry:(Country *)aCountry inGame:(Game *)game {
	Army * army = [[[aCountry player] unplacedArmies] anyObject];
	if (army) {
		[army setCountry:aCountry];
		return YES;
	}
	return NO;
}

//called to know if the player is able to attack the given country
- (BOOL) player:(Player *)aPlayer canAttackCountry:(Country *)toCountry fromCountry:(Country *)fromCountry inGame:(Game *)game {	
	if (!toCountry || !fromCountry)
		return NO;
	if ([toCountry player] == aPlayer)
		return NO;
	if ([fromCountry player] != aPlayer)
		return NO;
	if ([[fromCountry armies] count] < 2)
		return NO;
	return [[fromCountry neighbors] containsObject:toCountry];
}

//called when a player is attacking another country
- (void) executeBattle:(Battle *)aBattle inGame:(Game *)game {
	// TODO: Fix number of dice to not use magic numbers, possible configurable
	int numAttackingDice = 3;
	int numDefendingDice = 2;
	
	NSMutableArray * attackingDice = [NSMutableArray arrayWithCapacity:numAttackingDice];
	NSMutableArray * defendingDice = [NSMutableArray arrayWithCapacity:numDefendingDice];
	
	for (int i = 0; i < numAttackingDice; i++)
		[attackingDice addObject:[NSNumber numberWithInt:rand()%6]];
	for (int i = 0; i < numDefendingDice; i++)
		[defendingDice addObject:[NSNumber numberWithInt:rand()%6]];
	
	NSSortDescriptor * sort = [[NSSortDescriptor alloc] initWithKey:nil ascending:NO selector:@selector(compare:)];
	[attackingDice sortUsingDescriptors:[NSArray arrayWithObject:sort]];
	[defendingDice sortUsingDescriptors:[NSArray arrayWithObject:sort]];
	[sort release];
	
	int attackerLosses = 0;
	int defenderLosses = 0;
	
	for (int i = 0; i < fmin(numAttackingDice, numDefendingDice); i++) {
		if ([[attackingDice objectAtIndex:i] compare:[defendingDice objectAtIndex:i]] == NSOrderedDescending)
			defenderLosses++;
		else
			attackerLosses++;
	}
	
	for (int i = 0; i < attackerLosses; i++) {
		Army * army = [aBattle.attackingCountry.armies anyObject];
		army.country = nil;
	}
	
	for (int i = 0; i < defenderLosses; i++) {
		Army * army = [aBattle.defendingCountry.armies anyObject];
		army.country = nil;
	}
	
	if ([aBattle.defendingCountry.armies count] == 0)
		aBattle.defendingCountry.player = aBattle.attackingCountry.player;
}

//Called after every battle to check if the game has been won
- (BOOL) isGameOverInGame:(Game *)game {
	//Assumes a simple victory condition: one player controls all the countries. Does not take into account conditions such as alliances.
	return ([[game countries] count] == [[[game currentPlayer] countries] count]);
}

@end
