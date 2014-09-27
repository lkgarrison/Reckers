//
//  ReckersViewController.m
//  Reckers
//
//  Created by Luke Garrison on 9/27/14.
//  Copyright (c) 2014 Luke Garrison. All rights reserved.
//

#import "ReckersViewController.h"
#import "PickupView.h"


@interface ReckersViewController ()

@property (weak, nonatomic) IBOutlet UIView *containerView;


@end

@implementation ReckersViewController
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

@end
