//
//  ChartHandler.m
//  TimeKeeper
//
//  Created by Michael Dietz on 06.10.11.
//  Copyright 2011 SAP MD. All rights reserved.
//

#import "ChartHandler.h"
#import "BarChartViewController.h"
#import "PieChartViewController.h"

@implementation ChartHandler

-(id)initWithViewController:(UIViewController*)aViewController
{
    self = [super init];
    if (self) {
        viewController = aViewController;
    }
    
    return self;
}



#pragma mark Ask for Chart Type

-(IBAction)startChartView{
   
    //Ask user for type of chart
	UIActionSheet* sheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"What chart do you want to open?", @"") delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel",@"")  destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Type Grouped Bar Chart",@""), NSLocalizedString(@"Pie Chart on Types",@""), nil];
	sheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
	[sheet showInView:viewController.view];
	[sheet release];
}

-(void)openBarChart{
    viewController.navigationItem.title = NSLocalizedString(@"Back", @"");
	BarChartViewController* controller = [[BarChartViewController alloc] init];
	[viewController.navigationController pushViewController:controller animated:YES];
}

-(void)openPieChart{
    viewController.navigationItem.title = NSLocalizedString(@"Back", @"");
	PieChartViewController* controller = [[PieChartViewController alloc] init];
	[viewController.navigationController pushViewController:controller animated:YES];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) { //Bar
		[self openBarChart];
	}else if (buttonIndex == 1) { //Pie
		[self openPieChart];
	}
}





@end
