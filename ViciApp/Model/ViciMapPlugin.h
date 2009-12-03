//
//  ViciMapPlugin.h
//  Vici
//
//  Created by Dave DeLong on 10/27/09.
//  Copyright 2009 Home. All rights reserved.
//

@class Game;
@class Country;
@class Planet;

@protocol ViciMapPlugin <ViciPlugin>

- (CGPathRef) pathForCountry:(Country *)aCountry;
- (NSString *) backgroundImageFilePathForPlanet:(Planet *)aPlanet;

@optional

- (BOOL) country:(Country *)aCountry connectsToCountry:(Country *)otherCountry inGame:(Game *)game;

@end
