//
//  TeamView.h
//  Team Communicator
//
//  Created by Michael Dietz on 16.04.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModalScreenCloser.h"
#import "UIImage-NSCoding.h"
#import "PersonalRecordingItem.h"

@interface ItemCreateViewController : UIViewController <UINavigationControllerDelegate, UIAlertViewDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate> {

	IBOutlet UITextField* itemName;
	IBOutlet UITextField* itemDescription;
	IBOutlet UITextField* itemPlannedEffort;
	IBOutlet UIButton*    itemImage;
	IBOutlet UINavigationItem* header;
	
	IBOutlet UIButton* deleteButton;
	IBOutlet UILabel*  headerLabel;
	
	UIImage* pickedImage;
	
	BOOL changeMode;
	BOOL imageCheck;
	
	PersonalRecordingItem* item;
	
	id delegate;
	
	int itemType;
}

@property(assign) 	IBOutlet UITextField*        itemName;
@property(assign) 	IBOutlet UITextField*        itemDescription;
@property(assign) 	IBOutlet UIButton* itemImage;
@property(assign) 	IBOutlet UIButton* deleteButton;
@property(assign) 	IBOutlet UILabel*  headerLabel;
@property(assign) 	IBOutlet UINavigationItem* header;

@property(assign)   PersonalRecordingItem* item;
@property(assign)   int itemType;

@property(assign) 	id delegate;

-(void)set2ChangeMode;

-(IBAction)done;
-(IBAction)cancel;
-(IBAction)selectImage;
-(void)selectImageReally;
-(IBAction)deleteItem;

@end
