//
//  ActionParameter.h
//  Vici
//
//  Created by Cory Kilger on 10/20/09.
//  Copyright 2009 Cory Kilger. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Action;

@interface ActionParameter :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * keyPath;
@property (nonatomic, retain) NSNumber * index;
@property (nonatomic, retain) Action * action;

@end



