	//
	//  SettingsView.m
	//  TimeKeeper
	//
	//  Created by Michael Dietz on 06.12.10.
	//  Copyright 2010 SAP MD. All rights reserved.
	//

#import "SettingsView.h"
#import "ItemTypeManager.h"
#import "PersonalTimeRecord.h"
#import "CacheDataManager.h"
#import "PersonalRecordingItem.h"
#import "OutputFormatter.h"

@implementation SettingsView

@synthesize delegate, pickerView;

-(void)viewDidLoad{
	itemTypes = [[ItemTypeManager getInstance] itemTypes];
}

#pragma mark TextFieldCLoser

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
	[textField resignFirstResponder];
	return YES;
}


#pragma mark Actions

-(IBAction)back{
	if([delegate conformsToProtocol:@protocol(ModalScreenCloser)]){
		[delegate closeModalScreen:self];
	}
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
	return [itemTypes count];
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
	return [ItemTypeManager text4ItemType:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
	selectedRow = row;
}


-(IBAction)change{
	
	UIAlertView* changePopup = [[UIAlertView alloc] initWithTitle:@"Change Name" message:@"<this gets covered>" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Change",nil];
	CGAffineTransform myTransform = CGAffineTransformMakeTranslation(0.0, 30.0);
	[changePopup setTransform:myTransform];
	
	typeChangeTF = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 45.0, 260.0, 25.0)];
	[typeChangeTF setBackgroundColor:[UIColor whiteColor]];
	[typeChangeTF setText:[ItemTypeManager text4ItemType:selectedRow]];
	
	[changePopup addSubview:typeChangeTF];
	[changePopup show];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	if(buttonIndex == 1){
		[[ItemTypeManager getInstance] changeNameAtIndex:selectedRow :typeChangeTF.text];
		[pickerView reloadAllComponents];
	}
}




#pragma mark AppLifeCycle

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}


- (void)dealloc {
    [super dealloc];
}


@end
