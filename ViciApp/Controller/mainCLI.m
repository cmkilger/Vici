//
//  mainCLI.h
//  Vici
//
//  Created by Cory Kilger on 1/129/11.
//  Copyright 2009 Cory Kilger. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ViciCore.h"
#import "ViciCLI.h"

int main(int argc, char *argv[]) {
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	
	// Load plugins from specified directories
	for (int i = 1; i < argc; i++) {
		NSString * path = [NSString stringWithCString:argv[i] encoding:NSUTF8StringEncoding];
		[[ViciPluginManager sharedManager] addPluginDirectory:path];
	}
	
	ViciCLI * vici = [[ViciCLI alloc] init];
	[vici run];
	[vici release];
	
	[pool release];
	
    return 0;
}
