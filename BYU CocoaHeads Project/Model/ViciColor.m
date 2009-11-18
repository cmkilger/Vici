//
//  ViciColor.m
//  Vici
//
//  Created by Dave DeLong on 11/3/09.
//  Copyright 2009 Home. All rights reserved.
//

#import "ViciColor.h"


@implementation ViciColor

@synthesize red, green, blue, alpha;

+ (id) colorWithRed:(CGFloat)r green:(CGFloat)g blue:(CGFloat)b alpha:(CGFloat)a {
	return [[[self alloc] initWithRed:r green:g blue:b alpha:a] autorelease];
}

- (id) initWithRed:(CGFloat)r green:(CGFloat)g blue:(CGFloat)b alpha:(CGFloat)a {
	if (self = [super init]) {
		red = r;
		green = g;
		blue = b;
		alpha = a;
	}
	return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
	CGFloat r = [aDecoder decodeFloatForKey:@"red"];
	CGFloat g = [aDecoder decodeFloatForKey:@"green"];
	CGFloat b = [aDecoder decodeFloatForKey:@"blue"];
	CGFloat a = [aDecoder decodeFloatForKey:@"alpha"];
	return [self initWithRed:r green:g blue:b alpha:a];
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeFloat:red forKey:@"red"];
	[aCoder encodeFloat:green forKey:@"green"];
	[aCoder encodeFloat:blue forKey:@"blue"];
	[aCoder encodeFloat:alpha forKey:@"alpha"];
}

@end
