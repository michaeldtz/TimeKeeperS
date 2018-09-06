//
//  SumGroupObject.m
//  TimeKeeper
//
//  Created by Dietz, Michael on 5/5/10.
//  Copyright 2010 MD. All rights reserved.
//

#import "MDCChartDataGroup.h"


@implementation MDCChartDataGroup

@synthesize catDescription, description, value, valueLabel, cat;

-(id)init{
	self.value = 0;
	return self;	
}

- (void)dealloc {
	[catDescription retain];
	[description retain];
	[super dealloc];
}



@end
