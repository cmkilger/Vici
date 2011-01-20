//
//  ViciCLIGame.m
//  Vici
//
//  Created by Cory Kilger on 1/20/11.
//  Copyright 2011 Rivetal, Inc. All rights reserved.
//

#import "ViciCLIGame.h"
#import "ViciCore.h"


@implementation ViciCLIGame

- (BOOL) handleCommand:(NSString *)command needsMore:(BOOL *)needsMore {
	*needsMore = NO;
	
	if ([command hasPrefix:@"new game "]) {
		NSArray * gameTypes = [[ViciPluginManager sharedManager] availableGameTypes];
		NSString * subcommand = [command substringFromIndex:9];
		
		if ([subcommand isEqualToString:@"list"]) {
			int i = 1;
			for (NSDictionary * gameType in gameTypes) {
				printf("%d: %s\n", i++, [[gameType objectForKey:kViciPluginDisplayName] cStringUsingEncoding:NSUTF8StringEncoding]);
			}
			return YES;
		}
		else {
			NSInteger gameIndex = [subcommand integerValue];
			if (gameIndex > 0 && gameIndex <= [gameTypes count]) {
				NSDictionary * gameType = [gameTypes objectAtIndex:gameIndex-1];
				printf("Chose game type: %s\n", [[gameType objectForKey:kViciPluginDisplayName] cStringUsingEncoding:NSUTF8StringEncoding]);
				return YES;
			}
		}
	}
	
	return NO;
}

- (NSString *) help {
	NSString * help = @"Game Commands\n";
	help = [help stringByAppendingString:@"  new game list\t\tDisplays a list of all available game types.\n"];
	help = [help stringByAppendingString:@"  new game <num>\t\tCreates a new game using the number from 'new game list'.\n"];
	return help;
}

@end
