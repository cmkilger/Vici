//
//  Action.h
//  Vici
//
//  Created by Dave DeLong on 10/13/09.
//  Copyright 2009 Home. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface Action :  NSManagedObject  
{
}

@property (nonatomic, retain) NSManagedObject * trigger;

@end



