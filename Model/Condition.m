// 
//  Condition.m
//  Vici
//
//  Created by Dave DeLong on 10/13/09.
//  Copyright 2009 Home. All rights reserved.
//

#import "Condition.h"

#import "Trigger.h"

@implementation Condition 

@dynamic predicate;
@dynamic trigger;

- (BOOL) evaluateWithGame:(ViciGame *)game {
	NSPredicate * p = [NSPredicate predicateWithFormat:@"%@", [self predicate]];
	return [p evaluateWithObject:game];
}

@end
