//
//  NSArray+ViciAdditions.h
//  Vici
//
//  Created by Cory Kilger on 10/20/09.
//  Copyright 2009 Cory Kilger. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSArray (ViciAdditions)

- (NSArray *) sortedArrayUsingDescriptor:(NSSortDescriptor *)sortDescriptor;

@end

@interface NSSet (ViciAdditions)

- (NSArray *) sortedArrayUsingDescriptor:(NSSortDescriptor *)sortDescriptor;

@end
