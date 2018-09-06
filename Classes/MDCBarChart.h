//
//  MDCBarChart.h
//  TimeKeeper
//
//  Created by Michael Dietz on 10.11.10.
//  Copyright 2010 SAP MD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDCChart.h"
#import "MDCChartDataGroup.h"

@interface MDCBarChart : MDCChart {
	
}

+(void)drawBar:(int)x:(int)y:(int)fullWidth:(int)value:(int)maxValue:(int)height:(UIColor*)color:(NSString*)description:(NSString*)valueLabel;
+(int)getMaxValue:(NSArray*)dataArray;

@end
