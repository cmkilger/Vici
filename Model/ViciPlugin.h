//
//  ViciPlugin.h
//  Vici
//
//  Created by Dave DeLong on 10/21/09.
//  Copyright 2009 Home. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface ViciPlugin : NSObject {

}

+ (NSDictionary *) pluginDescription;

- (void) configureWithManagedObjectContext:(NSManagedObjectContext *)context;

@end
