//
//  ViciBYUMap.h
//  Vici
//
//  Created by Robert Brown on 10/31/09.
//  Copyright 2009 BYU. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ViciCore.h"

@interface ViciBYUMap : NSObject <ViciMapPlugin> {
	NSMutableDictionary * countriesCache;
	NSMutableDictionary * cardsCache;
	NSMutableDictionary * continentsCache;
}

@end
