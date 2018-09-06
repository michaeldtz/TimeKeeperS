//
//  ExportHandler.h
//  TimeKeeper
//
//  Created by Michael Dietz on 07.10.11.
//  Copyright 2011 SAP MD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonalRecordingItem.h"

@interface ExportHandler : NSObject <UIActionSheetDelegate>{
    
    UIViewController* viewController;
    PersonalRecordingItem* recordingItem;
    
}

-(id)initWithViewController:(UIViewController*)aViewController;
-(IBAction)prepareExport:(PersonalRecordingItem*)singleItemOrNil;


@end
