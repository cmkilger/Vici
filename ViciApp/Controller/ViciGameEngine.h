//
//  ViciGameEngine.h
//  Vici
//
//  Created by Dave DeLong on 11/3/09.
//  Copyright 2009 Home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViciGameEngineDelegate.h"
#import "ViciCore.h"

typedef NSUInteger ViciGameState;

@interface ViciGameEngine : NSObject {
	ViciGameState state;					//!< The current state (phase) of the game
	NSManagedObjectContext * context;		//!< The game's managed object context
	Game * game;							//!< The Game object stored using Core Data
	id<ViciGameEngineDelegate> delegate;	//!< The game engine's delegate
	Country * selectedCountry;				//!< Can be the attacking country, or source of a fortification, etc.
	
	id<ViciMapPlugin> mapPlugin;			//!< The map plugin
	id<ViciGamePlugin> gamePlugin;			//!< The game plugin
}

- (id) initWithManagedObjectContext:(NSManagedObjectContext *)aContext mapPlugin:(id<ViciMapPlugin>)aMap gamePlugin:(id<ViciGamePlugin>)aGame;

- (BOOL) addPlayer:(id<ViciPlayerPlugin>)aPlayer name:(NSString *)name color:(ViciColor *)color;

- (void) beginGame;

- (void) didSelectCountry:(Country *)country;
- (void) didSelectCard:(Card *)card;

- (BOOL) canFortify;
- (void) willBeginFortifications;

- (void) gameOver;


@end
