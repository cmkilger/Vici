//
//  ViciRiskMap.h
//  Vici
//
//  Created by Cory Kilger on 10/20/09.
//  Copyright 2009 Cory Kilger. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ViciCore.h"

@interface ViciRiskMap : ViciPlugin {
	NSMutableDictionary * countriesCache;
	NSMutableDictionary * cardsCache;
	NSMutableDictionary * continentsCache;
}

@end
