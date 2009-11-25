//
//  Army.h
//  Vici
//
//  Created by Dave DeLong on 10/13/09.
//  Copyright 2009 Home. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Country;
@class Player;

@interface Army :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * experience;
@property (nonatomic, retain) Country * country;
@property (nonatomic, retain) Player * player;

- (id) initWithManagedObjectContext:(NSManagedObjectContext *)context;

@end



