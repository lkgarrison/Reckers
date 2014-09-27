//
//  FoodCell.m
//  Reckers
//
//  Created by David Wu on 9/27/14.
//  Copyright (c) 2014 Luke Garrison. All rights reserved.
//

#import "FoodCell.h"
#import "Food.h"

@implementation FoodCell

- (void)setFood:(Food *)food {
	if (_food != food) {
		_food = food;
		
		self.nameLabel.text = _food.name;
		self.priceLabel.text = [NSString stringWithFormat:@"%f", _food.price];
		self.subtext.text = _food.subtext;
	}
}

@end
