//
//  Food.h
//  Reckers
//
//  Created by David Wu on 9/27/14.
//  Copyright (c) 2014 Luke Garrison. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Food : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) NSString *subtext;
@property (nonatomic, strong) NSString *category;

- (instancetype)initWithName:(NSString *)string Price:(NSNumber *)price Description:(NSString *)subtext Category:(NSString *)category;

+ (NSString *)category;

@end
