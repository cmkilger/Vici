//
//  Trigger.h
//  Vici
//
//  Created by Dave DeLong on 10/13/09.
//  Copyright 2009 Home. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Action;

@interface Trigger :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString* event;
@property (nonatomic, retain) NSSet* actions;
@property (nonatomic, retain) NSSet* conditions;

- (void) evaluateWithGame:(ViciGame *)game;

@end


@interface Trigger (CoreDataGeneratedAccessors)
- (void)addActionsObject:(Action *)value;
- (void)removeActionsObject:(Action *)value;
- (void)addActions:(NSSet *)value;
- (void)removeActions:(NSSet *)value;

- (void)addConditionsObject:(NSManagedObject *)value;
- (void)removeConditionsObject:(NSManagedObject *)value;
- (void)addConditions:(NSSet *)value;
- (void)removeConditions:(NSSet *)value;

@end

