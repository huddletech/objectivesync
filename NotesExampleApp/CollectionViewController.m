//
//  CollectionViewController.m
//  BulletproofTiger
//
//  Created by Justin Cunningham on 4/28/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "CollectionViewController.h"
#import "ConnectionManager.h"


@implementation CollectionViewController
@synthesize toolbarItems, loadingView;

- (void) loadStarted {
	[self.loadingView startAnimating];
}

- (void) loadCompleted:(NSNumber *)status {
	[self.loadingView stopAnimating:status];
}

- (void) loadCollection {
	[self loadStarted];
	[[ConnectionManager sharedInstance] runJob:@selector(asyncLoadCollection) onTarget:self];
}

- (void) asyncLoadCollection {
	
}

- (void) syncCompleteWithSuccess:(BOOL)success {
	if (success) {
		[self loadCollection];
	}
}

- (void)viewWillAppear:(BOOL)animated {
	self.toolbarItems = [self setupToolbarItems];
	
	[self loadCollection];
    
	[super viewWillAppear:animated];
}

- (NSArray *)setupToolbarItems {
	self.loadingView = [[[LoadingView alloc] initWithLoadingView] autorelease];
	return [NSArray arrayWithObjects:
		[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(loadCollection)],
		[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
		loadingView,
		[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
		[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonPressed)],
		nil];
}

- (void)dealloc {
	[loadingView release];
	[toolbarItems release];
    [super dealloc];
}


@end

