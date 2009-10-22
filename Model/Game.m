// 
//  Game.m
//  Vici
//
//  Created by Dave DeLong on 10/22/09.
//  Copyright 2009 Home. All rights reserved.
//

#import "Game.h"

#import "Card.h"
#import "Continent.h"
#import "Country.h"
#import "Planet.h"
#import "Player.h"
#import "Round.h"

@implementation Game 

@synthesize currentPlayer, currentRound, currentBattle;

@dynamic planets;
@dynamic rounds;
@dynamic continents;
@dynamic countries;
@dynamic cards;
@dynamic players;

@end
