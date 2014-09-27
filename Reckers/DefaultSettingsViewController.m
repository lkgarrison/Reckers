//
//  DefaultSettingsViewController.m
//  Reckers
//
//  Created by David Wu on 9/27/14.
//  Copyright (c) 2014 Luke Garrison. All rights reserved.
//

#import "DefaultSettingsViewController.h"

@interface DefaultSettingsViewController ()

@end

@implementation DefaultSettingsViewController

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	if ([PFUser currentUser]) {
		self.welcomeLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Welcome %@!", nil), [[PFUser currentUser] username]];
	} else {
		self.welcomeLabel.text = NSLocalizedString(@"Not logged in", nil);
	}
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	if (![PFUser currentUser]) { // No user logged in
		// Create the log in view controller
		PFLogInViewController *logInViewController = [[PFLogInViewController alloc] init];
		[logInViewController setDelegate:self]; // Set ourselves as the delegate
		
		// Create the sign up view controller
		PFSignUpViewController *signUpViewController = [[PFSignUpViewController alloc] init];
		[signUpViewController setDelegate:self]; // Set ourselves as the delegate
		
		// Assign our sign up controller to be displayed from the login controller
		[logInViewController setSignUpController:signUpViewController];
		
		// Present the log in view controller
		[self presentViewController:logInViewController animated:YES completion:NULL];
	}
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
