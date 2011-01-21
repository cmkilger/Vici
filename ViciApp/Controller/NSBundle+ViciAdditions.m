//
//  NSBundle+ViciAdditions.m
//  Vici
//
//  Created by Cory Kilger on 1/21/11.
//  Copyright 2011 Cory Kilger All rights reserved.
//

#import "NSBundle+ViciAdditions.h"
#import "ViciCLI.h"


@implementation NSBundle (ViciAdditions)

+ (NSBundle *) viciBundle {
	NSString * path = ViciApplicationSupportPath();
	path = [path stringByAppendingPathComponent:@"ViciCLI.bundle"];
	return [NSBundle bundleWithPath:path];
}

@end
