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

@protocol ViciGamePlugin <ViciPlugin>

//called when a player is about to place an army in a country
- (BOOL) placeArmyInCountry:(Country *)aCountry inGame:(Game *)game;
//called to know if the player is able to attack the given country
- (BOOL) player:(Player *)aPlayer canAttackCountry:(Country *)aCountry;

//called when a player is attacking another country
- (void) executeBattle:(Battle *)aBattle inGame:(Game *)game;


//all the following methods are optional
@optional

//default is YES
- (BOOL) canFortifyInGame:(Game *)game;

//initial game
- (void) gameWillBegin:(Game *)game;
//called repeated as players choose/are assigned countries
- (void) player:(Player *)aPlayer didChooseCountry:(Country *)aCountry inGame:(Game *)aGame;

//called as a new round begins
- (void) round:(Round *)aRound willBeginInGame:(Game *)game;
//called when a player turns in a set of cards
- (void) cards:(NSSet *)cards wereTurnedInInGame:(Game *)game;

//called as a round is ending
- (void) round:(Round *)aRound didEndInGame:(Game *)game;

//called whenever a player has been defeated
- (void) player:(Player *)aPlayer wasDefeatedInGame:(Game *)game;

//called whenever a player wants to save the game
- (void) gameWillSave:(Game *)game;

@end
