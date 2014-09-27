//
//  DefaultSettingsViewController.h
//  Reckers
//
//  Created by David Wu on 9/27/14.
//  Copyright (c) 2014 Luke Garrison. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface DefaultSettingsViewController : UIViewController <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>

@property (nonatomic, strong) IBOutlet UILabel *welcomeLabel;

- (IBAction)logoutButton:(id)sender;

@end
