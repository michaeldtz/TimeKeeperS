//
//  ExportHanler.h
//  TimeKeeper
//
//  Created by Michael Dietz on 06.10.11.
//  Copyright 2011 SAP MD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>
#import "PersonalRecordingItem.h"

@interface CSVExportHandler : NSObject <UIActionSheetDelegate, MFMailComposeViewControllerDelegate>{
    
    
    NSData*   exportData;
    NSString* exportFileName;
    UIViewController* viewController;
    
}

-(id)initWithViewController:(UIViewController*)aViewController;

-(IBAction)prepareExport:(PersonalRecordingItem*)singleItemOrNil;

@end
