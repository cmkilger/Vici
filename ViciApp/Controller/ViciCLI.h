/*
 *  ViciCLI.h
 *  Vici
 *
 *  Created by Cory Kilger on 1/21/11.
 *  Copyright 2011 Cory Kilger All rights reserved.
 *
 */

#import <Foundation/Foundation.h>
#import "NSBundle+ViciAdditions.h"

static inline NSString * ViciApplicationSupportPath() {
	NSString * path = [NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES) lastObject];
	return [path stringByAppendingPathComponent:@"Vici"];
}
