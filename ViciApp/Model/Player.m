// 
//  Player.m
//  Vici
//
//  Created by Dave DeLong on 10/13/09.
//  Copyright 2009 Home. All rights reserved.
//

#import "Player.h"


@implementation Player 

@dynamic name;
@dynamic order;
@dynamic color;
@dynamic countries;
@dynamic armies;
@dynamic cards;

@synthesize plugin;

- (id) initWithManagedObjectContext:(NSManagedObjectContext *)context {
	NSEntityDescription * player = [NSEntityDescription entityForName:@"Player" inManagedObjectContext:context];
	return [self initWithEntity:player insertIntoManagedObjectContext:context];
}

- (NSSet*) unplacedArmies {
	return [[self armies] filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"country = nil"]];
}

@end
