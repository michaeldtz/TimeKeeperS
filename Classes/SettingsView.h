//
//  SettingsView.h
//  TimeKeeper
//
//  Created by Michael Dietz on 06.12.10.
//  Copyright 2010 SAP MD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModalScreenCloser.h"

@interface SettingsView : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {

	id delegate;
	NSMutableArray* itemTypes;
	UITextField*    typeChangeTF;
	UIPickerView*   pickerView;
	int selectedRow;
	
}


@property(assign) IBOutlet UIPickerView* pickerView;
@property(assign) id delegate;


-(IBAction)back;
-(IBAction)change;



@end
