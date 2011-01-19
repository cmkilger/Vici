//
//  mainCLI.h
//  Vici
//
//  Created by Cory Kilger on 1/129/11.
//  Copyright 2009 Cory Kilger. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ViciCore.h"

void ParseCommand(NSString * command);

int main(int argc, char *argv[]) {
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	
	// Load plugins from specified directories
	for (int i = 1; i < argc; i++) {
		NSString * path = [NSString stringWithCString:argv[i] encoding:NSUTF8StringEncoding];
		[[ViciPluginManager sharedManager] addPluginDirectory:path];
	}
	
	// Loop for commands
	char command[256];
	while (strcmp(command, "quit")) {;
		NSAutoreleasePool * subpool = [[NSAutoreleasePool alloc] init];
		memset(command, 0, 256);
		printf("> ");
		for (int i = 0; i < 256-1; i++) {
			char c = getchar();
			if (c == '\n')
				break;
			command[i] = c;
		}
		ParseCommand([NSString stringWithCString:command encoding:NSUTF8StringEncoding]);
		[subpool release];
	}
	
	[pool release];
	
    return 0;
}

void ParseCommand(NSString * command) {
	if ([command isEqualToString:@"new game"]) {
		printf("What type of game?\n");
		NSArray * gameTypes = [[ViciPluginManager sharedManager] availableGameTypes];
		int i = 1;
		for (NSDictionary * gameType in gameTypes) {
			printf("  %d: %s\n", i++, [[gameType objectForKey:kViciPluginDisplayName] cStringUsingEncoding:NSUTF8StringEncoding]);
		}
	}
	else {
		printf("Unknown command.\n");
	}

}