//
//  ViciMapView.m
//  ViciMapEditor
//
//  Created by Cory Kilger on 12/15/09.
//  Copyright 2009 Cory Kilger. All rights reserved.
//

#import "ViciMapView.h"


@implementation ViciMapView

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
		[self registerForDraggedTypes:[NSArray arrayWithObjects:NSFilenamesPboardType, nil]];
    }
    return self;
}

- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender {
    return NSDragOperationCopy;
}

- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender {
    NSPasteboard * pboard = [sender draggingPasteboard];
	
	if ( [[pboard types] containsObject:NSFilenamesPboardType] ) {
        NSArray *files = [pboard propertyListForType:NSFilenamesPboardType];
		for (NSString * filePath in files) {
			NSImage * anImage = [[NSImage alloc] initWithContentsOfFile:filePath];
			if (anImage) {
				image = anImage;
				[self setNeedsDisplay:YES];
				return YES;
			}
			[anImage release];
		}
    }
    
    return NO;
}

- (void)drawRect:(NSRect)dirtyRect {
	if (image) {
		[image drawAtPoint:NSZeroPoint fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
	}
}

@end
