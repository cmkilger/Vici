// 
//  Trigger.m
//  Vici
//
//  Created by Dave DeLong on 10/13/09.
//  Copyright 2009 Home. All rights reserved.
//

#import "Trigger.h"

#import "Action.h"

@implementation Trigger 

@dynamic event;
@dynamic actions;
@dynamic conditions;

- (void) evaluateWithGame:(ViciGame *)game {
	for (Condition * condition in [self conditions])
		if (![condition evaluateWithGame:game])
			return;
	//if we get here, then all the conditions (if there were any) were true
	NSSortDescriptor * sortByIndex = [NSSortDescriptor sortDescriptorWithKey:@"index" ascending:YES];
	NSArray * sortedActions = [[self actions] sortedArrayUsingDescriptor:sortByIndex];
	for (Action * action in sortedActions) {
		[action evaluateWithGame:game];
	}
}

@end
