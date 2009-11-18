// 
//  Battle.m
//  Vici
//
//  Created by Dave DeLong on 10/13/09.
//  Copyright 2009 Home. All rights reserved.
//

#import "Battle.h"


@implementation Battle 

@dynamic order;
@dynamic round;
@dynamic defendingCountry;
@dynamic attackingCountry;
@dynamic defender;

- (id) initWithManagedObjectContext:(NSManagedObjectContext *)context {
	NSEntityDescription * planet = [NSEntityDescription entityForName:@"Battle" inManagedObjectContext:context];
	return [self initWithEntity:planet insertIntoManagedObjectContext:context];
}

@end
