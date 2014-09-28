//
//  DefaultSettingsViewController.m
//  Reckers
//
//  Created by David Wu on 9/27/14.
//  Copyright (c) 2014 Luke Garrison. All rights reserved.
//

#import "ReckersLoginViewController.h"

@interface ReckersLoginViewController ()

@end

@implementation ReckersLoginViewController

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	
	if (![PFUser currentUser]) { // No user logged in
		// Create the log in view controller
		PFLogInViewController *myLoginViewController = [[PFLogInViewController alloc] init];
		myLoginViewController.fields = PFLogInFieldsUsernameAndPassword | PFLogInFieldsLogInButton;
		[myLoginViewController setDelegate:self]; // Set ourselves as the delegate
		
		// Present the log in view controller
		[self presentViewController:myLoginViewController animated:YES completion:NULL];
	} else {
		[self performSegueWithIdentifier:@"gotoMenu" sender:self];
	}
}

- (BOOL)logInViewController:(PFLogInViewController *)logInController shouldBeginLogInWithUsername:(NSString *)username password:(NSString *)password {
	// Check if both fields are completed
	if (username && password && username.length && password.length) {
		return YES; // Begin login process
	}
	
	[[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Missing Information", nil) message:NSLocalizedString(@"Please enter your netID and password.", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil] show];
	return NO; // Interrupt login process
}

// Sent to the delegate when a PFUser is logged in.
- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
	//NSLog(@"Logged in.");
	//[self dismissViewControllerAnimated:YES completion:NULL];
	[self dismissViewControllerAnimated:YES completion:^(void) {
		[self performSegueWithIdentifier:@"gotoMenu" sender:self];
	}];
}

// Sent to the delegate when the log in attempt fails.
- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error {
	NSLog(@"Failed to log in.");
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
