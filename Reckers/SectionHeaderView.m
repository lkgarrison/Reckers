//
//  SectionHeaderView.m
//  Reckers
//
//  Created by David Wu on 9/27/14.
//  Copyright (c) 2014 Luke Garrison. All rights reserved.
//

#import "SectionHeaderView.h"

@implementation SectionHeaderView

- (void)awakeFromNib {
	UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleOpen:)];
	[self addGestureRecognizer:tapGesture];
}

- (IBAction)toggleOpen:(id)sender {
	[self toggleOpenWithUserAction:YES];
}

- (void)toggleOpenWithUserAction:(BOOL)userAction {
	self.isOpen = !self.isOpen;
	
	if (userAction) {
		if (self.isOpen) {
			if ([self.delegate respondsToSelector:@selector(sectionHeaderView:sectionOpened:)]) {
				[self.delegate sectionHeaderView:self sectionOpened:self.section];
			}
		} else {
			if ([self.delegate respondsToSelector:@selector(sectionHeaderView:sectionClosed:)]) {
				[self.delegate sectionHeaderView:self sectionClosed:self.section];
			}
		}
	}
}

@end
