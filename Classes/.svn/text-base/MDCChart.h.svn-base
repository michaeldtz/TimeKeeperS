//
//  Chart.h
//  TimeKeeper
//
//  Created by Michael Dietz on 10.11.10.
//  Copyright 2010 SAP MD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDCChartDataGroup.h"

@interface MDCChart : UIScrollView <UIScrollViewDelegate> {

	NSArray*  chartGroups;
	UIColor*  colors[7];
	NSString* title;
	
	int       x;
	int       y;
	
	int       lineWidth;
	int       valuePrintPosition;

}

@property(retain) NSArray*  chartGroups;
@property(retain) NSString* title;
@property(assign) int       x;
@property(assign) int       y;

@property(assign) int       lineWidth;
@property(assign) int       valuePrintPosition;

+(MDCChart*)createChartOfType:(NSString*)chartTypeName:(CGRect)frame;

@end
