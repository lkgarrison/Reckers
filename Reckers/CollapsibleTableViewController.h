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

@property (nonatomic) NSMutableArray *foodTypes;
@property (nonatomic, strong) NSMutableArray *Sides;
@property (nonatomic, strong) NSMutableArray *AmericanFare;
@property (nonatomic, strong) NSMutableArray *Piadina;
@property (nonatomic, strong) NSMutableArray *Pizza;
@property (nonatomic, strong) NSMutableArray *Salad;
@property (nonatomic, strong) NSMutableArray *Breakfast;

@end
