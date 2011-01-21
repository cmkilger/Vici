//
//  Game_Private.h
//  Vici
//
//  Created by Dave DeLong on 10/23/09.
//  Copyright 2009 Home. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Game (ViciGamePrivate)

@property (nonatomic, assign) Player * currentPlayer;
@property (nonatomic, assign) Round * currentRound;
@property (nonatomic, assign) Battle * currentBattle;

@end