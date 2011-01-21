//
//  ViciWarcraftMap.h
//  Vici
//
//  Created by Cory Kilger on 10/21/09.
//  Copyright 2009 Cory Kilger. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ViciCore.h"

@interface ViciWarcraftMap : NSObject <ViciMapPlugin> {
	NSMutableDictionary * countriesCache;
	NSMutableDictionary * continentsCache;
}

@end
