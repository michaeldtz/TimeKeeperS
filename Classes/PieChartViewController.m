//
//  PieChartViewController.m
//  TimeKeeper
//
//  Created by Michael Dietz on 06.10.11.
//  Copyright 2011 SAP MD. All rights reserved.
//

#import "PieChartViewController.h"
#import "CacheDataManager.h"
#import "MDCChartDataGroup.h"
#import "PersonalRecordingItem.h"
#import "MDCChart.h"
#import "OutputFormatter.h"
#import "ItemTypeManager.h"

@implementation PieChartViewController

-(void)loadView{
	CGRect fullscreen = CGRectMake(0,0, 320, 420);
	self.view = [[UIView alloc] initWithFrame:fullscreen];
	self.view.backgroundColor = [UIColor blackColor];
	

	CGRect pie1Frame = CGRectMake(0, 0, 320, 200);
	piechart1 = [MDCChart createChartOfType:@"PieChart" :pie1Frame];
	[self.view addSubview:piechart1];
	
	CGRect pie2Frame = CGRectMake(0, 205, 320, 200);
	piechart2 = [MDCChart createChartOfType:@"PieChart" :pie2Frame];
	[self.view addSubview:piechart2];

}

-(void)viewDidLoad{
	self.navigationItem.title = NSLocalizedString(@"Analytics",@"");
    
	NSArray* array = [CacheDataManager loadItemList];
	NSMutableDictionary* planGroups = [[NSMutableDictionary alloc] initWithCapacity:5];
	NSMutableDictionary* actuGroups = [[NSMutableDictionary alloc] initWithCapacity:5];
	
	for(PersonalRecordingItem* item in array){
		MDCChartDataGroup* planGroup = [planGroups objectForKey:[NSString stringWithFormat:@"%d", item.type]];
		MDCChartDataGroup* actuGroup = [actuGroups objectForKey:[NSString stringWithFormat:@"%d", item.type]];
		
		if(planGroup == nil){
			planGroup = [[MDCChartDataGroup alloc] init];
			planGroup.description = [ItemTypeManager text4ItemType:item.type];
			planGroup.cat = @"PLAN";
			planGroup.catDescription  = NSLocalizedString(@"Planned Effort", @"");
		}
		
		if(actuGroup == nil){
			actuGroup = [[MDCChartDataGroup alloc] init];
			actuGroup.description = [ItemTypeManager text4ItemType:item.type];
			actuGroup.cat = @"ACTUALS";
			actuGroup.catDescription  = NSLocalizedString(@"Actual Effort", @"");
		}
		
		planGroup.value += item.planEffort;
		actuGroup.value += [item countTotalHours];
        
        //planGroup.valueLabel = [NSString stringWithFormat:@"%.1fh", planGroup.value];
        //actuGroup.valueLabel = [NSString stringWithFormat:@"%.1fh", actuGroup.value];
		
		planGroup.valueLabel = [OutputFormatter hoursAndMinutesToSimpleStringFromFloat:planGroup.value];
		actuGroup.valueLabel = [OutputFormatter hoursAndMinutesToSimpleStringFromFloat:actuGroup.value];
		
		[planGroups setObject:planGroup forKey:[NSString stringWithFormat:@"%d", item.type]];
		[actuGroups setObject:actuGroup forKey:[NSString stringWithFormat:@"%d", item.type]];		
	}
	

	piechart1.title = @"Planned Hours";
	piechart1.chartGroups = [[planGroups objectEnumerator] allObjects];
	piechart2.title = @"Recorded Hours";
	piechart2.chartGroups = [[actuGroups objectEnumerator] allObjects];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}


- (void)dealloc {
    [super dealloc];
}


@end
