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

@property (strong, nonatomic) NSArray *titles;

@property (nonatomic) NSInteger selectedSection;
@property (weak, nonatomic) IBOutlet UITableView *collapsibleTable;

@end

@implementation ReckersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.orderView.delegate = self;
    self.orderView.dataSource = self;
    
    self.titles = @[@"Hello", @"How are you"];
    self.selectedSection = -1;
    
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
        return 2;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderCell"];
    
    if (cell) {
        // Configure the cell
        cell.textLabel.text = self.titles[indexPath.row];
    }
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView
viewForHeaderInSection:(NSInteger)section {
    
    UITableViewHeaderFooterView *header = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"orderHeader"];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 17)];
    label.text = @"Header";
    
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
