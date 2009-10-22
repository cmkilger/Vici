//
//  ViciGamePlugin.h
//  Vici
//
//  Created by Dave DeLong on 10/22/09.
//  Copyright 2009 Home. All rights reserved.
//

@class Game;
@class Country;
@class Army;
@class Battle;
@class Round;
@class Player;

@protocol ViciGamePlugin

//all the following methods are optional
@optional

//initial game
- (void) gameWillBegin:(Game *)game;
//called repeated as players choose/are assigned countries
- (void) player:(Player *)aPlayer didChooseCountry:(Country *)aCountry inGame:(Game *)aGame;

//called as a new round begins
- (void) round:(Round *)aRound willBeginInGame:(Game *)game;
//called when a player turns in a set of cards
- (void) cards:(NSSet *)cards wereTurnedInInGame:(Game *)game;

//called when a player is about to place an army in a country
- (void) army:(Army *)anArmy willBePlacedInCountry:(Country *)aCountry inGame:(Game *)game;
//called when a player has just placed an army in a country
- (void) army:(Army *)anArmy wasPlacedInCountry:(Country *)aCountry inGame:(Game *)game;

//called when a player is about to attack another country
- (void) battle:(Battle *)aBattle willBeginInGame:(Game *)game;
//called after a player has attacked another country
- (void) battle:(Battle *)aBattle didEndInGame:(Game *)game;
//called when a player conquers a country
- (void) country:(Country *)aCountry wasConqueredInGame:(Game *)game;

//called as a round is ending
- (void) round:(Round *)aRound didEndInGame:(Game *)game;

//called whenever a player has been defeated
- (void) player:(Player *)aPlayer wasDefeatedInGame:(Game *)game;

@end
