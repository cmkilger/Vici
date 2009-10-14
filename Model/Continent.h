//
//  Continent.h
//  Vici
//
//  Created by Dave DeLong on 10/13/09.
//  Copyright 2009 Home. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Country;
@class Planet;

@interface Continent :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Planet * planet;
@property (nonatomic, retain) NSSet* countries;

@end


@interface Continent (CoreDataGeneratedAccessors)
- (void)addCountriesObject:(Country *)value;
- (void)removeCountriesObject:(Country *)value;
- (void)addCountries:(NSSet *)value;
- (void)removeCountries:(NSSet *)value;

@end

