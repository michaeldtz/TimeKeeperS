#import "TimeRecording.h"
#import "PersonalRecordingItem.h"


@implementation TimeRecording

@synthesize datePicker, hoursPicker, fromQuick, dateButton, hoursButton, worklistitem, selectedHours, activity, shortText, selectedMinutes;

#pragma mark InitializeView


	// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
	self.navigationItem.title = NSLocalizedString(@"Record Times",@"");
	
	[self       setDate:[NSDate date]];
	[datePicker setMaximumDate:[NSDate date]];
	self.datePicker.locale = [NSLocale currentLocale];
	self.datePicker.date = [NSDate date];
	
	self.selectedHours     = 0;
	self.selectedMinutes = 0;
	[self updateSelectedTime];
}

-(void)updateSelectedTime{
	[hoursButton setTitle:[OutputFormatter hoursAndMinutesToString:self.selectedHours :self.selectedMinutes] forState:UIControlStateNormal];	
}

#pragma mark NewRecord Action

-(IBAction) askForAddRecord:(id)sender{
	if([activity isAnimating] == NO){
		prepareToAdd = YES;
		UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Please Confirm",@"") message:NSLocalizedString(@"Are you sure that you want to add this record?",@"") delegate:self cancelButtonTitle:NSLocalizedString(@"No",@"") otherButtonTitles:NSLocalizedString(@"Yes",@""), nil];
		[alert show];
		[alert release];
	}
	
}

-(void) addRecord{
	
	PersonalTimeRecord* record = [[PersonalTimeRecord alloc] init];
	record.workdate = datePicker.date;
	record.hours   = [hoursPicker selectedRowInComponent:0];
	record.minutes = [hoursPicker selectedRowInComponent:1]; 
	record.shortText = shortText.text;
	record.recordingDate = [NSDate date];
	[worklistitem addRecord:record];
	
	if(fromQuick){
		worklistitem.startedTimeRecording = 0;
		[CacheDataManager saveItemList];		
	}
	
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark Picker

-(IBAction) pickDate:(id)sender{
	hoursPicker.hidden = YES;
	datePicker.hidden = NO;
}

-(IBAction) pickHours:(id)sender{
	hoursPicker.hidden = NO;
	datePicker.hidden = YES;
}

-(IBAction) changeDate:(id)sender{
	[self setDate:datePicker.date];
}

-(void) setDate:(NSDate*) date{
	NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
	[formatter setDateFormat:NSLocalizedString(@"MM/dd/yyyy",@"DateFormatter")];
	
	NSString *stringFromDate = [formatter stringFromDate:date];
	[dateButton setTitle:stringFromDate forState:UIControlStateNormal];
}

#pragma mark TextFieldCLoser

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
	[textField resignFirstResponder];
	return YES;
}

#pragma mark AlertDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	if(prepareToAdd == YES){
		if(buttonIndex == 1){
			[self addRecord];
		}
		prepareToAdd = NO;
	}
}

#pragma mark Picker

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
	return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
	if(component == 0)
		return 25;
	else 
		return 60;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
	if(component == 0){
		return [OutputFormatter hoursToString:row];
	} else {
		return [OutputFormatter minutesToString:row];
	}
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
	if(component == 0)
		self.selectedHours = row;
	else  
		self.selectedMinutes = row;
	
	if(self.selectedHours == 24 && self.selectedMinutes != 0){
		self.selectedMinutes = 0;
		[hoursPicker selectRow:0 inComponent:1 animated:YES];
	}
	
	[self updateSelectedTime];
}

#pragma mark MemoryManagement

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
}

- (void)dealloc {
	[super dealloc];
}


@end
