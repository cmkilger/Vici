//
//  ViciColor.h
//  Vici
//
//  Created by Dave DeLong on 11/3/09.
//  Copyright 2009 Home. All rights reserved.
//

#import <Foundation/Foundation.h>

#if TARGET_OS_IPHONE
#import <CoreGraphics/CoreGraphics.h>
#endif


@interface ViciColor : NSObject <NSCoding> {
	CGFloat red;
	CGFloat green;
	CGFloat blue;
	CGFloat alpha;
}

@property CGFloat red;
@property CGFloat green;
@property CGFloat blue;
@property CGFloat alpha;

+ (id) colorWithRed:(CGFloat)r green:(CGFloat)g blue:(CGFloat)b alpha:(CGFloat)a;
- (id) initWithRed:(CGFloat)r green:(CGFloat)g blue:(CGFloat)b alpha:(CGFloat)a;

@end
