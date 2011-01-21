//
//  Battle.h
//  Vici
//
//  Created by Dave DeLong on 10/13/09.
//  Copyright 2009 Home. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Round;
@class Country;
@class Player;

@interface Battle :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber* order;
@property (nonatomic, retain) Round * round;
@property (nonatomic, retain) Country * defendingCountry;
@property (nonatomic, retain) Country * attackingCountry;
@property (nonatomic, retain) Player * defender;

- (id) initWithManagedObjectContext:(NSManagedObjectContext *)context;

@end



