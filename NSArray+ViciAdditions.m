//
//  NSArray+ViciAdditions.m
//  Vici
//
//  Created by Cory Kilger on 10/20/09.
//  Copyright 2009 Cory Kilger. All rights reserved.
//

#import "NSArray+ViciAdditions.h"


@implementation NSArray (ViciAdditions)

- (NSArray *) sortedArrayUsingDescriptor:(NSSortDescriptor *)sortDescriptor {
	return [self sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
}

@end

@implementation NSSet (ViciAdditions)

- (NSArray *) sortedArrayUsingDescriptor:(NSSortDescriptor *)sortDescriptor {
	return [[self allObjects] sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
}

@end
