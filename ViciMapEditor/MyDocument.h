//
//  MyDocument.h
//  ViciMapEditor
//
//  Created by Robert Brown on 12/3/09.
//  Copyright 2009 BYU. All rights reserved.
//


#import <Cocoa/Cocoa.h>

@interface MyDocument : NSDocument
{
	NSButton * territoryItem;
}

@property (nonatomic, assign) IBOutlet NSButton * territoryItem;

@end
