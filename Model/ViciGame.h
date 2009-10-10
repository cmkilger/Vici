//
//  ViciGame.h
//  Vici
//
//  Created by Dave DeLong on 10/9/09.
//  Copyright 2009 Home. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface ViciGame : NSObject {
	NSManagedObjectContext * context;
}

- (id) initWithManagedObjectContext:(NSManagedObjectContext *)moc;

@end
