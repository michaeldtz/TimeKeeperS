//
//  Team_CommunicatorAppDelegate.h
//  Team Communicator
//
//  Created by Michael Dietz on 16.04.10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

@interface TimeKeeperAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

