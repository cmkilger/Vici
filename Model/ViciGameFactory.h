//
//  ViciGameFactory.h
//  Vici
//
//  Created by Dave DeLong on 10/12/09.
//  Copyright 2009 Home. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * kViciGameTypeID;
extern NSString * kViciGameTypeDisplayName;

extern NSString * kViciMapID;
extern NSString * kViciMapDisplayName;

extern NSString * kViciPlayerID;
extern NSString * kViciPlayerDisplayName;

@interface ViciGameFactory : NSObject {
	NSMutableArray * gameTypes;
	NSMutableArray * maps;
	NSMutableArray * players;
}

+ (ViciGameFactory *) sharedFactory;

/**
 return an array of NSDictionaries.  Each NSDictionary should have at least two keys:
 kViciGameTypeID - a reverse-DNS-style string indicating the developer of the game type.  Example: edu.byu.cocoaheads.Risk
 kViciGameTypeDisplayName - a localized string for displaying to the user.  Example: Risk
 */
- (NSArray *) availableGameTypes;

/**
 return an array of NSDictionaries.  Each NSDictionary should have at least two keys:
 kViciMapID - a reverse-DNS-style string indicating the developer of the map.  Example: edu.byu.cocoaheads.BYUCampus
 kViciMapDisplayName - a localized string for displaying to the user.  Example: BYU Campus
 */
- (NSArray *) availableMaps;

/**
 return an array of NSDictionaries.  Each NSDictionary should have at least two keys:
 kViciPlayerID - a reverse-DNS-style string indicating the developer of the map.  Example: edu.byu.cocoaheads.Human
 kViciPlayerDisplayName - a localized string for displaying to the user.  Example: Human
 */
- (NSArray *) availablePlayers;

@end
