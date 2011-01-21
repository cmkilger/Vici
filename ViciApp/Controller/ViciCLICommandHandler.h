//
//  ViciCLICommandHandler.h
//  Vici
//
//  Created by Cory Kilger on 1/20/11.
//  Copyright 2011 Rivetal, Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@protocol ViciCLICommandHandler

// When a command is issued by the user, this will be called (if it wasn't handled already).
// Return YES or NO to indicate if the command was handled.
// Set needsMore to indicate if more input is expected from the user.
// the value of needsMore will be ignored if the command was not handled.
- (BOOL) handleCommand:(NSString *)command needsMore:(BOOL*)needsMore;

// Return a string to print out when the user asks for help.
// This help string could change, for example, if the user was asked to
// respond to a question, and specific responses are expected. It would
// then be appropriate to print the options that the user can choose from.
- (NSString *) help;

@end
