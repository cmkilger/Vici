//
//  ViciCLIGame.h
//  Vici
//
//  Created by Cory Kilger on 1/20/11.
//  Copyright 2011 Cory Kilger All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ViciCLICommandHandler.h"

/*
 
 [none]
 
 > new game 4
 
 [map]
 
 what map?
 
 > 4
 
 [players]
 
 number of players? (2-6)
 
 > 3
 
 
 
 */


typedef enum {
	ViciCLIGameStateNone = 0,
	ViciCLIGameStateMap,
	ViciCLIGameStatePlayers,
} ViciCLIGameState;

@class ViciGameEngine;

@interface ViciCLIGame : NSObject <ViciCLICommandHandler> {
	ViciCLIGameState state;
	ViciGameEngine * game;
	NSDictionary * gameType;
	NSDictionary * mapType;
}

@end
