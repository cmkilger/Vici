//
//  Battle.h
//  Vici
//
//  Created by Dave DeLong on 10/13/09.
//  Copyright 2009 Home. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface Battle :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber* order;
@property (nonatomic, retain) NSManagedObject * round;
@property (nonatomic, retain) NSManagedObject * defendingCountry;
@property (nonatomic, retain) NSManagedObject * attackingCountry;
@property (nonatomic, retain) NSManagedObject * defender;

- (id) initWithManagedObjectContext:(NSManagedObjectContext *)context;

@end



