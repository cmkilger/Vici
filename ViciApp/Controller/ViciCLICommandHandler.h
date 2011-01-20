//
//  ViciCLICommandHandler.h
//  Vici
//
//  Created by Cory Kilger on 1/20/11.
//  Copyright 2011 Rivetal, Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@protocol ViciCLICommandHandler

- (BOOL) handleCommand:(NSString *)command needsMore:(BOOL*)needsMore;
- (NSString *) help;

@end
