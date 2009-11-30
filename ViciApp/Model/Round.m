// 
//  Round.m
//  Vici
//
//  Created by Dave DeLong on 10/13/09.
//  Copyright 2009 Home. All rights reserved.
//

#import "Round.h"

#import "Battle.h"
#import "Player.h"

@implementation Round 

@dynamic order;
@dynamic player;
@dynamic battles;

- (id) initWithManagedObjectContext:(NSManagedObjectContext *)context {
	NSEntityDescription * planet = [NSEntityDescription entityForName:@"Round" inManagedObjectContext:context];
	return [self initWithEntity:planet insertIntoManagedObjectContext:context];
}

- (Battle *) lastBattle {
	NSSortDescriptor * sort = [[NSSortDescriptor alloc] initWithKey:@"order" ascending:YES];
	NSArray * sortedBattles = [[self.battles allObjects] sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]];
	[sort release];
	return [sortedBattles lastObject];
}

@end
