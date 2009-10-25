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
	
	return [NSDictionary dictionaryWithObjectsAndKeys:kViciPluginTypeMap, kViciPluginType,
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

@end
