//
//  ExportHanler.m
//  TimeKeeper
//
//  Created by Michael Dietz on 06.10.11.
//  Copyright 2011 SAP MD. All rights reserved.
//

#import "CSVExportHandler.h"
#import "ItemTypeManager.h"
#import "PersonalTimeRecord.h"
#import "CacheDataManager.h"
#import "OutputFormatter.h"

@implementation CSVExportHandler

- (id)initWithViewController:(UIViewController*)aViewController
{
    self = [super init];
    if (self) {
        viewController = aViewController;
    }
    
    return self;
}


#pragma mark Export

-(IBAction)prepareExport:(PersonalRecordingItem*)singleItemOrNil{
    
    //Prepare Export Data
	NSMutableString* exportString = [[NSMutableString alloc] initWithString:@""];
	[exportString appendString:@"New Item;Item ID;Name;Description;Type;Planned Effort;StartingDate;"];
	[exportString appendString:@"Record ID;Workdate;Recorded Time;Hours;Minutes;Short Text;Recording Date\n"];

    NSMutableArray* list;
    if(singleItemOrNil == nil){
        list = [CacheDataManager loadItemList];
    } else {
        list = [[NSMutableArray alloc] initWithObjects:singleItemOrNil, nil];
    }
	for(PersonalRecordingItem* item in list){
		
        //Prepare Date Formatter
		NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
		[formatter setDateFormat:[CacheDataManager getExportDateFormat]];
		
		
		BOOL first = YES;
        //Generate One Entry per Recording
		for(PersonalTimeRecord* record in item.timeRecords){
			if(first)
				[exportString appendFormat:@"X;%@;%@;%@;%@;%d;%d;", item.uniqueID, item.name, item.description, [ItemTypeManager text4ItemType:item.type], item.planEffort, item.startedTimeRecording, item.startedTimeRecording];
			else 
				[exportString appendFormat:@";%@;%@;%@;%d;%d;%d;", item.uniqueID, item.name, item.description, item.type, item.planEffort, item.startedTimeRecording, item.startedTimeRecording];
			
			first = NO;
			[exportString appendFormat:@"%@;\"%@\";%@;%d;%d;%@;\"%@\"\n", record.uniqueID, [formatter stringFromDate:record.workdate], [OutputFormatter hoursAndMinutesToSimpleString:record.hours :record.minutes], record.hours, record.minutes, record.shortText, [formatter stringFromDate:record.recordingDate] ];
		}
		
		if(first)
			[exportString appendFormat:@"X;%@;%@;%@;%d;%d;%d;", item.uniqueID, item.name, item.description, item.type, item.planEffort, item.startedTimeRecording, item.startedTimeRecording];
		
		exportData = [[exportString dataUsingEncoding: NSUTF8StringEncoding] retain];
	}
	
    //Ask user for type of export
	UIActionSheet* sheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"How do you want to export the data?", @"") delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", @"") destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Send via E-Mail",@""), NSLocalizedString(@"Save on Device",@""), nil];
	sheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
	[sheet showInView:viewController.view];
	[sheet release];
}

-(void)exportLocally{
	NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
	[formatter setDateFormat:@"ddMMyyyy-hhmmss"];
	NSString *today = [formatter stringFromDate:[NSDate date]];
	NSString* filename = [NSString stringWithFormat:@"export_full_%@.csv",today];
	
	NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
	NSString *filePath = [documentsDirectory stringByAppendingPathComponent:filename];
	[exportData writeToFile:filePath atomically:YES];
}

-(void)exportViaEmail{
	MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
	
	NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
	[formatter setDateFormat:@"ddMMyyyy-hhmmss"];
	NSString *today = [formatter stringFromDate:[NSDate date]];
	NSString* filename = [NSString stringWithFormat:@"export_full_%@.html",today];
	
	[controller setMailComposeDelegate:self];
	[controller setSubject:NSLocalizedString(@"TimeKeeperS Full Export",@"")];
	[controller addAttachmentData:exportData mimeType:@"csv" fileName:filename];
	
	[viewController presentModalViewController:controller animated:YES];
	
	[controller release];
}

#pragma mark Feedback ActionSheet and Mail

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) { //Email
		[self exportViaEmail];
	}else if (buttonIndex == 1) { //Locally
		[self exportLocally];
	}
	[exportData release]; exportData = nil;
	[exportFileName release]; exportFileName = nil;
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error{
	[viewController dismissModalViewControllerAnimated:YES];
}

@end
