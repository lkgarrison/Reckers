//
//  Food.m
//  Reckers
//
//  Created by David Wu on 9/27/14.
//  Copyright (c) 2014 Luke Garrison. All rights reserved.
//

#import "Food.h"

@implementation Food

- (instancetype)initWithName:(NSString *)name Price:(NSNumber *)price Description:(NSString *)subtext Category:(NSString *)category {
	self = [super init];
	self.name = name;
	self.price = price;
	self.subtext = subtext;
	self.category = category;
	return self;
}

+ (NSString *)category {
	return self.category;
}

@end
