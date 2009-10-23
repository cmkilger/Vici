//
//  Player.h
//  Vici
//
//  Created by Dave DeLong on 10/13/09.
//  Copyright 2009 Home. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface Player :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber* order;
@property (nonatomic, retain) NSSet* countries;
@property (nonatomic, retain) NSSet* armies;
@property (nonatomic, retain) NSSet* cards;

@end


@interface Player (CoreDataGeneratedAccessors)
- (void)addCountriesObject:(NSManagedObject *)value;
- (void)removeCountriesObject:(NSManagedObject *)value;
- (void)addCountries:(NSSet *)value;
- (void)removeCountries:(NSSet *)value;

- (void)addArmiesObject:(NSManagedObject *)value;
- (void)removeArmiesObject:(NSManagedObject *)value;
- (void)addArmies:(NSSet *)value;
- (void)removeArmies:(NSSet *)value;

- (void)addCardsObject:(NSManagedObject *)value;
- (void)removeCardsObject:(NSManagedObject *)value;
- (void)addCards:(NSSet *)value;
- (void)removeCards:(NSSet *)value;

@end

