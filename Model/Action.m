// 
//  Action.m
//  Vici
//
//  Created by Cory Kilger on 10/20/09.
//  Copyright 2009 Cory Kilger. All rights reserved.
//

#import "Action.h"

#import "ActionParameter.h"
#import "Trigger.h"
#import "ViciGame.h"
#import "NSArray+ViciAdditions.h"

@implementation Action 

@dynamic selector;
@dynamic index;
@dynamic trigger;
@dynamic parameters;

- (void) evaluateWithGame:(ViciGame *)game {
	SEL gameMethod = NSSelectorFromString([self selector]);
	NSMethodSignature * gameMethodSignature = [game methodSignatureForSelector:gameMethod];
	
	NSInvocation * invocation = [NSInvocation invocationWithMethodSignature:gameMethodSignature];
	[invocation setTarget:game];
	[invocation setSelector:gameMethod];
	
	NSSortDescriptor * sortByIndex = [NSSortDescriptor sortDescriptorWithKey:@"index" ascending:YES];
	NSArray * parameters = [[self parameters] sortedArrayUsingDescriptor:sortByIndex];
	for (NSUInteger index = 0; index < [parameters count]; ++index) {
		NSString * keyPath = [parameters objectAtIndex:index];
		id parameterValue = [game valueForKeyPath:keyPath];
		[invocation setArgument:&parameterValue atIndex:(index+2)];
	}
	[invocation invoke];
}

@end
