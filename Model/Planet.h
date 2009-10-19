//
//  Planet.h
//  Vici
//
//  Created by Dave DeLong on 10/13/09.
//  Copyright 2009 Home. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface Planet :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet* continents;

- (id) initWithManagedObjectContext:(NSManagedObjectContext *)context;

@end


@interface Planet (CoreDataGeneratedAccessors)
- (void)addContinentsObject:(NSManagedObject *)value;
- (void)removeContinentsObject:(NSManagedObject *)value;
- (void)addContinents:(NSSet *)value;
- (void)removeContinents:(NSSet *)value;

@end

