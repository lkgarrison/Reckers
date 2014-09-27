//
//  CollapsableTableViewController.m
//  Reckers
//
//  Created by David Wu on 9/27/14.
//  Copyright (c) 2014 Luke Garrison. All rights reserved.
//

#import "CollapsibleTableViewController.h"
#import <Parse/Parse.h>
#import "FoodCell.h"
#import "SectionInfo.h"
#import "FoodType.h"
#import "Food.h"

@interface CollapsibleTableViewController ()
@property (nonatomic) NSIndexPath *indexPath;
@end

static NSString *SectionHeaderViewIdentifier = @"SectionHeaderViewIdentifier";

@interface CollapsibleTableViewController()

@property (nonatomic) NSMutableArray *sectionInfoArray;
@property (nonatomic) NSInteger openSectionIndex;
@property (nonatomic) IBOutlet SectionHeaderView *sectionHeaderView;
@property (nonatomic) NSInteger uniformRowHeight;

@end

static int CELL_HEIGHT = 88;

@implementation CollapsibleTableViewController

- (BOOL)canBecomeFirstResponder {
	return YES;
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	/*
	if (_foodTypes == nil) {
		NSString *url = [[NSBundle mainBundle] pathForResource:@"Menu" ofType:@"plist"];
		NSArray *foodTypesDictionariesArray = [[NSArray alloc] initWithContentsOfFile:url];
		_Sides = [[NSMutableArray alloc] init];
		_AmericanFare = [[NSMutableArray alloc] init];
		_Piadina = [[NSMutableArray alloc] init];
		_Pizza = [[NSMutableArray alloc] init];
		_Salad = [[NSMutableArray alloc] init];
		_Breakfast = [[NSMutableArray alloc] init];
		_foodTypes = [NSMutableArray arrayWithCapacity:[foodTypesDictionariesArray count]];
		
		for (NSDictionary *foodTypeDictionary in foodTypesDictionariesArray) {
			Food *food = [[Food alloc] init];
			food.name = foodTypeDictionary[@"foodCategory"];
			if ([food.name isEqualToString:@"Breakfast"]) {
				[self.Breakfast addObject:food];
			} else if ([food.name isEqualToString:@"Salad"]) {
				[self.Salad addObject:food];
			} else if ([food.name isEqualToString:@"Pizza"]) {
				[self.Pizza addObject:food];
			} else if ([food.name isEqualToString:@"Piadanas"]) {
				[self.Piadina addObject:food];
			} else if ([food.name isEqualToString:@"American Fare"]) {
				[self.AmericanFare addObject:food];
			} else if ([food.name isEqualToString:@"Sides"]) {
				[self.Sides addObject:food];
			}
			[_foodTypes addObject:food];
		}
	}
	
	*/
	// Check if user has signed in
	if (![PFUser currentUser]) {
		[self dismissViewControllerAnimated:YES completion:^(void) {
			[self performSegueWithIdentifier:@"gotoLogin" sender:self];
		}];
	}
	
	// Send request for menu
	PFQuery *query = [PFQuery queryWithClassName:@"Menu"];
	[query selectKeys:@[@"foodCategory", @"item", @"price", @"description"]];
	NSArray *queryResponse = [query findObjects:nil]; // Receive PFObjects
	self.foodTypes = [[NSMutableArray alloc] initWithCapacity:[queryResponse count]];
	
	for (PFObject *object in queryResponse) {
		Food *newFood = [[Food alloc]initWithName:[object objectForKey:@"item"]
											Price:[object objectForKey:@"price"]
									  Description:[object objectForKey:@"description"]
										 Category:[object objectForKey:@"foodCategory"]];
		//FoodType *newFoodType = [[FoodType alloc] initWithName:[object objectForKey:@"foodCategory"] Food:newFood];
		if (![self.foodTypes containsObject:[object objectForKey:@"foodCategory"]]) {
			// Create new food category if none exists
			[self.foodTypes addObject:[object objectForKey:@"foodCategory"]];
		} else {
			// Add food to existing catagories
			for (NSInteger i = 0; i < [self.foodTypes count]; ++i) {
				if ([[self.foodTypes[i] category] isEqualToString:[newFood category]]) {
					[self.foodTypes[i] addObject:newFood];
					break;
				}
			}
		}
	}
	
	if ((self.sectionInfoArray == nil) ||
		([self.sectionInfoArray count] != [self numberOfSectionsInTableView:self.tableView])) {
		NSMutableArray *infoArray = [[NSMutableArray alloc] init];
		
		for (FoodType *foodType in self.foodTypes) {
			SectionInfo *sectionInfo = [[SectionInfo alloc] init];
			sectionInfo.foodType = foodType;
			sectionInfo.open = NO;
			
			NSNumber *defaultRowHeight = [NSNumber numberWithInt:CELL_HEIGHT];
			NSInteger foodTypeCount = [[sectionInfo.foodType foods] count];
			for (NSInteger i = 0; i < foodTypeCount; ++i) {
				[sectionInfo insertObject:defaultRowHeight inRowHeightsAtIndex:i];
			}
			
			[infoArray addObject:sectionInfo];
		}
		
		self.sectionInfoArray = infoArray;
	}
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.tableView.sectionHeaderHeight = CELL_HEIGHT;
	self.uniformRowHeight = CELL_HEIGHT;
	self.openSectionIndex = NSNotFound;
	
	UINib *sectionHeaderNib = [UINib nibWithNibName:@"SectionHeaderView" bundle:nil];
	[self.tableView registerNib:sectionHeaderNib forHeaderFooterViewReuseIdentifier:SectionHeaderViewIdentifier];
}

- (BOOL)tableView:(UITableView *)tableView canCollapseSection:(NSInteger)section {
	return section > 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
	return [self.foodTypes count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	SectionInfo *sectionInfo = (self.sectionInfoArray)[section];
	NSInteger numCellsInSection = [[sectionInfo.foodType foods] count];
	
	return sectionInfo.open ? numCellsInSection : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *FoodCellIdentifier = @"FoodCellIdentifier";
	
    FoodCell *cell = [tableView dequeueReusableCellWithIdentifier:FoodCellIdentifier];
    
	FoodType *foodType = (FoodType *)[(self.sectionInfoArray)[indexPath.section] food];
	cell.food = (foodType.foods)[indexPath.row];
	
	return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	SectionHeaderView *sectionHeaderView = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:SectionHeaderViewIdentifier];
	
	SectionInfo *sectionInfo = (self.sectionInfoArray)[section];
	sectionInfo.headerView = sectionHeaderView;
	
	sectionHeaderView.titleLabel.text = sectionInfo.foodType.name;
	sectionHeaderView.section = section;
	sectionHeaderView.delegate = self;
	
	return sectionHeaderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	SectionInfo *sectionInfo = (self.sectionInfoArray)[indexPath.section];
	return [[sectionInfo objectInRowHeightsAtIndex:indexPath.row] floatValue];
}

- (void)sectionHeaderView:(SectionHeaderView *)sectionHeaderView sectionOpened:(NSInteger)section {
	SectionInfo *sectionInfo = (self.sectionInfoArray)[section];
	sectionInfo.open = YES;
	
	// Create an array containing the index paths of the rows to be inserted
	NSInteger rowsToInsertCount = [[sectionInfo.foodType foods] count];
	NSMutableArray *indexPathsToInsert = [[NSMutableArray alloc] init];
	for (NSInteger i = 0; i < rowsToInsertCount; ++i) {
		[indexPathsToInsert addObject:[NSIndexPath indexPathForRow:i inSection:section]];
	}
	
	// Create an array containing the index paths of the rows to be deleted
	NSMutableArray *indexPathsToDelete = [[NSMutableArray alloc] init];
	NSInteger oldOpenSectionIndex = self.openSectionIndex;
	if (oldOpenSectionIndex != NSNotFound) {
		SectionInfo *oldOpenSection = (self.sectionInfoArray)[oldOpenSectionIndex];
		oldOpenSection.open = NO;
		[oldOpenSection.headerView toggleOpenWithUserAction:NO];
		NSInteger rowsToDeleteCount = [oldOpenSection.foodType.foods count];
		for (NSInteger i = 0; i < rowsToDeleteCount; ++i) {
			[indexPathsToDelete addObject:[NSIndexPath indexPathForRow:i inSection:oldOpenSectionIndex]];
		}
	}
	
	UITableViewRowAnimation insertAnimation, deleteAnimation;
	if (oldOpenSectionIndex == NSNotFound || section < oldOpenSectionIndex) {
		insertAnimation = UITableViewRowAnimationTop;
		deleteAnimation = UITableViewRowAnimationBottom;
	} else {
		insertAnimation = UITableViewRowAnimationBottom;
		deleteAnimation = UITableViewRowAnimationTop;
	}
	
	[self.tableView beginUpdates];
	[self.tableView insertRowsAtIndexPaths:indexPathsToInsert withRowAnimation:insertAnimation];
	[self.tableView deleteRowsAtIndexPaths:indexPathsToDelete withRowAnimation:deleteAnimation];
	[self.tableView endUpdates];
	
	self.openSectionIndex = section;
}

- (void)sectionHeaderView:(SectionHeaderView *)sectionHeaderView sectionClosed:(NSInteger)section {
	SectionInfo *sectionInfo = (self.sectionInfoArray)[section];
	sectionInfo.open = NO;
	
	NSInteger rowsToDeleteCount = [self.tableView numberOfRowsInSection:section];
	
	if (rowsToDeleteCount > 0) {
		NSMutableArray *indexPathsToDelete = [[NSMutableArray alloc] init];
		for (NSInteger i = 0; i < rowsToDeleteCount; ++i) {
			[indexPathsToDelete addObject:[NSIndexPath indexPathForRow:i inSection:section]];
		}
		[self.tableView deleteRowsAtIndexPaths:indexPathsToDelete withRowAnimation:UITableViewRowAnimationTop];
	}
	self.openSectionIndex = NSNotFound;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
