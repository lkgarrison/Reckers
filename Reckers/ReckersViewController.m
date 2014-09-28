//
//  ReckersViewController.m
//  Reckers
//
//  Created by Luke Garrison on 9/27/14.
//  Copyright (c) 2014 Luke Garrison. All rights reserved.
//

#import "ReckersViewController.h"
#import "PickupView.h"


@interface ReckersViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) IBOutlet UITableView *orderView;

@property (strong, nonatomic) NSArray *pizzas;
@property (strong, nonatomic) NSArray *sandwiches;

@property (nonatomic) NSInteger selectedSection;
@property (weak, nonatomic) IBOutlet UITableView *collapsibleTable;

@end

@implementation ReckersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.orderView.delegate = self;
    self.orderView.dataSource = self;
    
    self.selectedSection = -1;
    
    self.pizzas = @[@"Pepperoni", @"Cheese"];
    self.sandwiches = @[@"Chicken", @"Turkey", @"Peanut Butter"];
    
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
                
            case 1:
                return self.sandwiches.count;
                
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
                break;
            case 1:
                cell.textLabel.text = self.sandwiches[indexPath.row];
                break;
                // ...
            case 2:
                cell.textLabel.text = NSLocalizedString(@"Piadinas", @"Piadinas");
                break;
            case 3:
                cell.textLabel.text = NSLocalizedString(@"Sides", @"Sides");
                break;
            case 4:
                cell.textLabel.text = NSLocalizedString(@"Salads", @"Salads");
                break;
            case 5:
                cell.textLabel.text = NSLocalizedString(@"Breakfast", @"Breakfast");
                break;
            default:
                cell.textLabel.text = @"";
                break;

        }
        
        cell.detailTextLabel.text = @"$2.00";
        
    }
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView
viewForHeaderInSection:(NSInteger)section {
    
    UITableViewHeaderFooterView *header = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"orderHeader"];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 17)];
    
    //test
    NSString *sectionName;
    switch (section)
    {
        case 0:
            sectionName = NSLocalizedString(@"Pizza", @"Pizza");
            break;
        case 1:
            sectionName = NSLocalizedString(@"Sandwiches", @"Sandwiches");
            break;
            // ...
        case 2:
            sectionName = NSLocalizedString(@"Piadinas", @"Piadinas");
            break;
        case 3:
            sectionName = NSLocalizedString(@"Sides", @"Sides");
            break;
        case 4:
            sectionName = NSLocalizedString(@"Salads", @"Salads");
            break;
        case 5:
            sectionName = NSLocalizedString(@"Breakfast", @"Breakfast");
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
    return 20;
}


// actions

- (IBAction)orderButtonTapped:(UIButton *)sender {
    [UIView animateWithDuration:.5
                     animations:^(void){
                         self.containerView.frame = CGRectMake(0,
                                                               self.containerView.frame.origin.y,
                                                               self.containerView.frame.size.width,
                                                               self.containerView.frame.size.height);
                     }];
    
    
}
- (IBAction)checkoutButtonTapped:(UIButton *)sender {
    [UIView animateWithDuration:.5
                     animations:^(void){
                         self.containerView.frame = CGRectMake(-self.view.frame.size.width,
                                          self.containerView.frame.origin.y,
                                          self.containerView.frame.size.width,
                                          self.containerView.frame.size.height);
                     }];
}
- (IBAction)pickupButtonTapped:(UIButton *)sender {
    [UIView animateWithDuration:.5
                     animations:^(void){
                         self.containerView.frame = CGRectMake(-2*self.view.frame.size.width,
                                                                              self.containerView.frame.origin.y,
                                                                              self.containerView.frame.size.width,
                                                                              self.containerView.frame.size.height);
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
                             withRowAnimation:UITableViewRowAnimationFade];
    }
}



@end
