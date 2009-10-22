//
//  Game.h
//  Vici
//
//  Created by Dave DeLong on 10/22/09.
//  Copyright 2009 Home. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Card;
@class Continent;
@class Country;
@class Planet;
@class Player;
@class Round;
@class Battle;

@interface Game :  NSManagedObject  
{
	Player * currentPlayer;
	Round * currentRound;
	Battle * currentBattle;
}

@property (nonatomic, retain) NSSet* planets;
@property (nonatomic, retain) NSSet* rounds;
@property (nonatomic, retain) NSSet* continents;
@property (nonatomic, retain) NSSet* countries;
@property (nonatomic, retain) NSSet* cards;
@property (nonatomic, retain) NSSet* players;

@property (nonatomic, assign) Player * currentPlayer;
@property (nonatomic, assign) Round * currentRound;
@property (nonatomic, assign) Battle * currentBattle;

@end


@interface Game (CoreDataGeneratedAccessors)
- (void)addPlanetsObject:(Planet *)value;
- (void)removePlanetsObject:(Planet *)value;
- (void)addPlanets:(NSSet *)value;
- (void)removePlanets:(NSSet *)value;

- (void)addRoundsObject:(Round *)value;
- (void)removeRoundsObject:(Round *)value;
- (void)addRounds:(NSSet *)value;
- (void)removeRounds:(NSSet *)value;

- (void)addContinentsObject:(Continent *)value;
- (void)removeContinentsObject:(Continent *)value;
- (void)addContinents:(NSSet *)value;
- (void)removeContinents:(NSSet *)value;

- (void)addCountriesObject:(Country *)value;
- (void)removeCountriesObject:(Country *)value;
- (void)addCountries:(NSSet *)value;
- (void)removeCountries:(NSSet *)value;

- (void)addCardsObject:(Card *)value;
- (void)removeCardsObject:(Card *)value;
- (void)addCards:(NSSet *)value;
- (void)removeCards:(NSSet *)value;

- (void)addPlayersObject:(Player *)value;
- (void)removePlayersObject:(Player *)value;
- (void)addPlayers:(NSSet *)value;
- (void)removePlayers:(NSSet *)value;

@end

