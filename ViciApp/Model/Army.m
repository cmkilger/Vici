// 
//  Army.m
//  Vici
//
//  Created by Dave DeLong on 10/13/09.
//  Copyright 2009 Home. All rights reserved.
//

#import "Army.h"

#import "Country.h"
#import "Player.h"

@implementation Army 

@dynamic experience;
@dynamic country;
@dynamic player;

- (id) initWithManagedObjectContext:(NSManagedObjectContext *)context {
	NSEntityDescription * planet = [NSEntityDescription entityForName:@"Army" inManagedObjectContext:context];
	return [self initWithEntity:planet insertIntoManagedObjectContext:context];
}

@end
