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
	ViciGameState state;
	NSManagedObjectContext * context;
	Game * game;
	id<ViciGameEngineDelegate> delegate;
	
	id<ViciMapPlugin> mapPlugin;
	id<ViciGamePlugin> gamePlugin;
	NSMutableArray * players;
}

- (id) initWithManagedObjectContext:(NSManagedObjectContext *)aContext mapPlugin:(id<ViciMapPlugin>)aMap gamePlugin:(id<ViciGamePlugin>)aGame;

- (BOOL) addPlayer:(id<ViciPlayerPlugin>)aPlayer name:(NSString *)name color:(ViciColor *)color;

- (void) didSelectCountry:(Country *)country;
- (void) didSelectCard:(Card *)card;

- (BOOL) canFortify;
- (void) willBeginFortifications;


@end
