//
//  CollapsableTableViewController.h
//  Reckers
//
//  Created by David Wu on 9/27/14.
//  Copyright (c) 2014 Luke Garrison. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SectionHeaderView.h"

@interface CollapsibleTableViewController : UITableViewController <SectionHeaderViewDelegate>

@property (nonatomic) NSMutableArray *foodTypes; // Of FoodType

@end
