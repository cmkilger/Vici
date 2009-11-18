//
//  Country.h
//  Vici
//
//  Created by Dave DeLong on 10/13/09.
//  Copyright 2009 Home. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Card;
@class Player;

@interface Country :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSManagedObject * continent;
@property (nonatomic, retain) NSSet* neighbors;
@property (nonatomic, retain) Player * player;
@property (nonatomic, retain) NSSet* armies;
@property (nonatomic, retain) Card * card;

- (id) initWithManagedObjectContext:(NSManagedObjectContext *)context;

@end


@interface Country (CoreDataGeneratedAccessors)
- (void)addNeighborsObject:(NSManagedObject *)value;
- (void)removeNeighborsObject:(NSManagedObject *)value;
- (void)addNeighbors:(NSSet *)value;
- (void)removeNeighbors:(NSSet *)value;

- (void)addArmiesObject:(NSManagedObject *)value;
- (void)removeArmiesObject:(NSManagedObject *)value;
- (void)addArmies:(NSSet *)value;
- (void)removeArmies:(NSSet *)value;

@end

