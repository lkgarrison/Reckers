//
//  FoodType.h
//  Reckers
//
//  Created by David Wu on 9/27/14.
//  Copyright (c) 2014 Luke Garrison. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Food.h"

@interface FoodType : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSMutableArray *foods;

- (instancetype)initWithName:(NSString *)name Food:(Food *)food;
+ (NSString *)name;

@end