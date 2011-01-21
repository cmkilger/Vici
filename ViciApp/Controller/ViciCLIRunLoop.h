//
//  ViciCLI.h
//  Vici
//
//  Created by Cory Kilger on 1/20/11.
//  Copyright 2011 Cory Kilger All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ViciCLICommandHandler.h"

@interface ViciCLIRunLoop : NSObject {
	NSArray * commandHandlers;
	id<ViciCLICommandHandler> commandHandler;
	BOOL needsMore;
}

- (void) run;

@end
