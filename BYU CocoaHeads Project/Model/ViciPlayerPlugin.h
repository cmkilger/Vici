//
//  ViciPlayerPlugin.h
//  Vici
//
//  Created by Dave DeLong on 11/3/09.
//  Copyright 2009 Home. All rights reserved.
//

@class Round;
@class Game;

@protocol ViciPlayerPlugin <ViciPlugin>

- (void) playRound:(Round *)aRound inGame:(Game *)game;

@end
