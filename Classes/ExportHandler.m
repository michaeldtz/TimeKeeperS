//
//  ExportHandler.m
//  TimeKeeper
//
//  Created by Michael Dietz on 07.10.11.
//  Copyright 2011 SAP MD. All rights reserved.
//

#import "ExportHandler.h"
#import "CSVExportHandler.h"
#import "HTMLExportHandler.h"

@implementation ExportHandler

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
    recordingItem = singleItemOrNil;
    
    UIActionSheet* sheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"In which format do you want to export?", @"") delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", @"") destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"CSV Format",@""), NSLocalizedString(@"HTML Format",@""), nil];
	sheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
	[sheet showInView:viewController.view];
	[sheet release];
    
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) { //Email
        CSVExportHandler* csvExportHandler = [[CSVExportHandler alloc] initWithViewController:viewController];
        [csvExportHandler prepareExport:recordingItem];
	}else if (buttonIndex == 1) { //Locally
        HTMLExportHandler* htmlExportHandler = [[HTMLExportHandler alloc] initWithViewController:viewController];
        [htmlExportHandler prepareExport:recordingItem];
	}
	
}	

@end
