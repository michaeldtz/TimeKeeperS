//
//  HTMLTemplateHandler.m
//  TimeKeeper
//
//  Created by Michael Dietz on 07.10.11.
//  Copyright 2011 SAP MD. All rights reserved.
//

#import "HTMLTemplateHandler.h"


@implementation HTMLTemplateHandler


- (id)initWithViewController:(UIViewController*)aViewController
{
    self = [super init];
    if (self) {
        viewController = aViewController;
    }
    
    return self;
}

-(NSArray*)getListOfTemplates{
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSArray *dirContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDirectory error:nil];
    NSMutableArray* templateList = [[NSMutableArray alloc] init];
    for(NSString* fileName in dirContents){
        if([fileName hasSuffix:@".template.html"]){
            [templateList addObject:fileName];
            NSLog(@"%@", fileName);
        }
    }
    return templateList;
}


-(IBAction)loadATemplate:(HTMLExportHandler*)aDelegate{

    delegate = aDelegate;
    
    templates = [self getListOfTemplates];
    
    //Ask user for type of export
	UIActionSheet* sheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"Which template do you want to use?", @"") delegate:self cancelButtonTitle:nil destructiveButtonTitle:NSLocalizedString(@"Cancel", @"") otherButtonTitles:nil];
    
    for(NSString* file in templates){
        [sheet addButtonWithTitle:file];        
    }
    
	sheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
	[sheet showInView:viewController.view];
	[sheet release];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) { //Cancel
        
	}else if (buttonIndex == 1) { //FromArray -1
        NSString* templateFile = [templates objectAtIndex:buttonIndex-1];
        NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        NSString *tempFilePath = [documentsDirectory stringByAppendingPathComponent:templateFile];
        NSString* htmlTemplate = [NSString stringWithContentsOfFile:tempFilePath encoding:NSASCIIStringEncoding error:nil];
        [delegate templateLoaded:htmlTemplate];
	}
	
}

@end
