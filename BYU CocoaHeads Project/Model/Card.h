//
//  Card.h
//  Vici
//
//  Created by Dave DeLong on 10/13/09.
//  Copyright 2009 Home. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Player;

@interface Card :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSManagedObject * country;
@property (nonatomic, retain) Player * player;

- (id) initWithManagedObjectContext:(NSManagedObjectContext *)context;

@end



