//
//  Setting.h
//  Vici
//
//  Created by Dave DeLong on 10/23/09.
//  Copyright 2009 Home. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Game;

@interface Setting :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * key;
@property (nonatomic, retain) NSData * dataValue;
@property (nonatomic, retain) Game * game;

@end



