// 
//  Continent.m
//  Vici
//
//  Created by Dave DeLong on 10/13/09.
//  Copyright 2009 Home. All rights reserved.
//

#import "Continent.h"

#import "Country.h"
#import "Planet.h"

@implementation Continent 

@dynamic name;
@dynamic planet;
@dynamic countries;

- (id) initWithManagedObjectContext:(NSManagedObjectContext *)context {
	NSEntityDescription * continent = [NSEntityDescription entityForName:@"Continent" inManagedObjectContext:context];
	return [self initWithEntity:continent insertIntoManagedObjectContext:context];
}

@end
