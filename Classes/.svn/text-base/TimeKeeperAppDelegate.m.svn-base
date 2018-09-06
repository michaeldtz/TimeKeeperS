	//
	//  Team_CommunicatorAppDelegate.m
	//  Team Communicator
	//
	//  Created by Michael Dietz on 16.04.10.
	//  Copyright __MyCompanyName__ 2010. All rights reserved.
	//

#import "TimeKeeperAppDelegate.h"
#import "MainViewController.h"
#import "ItemTypeManager.h"

@implementation TimeKeeperAppDelegate

@synthesize window;
@synthesize navigationController;


#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
		// Override point for customization after app launch    
	[ItemTypeManager getInstance];
	
	[window addSubview:[navigationController view]];
    [window makeKeyAndVisible];

}


- (void)applicationWillTerminate:(UIApplication *)application {
		// Save data if appropriate
	[CacheDataManager saveItemList];
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}


@end

