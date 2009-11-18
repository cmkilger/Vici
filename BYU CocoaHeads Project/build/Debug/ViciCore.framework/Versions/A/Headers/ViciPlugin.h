//
//  ViciPlugin.h
//  Vici
//
//  Created by Dave DeLong on 10/21/09.
//  Copyright 2009 Home. All rights reserved.
//

@class Game;

@protocol ViciPlugin <NSObject>

+ (NSDictionary *) pluginDescription;

- (void) configureWithGame:(Game *)game;

@end