//
//  TeamView.h
//  Team Communicator
//
//  Created by Michael Dietz on 16.04.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalRecordingItem.h"
#import "ItemCreateViewController.h"
#import <MessageUI/MessageUI.h>
#import "OutputFormatter.h"

@interface ItemViewController : UIViewController <UINavigationControllerDelegate, MFMailComposeViewControllerDelegate, ModalScreenCloser> {

	PersonalRecordingItem* recordingitem;

	IBOutlet UILabel*     teamName;
	IBOutlet UILabel*     teamKeywords;
	IBOutlet UIImageView* teamImage;
	
	IBOutlet UILabel* plannedEffortLabel;
	IBOutlet UILabel* actualEffortLabel;
	IBOutlet UILabel* lastTimeRecord;
	
	IBOutlet UIButton* startStopButton;
	
	ItemCreateViewController* itemController;
	
	NSTimer* timer;
}

@property(assign) 	IBOutlet UILabel* teamName;
@property(assign) 	IBOutlet UILabel* teamKeywords;
@property(assign) 	IBOutlet UIImageView* teamImage;

@property(assign) 	IBOutlet UILabel* plannedEffortLabel;
@property(assign) 	IBOutlet UILabel* actualEffortLabel;
@property(assign) 	IBOutlet UILabel* lastTimeRecord;

@property(assign)   IBOutlet UIButton* startStopButton;

@property(assign)   PersonalRecordingItem* recordingitem;


-(void)refreshUI;
-(IBAction)editItem;
-(IBAction)recordTime;
-(IBAction)showTimeRecords;
-(IBAction)startStopTimeRecording;
-(void)refreshQuickRecordingButtonLabel;

@end
