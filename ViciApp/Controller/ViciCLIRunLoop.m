//
//  ViciCLI.m
//  Vici
//
//  Created by Cory Kilger on 1/20/11.
//  Copyright 2011 Cory Kilger All rights reserved.
//

#import "ViciCLIRunLoop.h"
#import "ViciCore.h"
#import "ViciCLIGame.h"

@interface ViciCLIRunLoop ()

@property (nonatomic, retain) NSArray * commandHandlers;
@property (nonatomic, retain) id<ViciCLICommandHandler> commandHandler;

- (NSString *) prompt;
- (void) parse:(NSString *)command;

@end


@implementation ViciCLIRunLoop

@synthesize commandHandlers, commandHandler;

- (id) init {
	if (![super init])
		return nil;
	
	// All command handlers should be created and added to this array
	self.commandHandlers = [NSArray arrayWithObjects:
							[[[ViciCLIGame alloc] init] autorelease],
							nil];
	
	return self;
}

- (void) dealloc {
	[commandHandlers release];
	[super dealloc];
}

#pragma mark -

// This is the main loop, asking the user for input
- (void) run {
	while (YES) {;
		NSAutoreleasePool * subpool = [[NSAutoreleasePool alloc] init];
		[self parse:[self prompt]];
		[subpool release];
	}
}

// This reads in the user commands
- (NSString *) prompt {
	char command[256];
	memset(command, 0, 256);
	printf("> ");
	for (int i = 0; i < 256-1; i++) {
		char c = getchar();
		if (c == '\n')
			break;
		command[i] = c;
	}
	return [NSString stringWithCString:command encoding:NSUTF8StringEncoding];
}

// This handles the parsing of the user commands
- (void) parse:(NSString *)command {
	if ([command isEqualToString:@"help"]) {
		if (needsMore) {
			printf("%s", [[commandHandler help] cStringUsingEncoding:NSUTF8StringEncoding]);
			return;
		}
		
		printf("Main commands\n");
		printf("  help\t\t\t\t\tDisplays this message.\n");
		printf("  quit\t\t\t\t\tQuits Vici.\n");
		
		for (id<ViciCLICommandHandler> handler in commandHandlers)
			printf("\n%s", [[handler help] cStringUsingEncoding:NSUTF8StringEncoding]);
		
		return;
	}
	
	if ([command isEqualToString:@"quit"]) {
		exit(0);
	}
	
	if (needsMore) {
		BOOL more = YES;
		if ([commandHandler handleCommand:command needsMore:&more]) {
			needsMore = more;
			return;
		}
	}
	
	for (id<ViciCLICommandHandler> handler in commandHandlers) {
		BOOL more = YES;
		if ([handler handleCommand:command needsMore:&more]) {
			needsMore = more;
			if (needsMore)
				self.commandHandler = handler;
			return;
		}
	}
	
	printf("Unknown command.\n");
}

@end
