//
//  HTMLExportHandler.h
//  TimeKeeper
//
//  Created by Michael Dietz on 07.10.11.
//  Copyright 2011 SAP MD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>
#import "PersonalRecordingItem.h"

@interface HTMLExportHandler : NSObject <UIActionSheetDelegate, MFMailComposeViewControllerDelegate>{
    
    NSData*   exportData;
    NSString* exportFileName;
    UIViewController* viewController;
    PersonalRecordingItem* passedItem;
    
}

-(id)initWithViewController:(UIViewController*)aViewController;
-(IBAction)prepareExport:(PersonalRecordingItem*)singleItemOrNil;
-(void)templateLoaded:(NSString*)templateContent;

@end
