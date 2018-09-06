//
//  CreditsView.h
//  Team Communicator
//
//  Created by Michael Dietz on 22.04.10.
//  Copyright 2010 MD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "ModalScreenCloser.h"

@interface AboutViewController : UIViewController <ModalScreenCloser, MFMailComposeViewControllerDelegate> {

	id delegate;
}

@property(assign) id delegate;

-(IBAction)back;
-(IBAction)sendAppFeedbackMail;
-(IBAction)showSettings;

@end
