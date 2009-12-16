//
//  MyDocument.h
//  ViciMapEditor
//
//  Created by Robert Brown on 12/3/09.
//  Copyright 2009 BYU. All rights reserved.
//


#import <Cocoa/Cocoa.h>

@class ViciMapView;

@interface ViciMapDocument : NSDocument
{
	NSButton * territoryItem;
	NSScrollView * scrollView;
	ViciMapView * mapView;
}

@property (nonatomic, assign) IBOutlet NSButton * territoryItem;
@property (nonatomic, retain) IBOutlet NSScrollView * scrollView;
@property (nonatomic, retain) IBOutlet ViciMapView * mapView;

@end
