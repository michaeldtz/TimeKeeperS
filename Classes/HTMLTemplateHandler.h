//
//  HTMLTemplateHandler.h
//  TimeKeeper
//
//  Created by Michael Dietz on 07.10.11.
//  Copyright 2011 SAP MD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonalRecordingItem.h"
#import "HTMLExportHandler.h"

@interface HTMLTemplateHandler : NSObject <UIActionSheetDelegate> {
 
    UIViewController* viewController;
    HTMLExportHandler *delegate;
    NSArray* templates;
    
}

-(id)initWithViewController:(UIViewController*)aViewController;
-(IBAction)loadATemplate:(HTMLExportHandler*)aDelegate;
-(NSArray*)getListOfTemplates;

@end
