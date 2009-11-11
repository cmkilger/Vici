//
//  Round.h
//  Vici
//
//  Created by Dave DeLong on 10/13/09.
//  Copyright 2009 Home. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Battle;
@class Player;

@interface Round :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber* order;
@property (nonatomic, retain) Player * player;
@property (nonatomic, retain) NSSet* battles;

- (id) initWithManagedObjectContext:(NSManagedObjectContext *)context;

@end


@interface Round (CoreDataGeneratedAccessors)
- (void)addBattlesObject:(Battle *)value;
- (void)removeBattlesObject:(Battle *)value;
- (void)addBattles:(NSSet *)value;
- (void)removeBattles:(NSSet *)value;

@end

