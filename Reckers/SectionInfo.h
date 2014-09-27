//
//  SectionInfo.h
//  Reckers
//
//  Created by David Wu on 9/27/14.
//  Copyright (c) 2014 Luke Garrison. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SectionHeaderView;
@class FoodType;

@interface SectionInfo : NSObject

@property (getter = isOpen) BOOL open;
@property FoodType *foodType;
@property SectionHeaderView *headerView;
@property (nonatomic) NSMutableArray *rowHeights;

- (NSUInteger)countOfRowHeights;
- (id)objectInRowHeightsAtIndex:(NSUInteger)index;
- (void)insertObject:(id)object inRowHeightsAtIndex:(NSUInteger)index;
- (void)removeObjectFromRowHeightsAtIndex:(NSUInteger)index;
- (void)replaceObjectInRowHeightsAtIndex:(NSUInteger)index withObject:(id)object;
- (void)insertRowHeights:(NSArray *)array atIndexes:(NSIndexSet *)indexes;
- (void)removeRowHeightsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceRowHeightsAtIndexes:(NSIndexSet *)indexes withRowHeights:(NSArray *)array;

@end
