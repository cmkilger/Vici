// 
//  Country.m
//  Vici
//
//  Created by Dave DeLong on 10/13/09.
//  Copyright 2009 Home. All rights reserved.
//

#import "Country.h"

#import "Card.h"
#import "Player.h"

@implementation Country 

@dynamic name;
@dynamic continent;
@dynamic neighbors;
@dynamic player;
@dynamic armies;
@dynamic card;

- (id) initWithManagedObjectContext:(NSManagedObjectContext *)context {
	NSEntityDescription * country = [NSEntityDescription entityForName:@"Country" inManagedObjectContext:context];
	return [self initWithEntity:country insertIntoManagedObjectContext:context];
}

@end
