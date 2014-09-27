//
//  DefaultSettingsViewController.m
//  Reckers
//
//  Created by David Wu on 9/27/14.
//  Copyright (c) 2014 Luke Garrison. All rights reserved.
//

#import "DefaultSettingsViewController.h"
#import "LoginViewController.h"

@interface DefaultSettingsViewController ()

@end

@implementation DefaultSettingsViewController

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	if ([PFUser currentUser]) {
		self.welcomeLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Welcome %@!", nil), [[PFUser currentUser] username]];
	}
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	
	if (![PFUser currentUser]) { // No user logged in
		// Create the log in view controller
		LoginViewController *myLoginViewController = [[LoginViewController alloc] init];
		myLoginViewController.fields = PFLogInFieldsUsernameAndPassword | PFLogInFieldsLogInButton;
		[myLoginViewController setDelegate:self]; // Set ourselves as the delegate
		
		// Present the log in view controller
		[self presentViewController:myLoginViewController animated:YES completion:NULL];
	}
	
}

- (BOOL)logInViewController:(PFLogInViewController *)logInController shouldBeginLogInWithUsername:(NSString *)username password:(NSString *)password {
	// Check if both fields are completed
	if (username && password && username.length && password.length) {
		return YES; // Begin login process
	}
	
	[[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Missing Information", nil) message:NSLocalizedString(@"Make sure you fill out all of the information!", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil] show];
	return NO; // Interrupt login process
}

// Sent to the delegate when a PFUser is logged in.
- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
	[self dismissViewControllerAnimated:YES completion:NULL];
}

// Sent to the delegate when the log in attempt fails.
- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error {
	NSLog(@"Failed to log in...");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logOutButtonTapAction:(id)sender {
	[PFUser logOut];
	[self.navigationController popViewControllerAnimated:YES];
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
