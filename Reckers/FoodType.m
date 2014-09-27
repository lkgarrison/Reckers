//
//  FoodType.m
//  Reckers
//
//  Created by David Wu on 9/27/14.
//  Copyright (c) 2014 Luke Garrison. All rights reserved.
//

#import "FoodType.h"

@implementation FoodType

- (instancetype)initWithName:(NSString *)name Food:(Food *)food {
	self = [super init];
	self.name = name;
	[self.foods addObject:food];
	return self;
}

- (NSString *)name {
	return self.name;
}

- (BOOL)isEqual:(id)object {
	return [self.name isEqualToString:[object name]];
}

@end
