//
//  Action.h
//  Vici
//
//  Created by Cory Kilger on 10/20/09.
//  Copyright 2009 Cory Kilger. All rights reserved.
//

#import <CoreData/CoreData.h>

@class ActionParameter;
@class Trigger;

@interface Action :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * selector;
@property (nonatomic, retain) NSNumber * index;
@property (nonatomic, retain) Trigger * trigger;
@property (nonatomic, retain) NSSet* parameters;

- (void) evaluateWithGame:(ViciGame *)game;

@end


@interface Action (CoreDataGeneratedAccessors)
- (void)addParametersObject:(ActionParameter *)value;
- (void)removeParametersObject:(ActionParameter *)value;
- (void)addParameters:(NSSet *)value;
- (void)removeParameters:(NSSet *)value;

@end

