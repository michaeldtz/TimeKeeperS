//
//  Chart.m
//  TimeKeeper
//
//  Created by Michael Dietz on 10.11.10.
//  Copyright 2010 SAP MD. All rights reserved.
//

#import "MDCChart.h"


@implementation MDCChart

@synthesize chartGroups, x, y, title, lineWidth, valuePrintPosition;

+(MDCChart*)createChartOfType:(NSString*)chartTypeName:(CGRect)frame{
	NSString* classname = [NSString stringWithFormat:@"MDC%@", chartTypeName];
	Class class = NSClassFromString(classname);
	if(class != nil)
		return [[class alloc] initWithFrame:frame];
	return [[MDCChart alloc] initWithFrame:frame];
}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {

		self.contentSize = frame.size;
		self.scrollEnabled = YES;
		self.backgroundColor = [UIColor clearColor];
		
		lineWidth = 5;
		x = 0; //frame.origin.x;
		y = 0; //frame.origin.y;

		colors[0] = [[UIColor colorWithRed:0.1 green:0.1 blue:0.5 alpha:1] retain];
		colors[1] = [[UIColor colorWithRed:0.1 green:0.5 blue:0.1 alpha:1] retain];
		colors[2] = [[UIColor colorWithRed:0.5 green:0.1 blue:0.1 alpha:1] retain];
		colors[3] = [[UIColor colorWithRed:0.4 green:0.4 blue:0.6 alpha:1] retain];
		colors[4] = [[UIColor colorWithRed:0.4 green:0.6 blue:0.4 alpha:1] retain];
		colors[5] = [[UIColor colorWithRed:0.6 green:0.4 blue:0.4 alpha:1] retain];
		colors[6] = [[UIColor colorWithRed:0.4 green:0.0 blue:0.6 alpha:1] retain];
		
		valuePrintPosition = 2;
		
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	
	NSString* string = @"Chart not Found";
	CGRect lblRect = CGRectMake(x,y,200,10);
	CGContextSetFillColorWithColor(ctx, [UIColor whiteColor].CGColor);
	UIFont* font = [UIFont fontWithName:@"Arial" size:12];
	[string drawInRect:lblRect withFont:font];
}



- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
	return self;
}

- (void)dealloc {
    [super dealloc];
}


@end
