//
//  TimeRecords.h
//
//  Created by Dietz, Michael on 5/2/10.
//  Copyright 2010 MD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalRecordingItem.h"
#import <MessageUI/MessageUI.h>

@interface TimeRecords : UIViewController <MFMailComposeViewControllerDelegate, UIActionSheetDelegate> {

	PersonalRecordingItem* item;
	NSData*   exportData;
	NSString* exportFileName;
    UITableView* table;
}

@property(assign) PersonalRecordingItem* item;
@property(retain) IBOutlet UITableView* table;

-(void)exportLocally;
-(void)exportViaEmail;


@end
