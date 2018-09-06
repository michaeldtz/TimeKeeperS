#import <UIKit/UIKit.h>
#import "TimeRecords.h"
#import "PersonalTimeRecord.h"
#import "PersonalRecordingItem.h"
#import "OutputFormatter.h"

@interface TimeRecording : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UIAlertViewDelegate> {

	PersonalRecordingItem* worklistitem;
	
	IBOutlet UIPickerView* hoursPicker;
	IBOutlet UIDatePicker* datePicker; 
	IBOutlet UIButton* hoursButton;
	IBOutlet UIButton* dateButton;
	UIActivityIndicatorView* activity;
	UITextField* shortText;
	
	int selectedHours;
	int selectedMinutes;

	BOOL prepareToAdd;
	BOOL fromQuick;
}

@property(assign) PersonalRecordingItem* worklistitem;
@property(assign) int selectedHours;
@property(assign) int selectedMinutes;
@property(assign) BOOL fromQuick;

@property(nonatomic, retain) IBOutlet UIPickerView* hoursPicker;
@property(nonatomic, retain) IBOutlet UIDatePicker* datePicker; 
@property(nonatomic, retain) IBOutlet UIButton* hoursButton;
@property(nonatomic, retain) IBOutlet UIButton* dateButton;
@property(nonatomic, retain) IBOutlet UIActivityIndicatorView* activity;
@property(nonatomic, assign) IBOutlet UITextField* shortText;

-(IBAction) pickDate:(id)sender;
-(IBAction) pickHours:(id)sender;
-(IBAction) changeDate:(id)sender;
-(void) addRecord;
-(IBAction) askForAddRecord:(id)sender;
-(void) setDate:(NSDate*) date;
-(void)updateSelectedTime;

@end
