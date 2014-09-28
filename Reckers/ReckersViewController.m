//
//  ReckersViewController.m
//  Reckers
//
//  Created by Luke Garrison on 9/27/14.
//  Copyright (c) 2014 Luke Garrison. All rights reserved.
//

#import "ReckersViewController.h"
#import "PickupView.h"
#import <Parse/Parse.h>


@interface ReckersViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) IBOutlet UITableView *orderView;

@property (strong, nonatomic) NSMutableArray *pizzas;
@property (strong, nonatomic) NSMutableArray *pizzaPrices;
@property (strong, nonatomic) NSMutableArray *breakfasts;
@property (strong, nonatomic) NSMutableArray *breakfastPrices;
@property (strong, nonatomic) NSMutableArray *sides;
@property (strong, nonatomic) NSMutableArray *sidePrices;
@property (strong, nonatomic) NSMutableArray *american;
@property (strong, nonatomic) NSMutableArray *americanPrices;
@property (strong, nonatomic) NSMutableArray *salads;
@property (strong, nonatomic) NSMutableArray *saladPrices;
@property (strong, nonatomic) NSMutableArray *piadinas;
@property (strong, nonatomic) NSMutableArray *piadinaPrices;

@property (nonatomic) NSInteger selectedSection;
@property (weak, nonatomic) IBOutlet UITableView *collapsibleTable;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftContainerConstraint;

@end

@implementation ReckersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.pizzas = [[NSMutableArray alloc] init];
	self.pizzaPrices = [[NSMutableArray alloc] init];
	self.breakfasts = [[NSMutableArray alloc] init];
	self.breakfastPrices = [[NSMutableArray alloc] init];
	self.sides = [[NSMutableArray alloc] init];
	self.sidePrices = [[NSMutableArray alloc] init];
	self.american = [[NSMutableArray alloc] init];
	self.americanPrices = [[NSMutableArray alloc] init];
	self.salads = [[NSMutableArray alloc] init];
	self.saladPrices = [[NSMutableArray alloc] init];
	self.piadinas = [[NSMutableArray alloc] init];
	self.piadinaPrices = [[NSMutableArray alloc] init];
    
    self.orderView.delegate = self;
    self.orderView.dataSource = self;
    
    self.selectedSection = -1;
	
	PFQuery *query = [PFQuery queryWithClassName:@"Menu"];
	[query selectKeys:@[@"foodCategory", @"item", @"price", @"description"]];
	NSArray *queryResponse = [query findObjects:nil];
	for (NSDictionary *foodDict in queryResponse) {
		NSString *foodType = [foodDict objectForKey:@"foodCategory"];
		NSString *foodName = [foodDict objectForKey:@"item"];
		NSNumber *foodPrice = [foodDict objectForKey:@"price"];
		if ([foodType isEqualToString:@"Pizza"]) {
			[self.pizzas addObject:foodName];
			[self.pizzaPrices addObject:foodPrice];
		} else if ([foodType isEqualToString:@"Breakfast"]) {
			[self.breakfasts addObject:foodName];
			[self.breakfastPrices addObject:foodPrice];
		} else if ([foodType isEqualToString:@"Sides"]) {
			[self.sides addObject:foodName];
			[self.sidePrices addObject:foodPrice];
		} else if ([foodType isEqualToString:@"American Fare"]) {
			[self.american addObject:foodName];
			[self.americanPrices addObject:foodPrice];
		} else if ([foodType isEqualToString:@"Salad"]) {
			[self.salads addObject:foodName];
			[self.saladPrices addObject:foodPrice];
		} else if ([foodType isEqualToString:@"Piadinas"]) {
			[self.piadinas addObject:foodName];
			[self.piadinaPrices addObject:foodPrice];
		}
	}
    
}

- (void)viewDidAppear:(BOOL)animated {
    [self orderButtonTapped:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // TODO: CHANGE
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    if (self.selectedSection == -1) {
        return 0;
    } else if (section == self.selectedSection) {
        
        switch (section) {
            case 0:
                return self.pizzas.count;
				break;
            case 1:
                return self.american.count;
				break;
			case 2:
				return self.piadinas.count;
				break;
			case 3:
				return self.sides.count;
				break;
			case 4:
				return self.salads.count;
				break;
			case 5:
				return self.breakfasts.count;
				break;
            default:
                return 2;
        }
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderCell"];
    
    if (cell) {
        // Configure the cell
        
        switch (indexPath.section) {
            case 0:
                cell.textLabel.text = self.pizzas[indexPath.row];
				cell.detailTextLabel.text = [NSString stringWithFormat:@"$%@", self.pizzaPrices[indexPath.row]];
                break;
            case 1:
                cell.textLabel.text = self.american[indexPath.row];
                cell.detailTextLabel.text = [NSString stringWithFormat:@"$%@", self.americanPrices[indexPath.row]];

                break;
            case 2:
                cell.textLabel.text = self.piadinas[indexPath.row];
                cell.detailTextLabel.text = [NSString stringWithFormat:@"$%@", self.piadinaPrices[indexPath.row]];
                break;
            case 3:

                cell.textLabel.text = self.sides[indexPath.row];
                cell.detailTextLabel.text = [NSString stringWithFormat:@"$%@", self.sidePrices[indexPath.row]];
                break;
            case 4:
				cell.textLabel.text = self.salads[indexPath.row];
				cell.detailTextLabel.text = [NSString stringWithFormat:@"$%@", self.saladPrices[indexPath.row]];
                break;
            case 5:
                cell.textLabel.text = self.breakfasts[indexPath.row];
                cell.detailTextLabel.text = [NSString stringWithFormat:@"$%@", self.breakfastPrices[indexPath.row]];

                break;
            default:
                cell.textLabel.text = @"";
                break;

        }
    }
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView
viewForHeaderInSection:(NSInteger)section {
    
    UITableViewHeaderFooterView *header = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"orderHeader"];

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, tableView.frame.size.width, 48)];
    label.text = @"Header";
	label.font = [UIFont fontWithName:@"Montserrat-Regular" size:45];
    label.textColor = [UIColor whiteColor];
   
    //test
    NSString *sectionName;
    switch (section)
    {
        case 0:
            sectionName = NSLocalizedString(@"Pizza", @"Pizza");
            {
                NSData *imgData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"1-pizza" ofType:@"png"]];
                UIImage *img = [UIImage imageWithData:imgData];
                UIImageView *imageView = [[UIImageView alloc] initWithImage:img];
                [header setBackgroundView:imageView];
            }
            break;
            
        case 1:
            sectionName = NSLocalizedString(@"Sandwiches", @"Sandwiches");
        {
            NSData *imgData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"2-sandwiches" ofType:@"png"]];
            UIImage *img = [UIImage imageWithData:imgData];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:img];
            [header setBackgroundView:imageView];
        }
            break;
            // ...
        case 2:
            sectionName = NSLocalizedString(@"Piadinas", @"Piadinas");
        {
            NSData *imgData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"3-piadina" ofType:@"png"]];
            UIImage *img = [UIImage imageWithData:imgData];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:img];
            [header setBackgroundView:imageView];
        }
            break;
        case 3:
            sectionName = NSLocalizedString(@"Sides", @"Sides");
        {
            NSData *imgData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"4-sides" ofType:@"png"]];
            UIImage *img = [UIImage imageWithData:imgData];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:img];
            [header setBackgroundView:imageView];
        }
            break;
        case 4:
            sectionName = NSLocalizedString(@"Salads", @"Salads");
        {
            NSData *imgData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"5-salads" ofType:@"png"]];
            UIImage *img = [UIImage imageWithData:imgData];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:img];
            [header setBackgroundView:imageView];
        }
            break;
        case 5:
            sectionName = NSLocalizedString(@"Breakfast", @"Breakfast");
        {
            NSData *imgData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"6-breakfast" ofType:@"png"]];
            UIImage *img = [UIImage imageWithData:imgData];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:img];
            [header setBackgroundView:imageView];
        }
            break;
        default:
            sectionName = @"";
            break;
    }
    
    
    
    //@"Pizza"
    label.text = sectionName;
    
    header.tag = section;
    
    [header addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                         action:@selector(sectionTapped:)]];
    
    [header.contentView addSubview:label];
    
    
    return header;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 88;
}


// actions

- (IBAction)orderButtonTapped:(UIButton *)sender {
    [UIView animateWithDuration:.5
                     animations:^(void){
//                         self.containerView.frame = CGRectMake(0,
//                                                               self.containerView.frame.origin.y,
//                                                               self.containerView.frame.size.width,
//                                                               self.containerView.frame.size.height);
                         self.leftContainerConstraint.constant =  -16;
                         [self.view layoutIfNeeded];
                     }];
    
    
}
- (IBAction)checkoutButtonTapped:(UIButton *)sender {
    [UIView animateWithDuration:.5
                     animations:^(void){
//                         self.containerView.frame = CGRectMake(-self.view.frame.size.width,
//                                          self.containerView.frame.origin.y,
//                                          self.containerView.frame.size.width,
//                                          self.containerView.frame.size.height);
                         self.leftContainerConstraint.constant = -self.view.frame.size.width - 16;
                         [self.view layoutIfNeeded];
                     }];
}
- (IBAction)pickupButtonTapped:(UIButton *)sender {
    [UIView animateWithDuration:.5
                     animations:^(void){
//                         self.containerView.frame = CGRectMake(-2*self.view.frame.size.width,
//                                                                              self.containerView.frame.origin.y,
//                                                                              self.containerView.frame.size.width,
//                                                                              self.containerView.frame.size.height);
                         self.leftContainerConstraint.constant = -2*self.view.frame.size.width - 16;
                         
                         [self.view layoutIfNeeded];
                     }];
    
    
}

-(void)sectionTapped:(UITapGestureRecognizer*)tap {

    if (tap.view.tag == self.selectedSection) {
        self.selectedSection = -1;
        [self.collapsibleTable reloadSections:[NSIndexSet indexSetWithIndex:tap.view.tag]
                             withRowAnimation:UITableViewRowAnimationFade];
    } else {
        NSInteger oldSection = self.selectedSection;
        
        self.selectedSection = tap.view.tag;
        [self.collapsibleTable reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 6)]
                             withRowAnimation:UITableViewRowAnimationFade
         ];
    }
}



@end
