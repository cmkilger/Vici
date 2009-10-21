//
//  Condition.h
//  Vici
//
//  Created by Dave DeLong on 10/13/09.
//  Copyright 2009 Home. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Trigger;
@class ViciGame;

@interface Condition :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * predicate;
@property (nonatomic, retain) Trigger * trigger;

- (BOOL) evaluateWithGame:(ViciGame *)game;

@end



