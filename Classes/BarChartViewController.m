	//
	//  MainAnalytics.m
	//  TimeKeeper
	//
	//  Created by Dietz, Michael on 5/4/10.
	//  Copyright 2010 MD. All rights reserved.
	//

#import "BarChartViewController.h"
#import "CacheDataManager.h"
#import "MDCChartDataGroup.h"
#import "PersonalRecordingItem.h"
#import "MDCChart.h"
#import "OutputFormatter.h"
#import "ItemTypeManager.h"

@implementation BarChartViewController

-(void)loadView{
	CGRect fullscreen = CGRectMake(0,0, 320, 420);
	self.view = [[UIView alloc] initWithFrame:fullscreen];
	self.view.backgroundColor = [UIColor blackColor];
	
	CGRect barFrame = CGRectMake(0, 0, 320, 370);
	barchart = [MDCChart createChartOfType:@"BarChart" :barFrame];
	[self.view addSubview:barchart];

	CGRect barLegendFrame = CGRectMake(0, 370, 320, 50);
	barChartLegend = [MDCChart createChartOfType:@"Legend" :barLegendFrame];
	[self.view addSubview:barChartLegend];
	
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
	
	NSMutableArray*      multiGroups  = [[NSMutableArray alloc] init];
	for(NSString* key in [planGroups allKeys]){
		NSMutableArray* group = [[NSMutableArray alloc] initWithCapacity:2];
		
		MDCChartDataGroup* plan = [planGroups objectForKey:key];
		MDCChartDataGroup* actu = [actuGroups objectForKey:key];
		
		[group addObject:plan];
		[group addObject:actu];
		
		[multiGroups addObject:group];
	}
	
	

	barchart.chartGroups = multiGroups;// [[planGroups objectEnumerator] allObjects];
	barChartLegend.chartGroups = multiGroups;
	
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
