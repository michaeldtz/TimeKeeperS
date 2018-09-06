	//
	//  CreditsView.m
	//  Team Communicator
	//
	//  Created by Michael Dietz on 22.04.10.
	//  Copyright 2010 MD. All rights reserved.
	//

#import "AboutViewController.h"
#import "ModalScreenCloser.h"


@implementation AboutViewController

@synthesize delegate;

#pragma mark Initialize

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark Actions

-(IBAction)back{
	if([delegate conformsToProtocol:@protocol(ModalScreenCloser)]){
		[delegate closeModalScreen:self];
	}
}

#pragma mark Feedback

-(IBAction)sendAppFeedbackMail{
	MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
	
	NSMutableArray* mailAddresses = [[NSMutableArray alloc] initWithCapacity:1];
	[mailAddresses addObject:@"mi_dietz@yahoo.de"];
	
	[controller setMailComposeDelegate:self];
	[controller setToRecipients:mailAddresses];
	[controller setSubject:NSLocalizedString(@"My TimeKeeper Feedback",@"")];
	
	[self presentModalViewController:controller animated:YES];
	
	[mailAddresses release];
	[controller release];
}

#pragma mark Feedback Action

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error{
	[self dismissModalViewControllerAnimated:YES];
}

#pragma mark Finalize 

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
}


- (void)dealloc {
    [super dealloc];
}


@end
