// 
//  Planet.m
//  Vici
//
//  Created by Dave DeLong on 10/13/09.
//  Copyright 2009 Home. All rights reserved.
//

#import "Planet.h"


@implementation Planet 

@dynamic name;
@dynamic continents;

- (id) initWithManagedObjectContext:(NSManagedObjectContext *)context {
	NSEntityDescription * planet = [NSEntityDescription entityForName:@"Planet" inManagedObjectContext:context];
	return [self initWithEntity:planet insertIntoManagedObjectContext:context];
}

@end
