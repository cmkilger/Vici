// 
//  Card.m
//  Vici
//
//  Created by Dave DeLong on 10/13/09.
//  Copyright 2009 Home. All rights reserved.
//

#import "Card.h"

#import "Player.h"

@implementation Card 

@dynamic type;
@dynamic country;
@dynamic player;

- (id) initWithManagedObjectContext:(NSManagedObjectContext *)context {
	NSEntityDescription * card = [NSEntityDescription entityForName:@"Card" inManagedObjectContext:context];
	return [self initWithEntity:card insertIntoManagedObjectContext:context];
}

@end
