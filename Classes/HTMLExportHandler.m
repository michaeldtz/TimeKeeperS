//
//  HTMLExportHandler.m
//  TimeKeeper
//
//  Created by Michael Dietz on 07.10.11.
//  Copyright 2011 SAP MD. All rights reserved.
//

#import "HTMLExportHandler.h"
#import "ItemTypeManager.h"
#import "PersonalTimeRecord.h"
#import "CacheDataManager.h"
#import "OutputFormatter.h"
#import "HTMLTemplateHandler.h"

@implementation HTMLExportHandler


- (id)initWithViewController:(UIViewController*)aViewController
{
    self = [super init];
    if (self) {
        viewController = aViewController;
    }
    
    return self;
}

#pragma HTML creation methods

-(NSMutableString*)createHTMLforSingleItem:(PersonalRecordingItem*)item:(BOOL)withItemHeader{
    NSMutableString* html = [[NSMutableString alloc] initWithString:@""];
	
    
    if(withItemHeader){
        [html appendString:@"<table class='itemheader'>"];
        [html appendString:@"<thead>"];
        [html appendFormat:@"<tr><th class='itemid'>Recording Item</th><th>%@</th></tr>", item.name];
        [html appendString:@"</thead><tbody>"];
        
        [html appendFormat:@"<tr><td>Item Type</td><td>%@</td></tr>",  [ItemTypeManager text4ItemType:item.type]];
        [html appendFormat:@"<tr><td>Description</td><td>%@</td></tr>",  item.description];
        
        [html appendFormat:@"<tr><td>Planned</td><td>%i h</td></tr>",  item.planEffort];
        [html appendFormat:@"<tr><td>Actual</td><td>%@</td></tr>", [OutputFormatter hoursAndMinutesToSimpleStringFromFloat:[item countTotalHours]]];
        [html appendString:@"</tbody></table>"];
        

    }
    
    //Prepare Date Formatter
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:[CacheDataManager getExportDateFormat]];
    
    //Generate One Entry per Recording
    [html appendString:@"<table class='recordstable'>"];
    
    [html appendString:@"<thead class='recordsheader'><tr class='recordsheaderline'>"];
    [html appendString:@"<th class='recordid'>RecordID</th>"];
    [html appendString:@"<th class='workdate'>Workdate</th>"];
    [html appendString:@"<th class='time'>Time</th>"];
    [html appendString:@"<th class='shorttext'>ShortText</th>"];
    [html appendString:@"<th class='recordedon'>Recorded On</th>"];
    [html appendString:@"</tr></thead><tbody>"];
    
    for(PersonalTimeRecord* record in item.timeRecords){
        [html appendString:@"<tr class='recordline'>"];
        
        [html appendFormat:@"<td class='recordid'>%@</td>",  record.uniqueID];
        [html appendFormat:@"<td class='workdate'>%@</td>",  [formatter stringFromDate:record.workdate]];
        [html appendFormat:@"<td class='time'>%@</td>",  [OutputFormatter hoursAndMinutesToSimpleString:record.hours :record.minutes]];
        [html appendFormat:@"<td class='shorttext'>%@</td>",   record.shortText];        
        [html appendFormat:@"<td class='recordedon'>%@</td>",   [formatter stringFromDate:record.recordingDate]];
        [html appendString:@"</tr>"];
    }       
    [html appendString:@"</tbody></table>"];
    
    
    return html;
}


#pragma mark Export

-(IBAction)prepareExport:(PersonalRecordingItem*)singleItemOrNil{
    
    passedItem = singleItemOrNil;
    
    //Ask First the Template Handler to Provide a Template
    HTMLTemplateHandler* templateHandler = [[HTMLTemplateHandler alloc] initWithViewController:viewController];
    [templateHandler loadATemplate:self];
}


-(NSData*)constructHTML:(NSString*)template:(PersonalRecordingItem*)item{
    NSMutableString *recordshtml ;
    
    if(item == nil){
        NSMutableArray* list = [CacheDataManager loadItemList];
        recordshtml = [[NSMutableString alloc] initWithString:@""];
        for(PersonalRecordingItem* itemInList in list){
            [recordshtml appendString:[self createHTMLforSingleItem:itemInList :YES]]; 
            exportData = [[recordshtml dataUsingEncoding:NSASCIIStringEncoding ] retain];
        }
    } else {
        recordshtml = [self createHTMLforSingleItem:item :YES];
    }
    
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:[CacheDataManager getExportDateFormat]];
    
    
    NSString* finalhtml = [template stringByReplacingOccurrencesOfString:@"##TIMESHEET_TABLE##" withString:recordshtml];
finalhtml = [finalhtml stringByReplacingOccurrencesOfString:@"##PRINTDATE##" withString:[formatter stringFromDate:[NSDate date]]];
    return [finalhtml dataUsingEncoding:NSASCIIStringEncoding];
}

-(void)templateLoaded:(NSString*)templateContent{
    
    exportData = [[self constructHTML:templateContent :passedItem] retain];
    
    //Ask user for type of export
	UIActionSheet* sheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"How do you want to export the data?", @"") delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", @"") destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Send via E-Mail",@""), NSLocalizedString(@"Save on Device",@""), nil];
	sheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
	[sheet showInView:viewController.view];
	[sheet release];
}

-(void)exportLocally{
	NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
	[formatter setDateFormat:@"ddMMyyyy"];
	NSString *today = [formatter stringFromDate:[NSDate date]];
	NSString* filename = [NSString stringWithFormat:@"export_full_%@.html",today];
	
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
