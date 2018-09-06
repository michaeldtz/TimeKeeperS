	//
	//  PieChart.m
	//  TimeKeeper
	//
	//  Created by Michael Dietz on 09.11.10.
	//  Copyright 2010 SAP MD. All rights reserved.
	//

#import "MDCPieChart.h"
#import "CacheDataManager.h"
#import "ItemTypeManager.h"

@implementation MDCPieChart

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		if(frame.size.width < frame.size.height){
			radius = (frame.size.width/2) - lineWidth;
		} else {
			radius = (frame.size.height/2) - lineWidth;
		}
	}
	return self;
}
- (void)drawRect:(CGRect)rect {
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	
	int xCentre = x + radius + lineWidth;
	int yCentre = y + radius + lineWidth;
	
	int   counter = 0;
	float lastDegree = 0;
	float sumFigure = 0;
	
	for(MDCChartDataGroup* chartGroup in chartGroups)
		sumFigure = sumFigure + chartGroup.value;
	
	
	if(title != nil){
			//Draw Title
		CGRect   titleRect  = CGRectMake(x, y, self.frame.size.width, 20);
		UILabel* titleLabel = [[UILabel alloc] initWithFrame:titleRect];
		titleLabel.text = title;
		titleLabel.textColor = [UIColor whiteColor];
		titleLabel.textAlignment = UITextAlignmentCenter;
		titleLabel.backgroundColor = [UIColor clearColor];
		[self addSubview:titleLabel];
		
		radius -= 20/2;
		yCentre   += 20/2;
	}
	
	for(MDCChartDataGroup* chartGroup in chartGroups){
		
		CGContextSaveGState(ctx);
		
			//Draw Chart1
		float degree =  ((float)(M_PI * 2) / (float)sumFigure) * (float)chartGroup.value;
		CGContextSetFillColorWithColor(ctx, colors[counter].CGColor);
		CGContextSetLineWidth(ctx, lineWidth);
		CGContextMoveToPoint(ctx, xCentre, yCentre);
		CGContextAddArc(ctx, xCentre, yCentre, radius, lastDegree, lastDegree+degree, 0);
		CGContextClosePath(ctx);
		
		CGContextClip(ctx);
		
		const CGFloat* components = CGColorGetComponents(colors[counter].CGColor);
		NSString *colorAsString = [NSString stringWithFormat:@"%f,%f,%f,%f", components[0], components[1], components[2], components[3]];
		NSLog(@"%@", colorAsString);
		CGFloat gradColor[] = {
			components[0],components[1],components[2],0.9,
				//			components[0],components[1],components[2],0.2,
			components[0],components[1],components[2],0.2 
		};
		
			//Draw Graient
		CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
		CGGradientRef gradi = CGGradientCreateWithColorComponents(space, gradColor, NULL, 2);
		CGPoint startPoint = CGPointMake(xCentre,yCentre);
			//CGPoint endPoint = CGPointMake(xCentre + radius,yCentre + radius );
			//		CGContextDrawLinearGradient(ctx, gradi, startPoint, endPoint, 0);
		
		CGContextDrawRadialGradient(ctx, gradi, startPoint, radius , startPoint, 0, 2);
		
			//CGContextFillPath(ctx);
		
		CGContextRestoreGState(ctx);
		
			//Draw Chart Border
		CGContextSetLineWidth(ctx , 5);
		CGContextSetStrokeColorWithColor(ctx, [UIColor grayColor].CGColor);
		CGRect borderChart1 = CGRectMake(xCentre - radius, yCentre - radius, radius*2, radius*2);
		CGContextStrokeEllipseInRect(ctx, borderChart1);
		
		CGContextSetFillColorWithColor(ctx, colors[counter].CGColor);
		CGRect legend = CGRectMake(227, y + 30 + 15*counter, 10, 10);
		CGContextFillRect(ctx, legend);
		CGContextSetFillColorWithColor(ctx, [UIColor whiteColor].CGColor);
		
		UIFont* font = [UIFont fontWithName:@"Arial" size:11];
		CGRect rect = CGRectMake(239, (y + 30 + 15*counter) - 1, 100, 12);
		[chartGroup.description drawInRect:rect withFont:font];
		
		CGRect rect2 = CGRectMake(225 - [chartGroup.valueLabel sizeWithFont:font].width, (y + 30 + 15*counter) - 1, 100, 12);
		[chartGroup.valueLabel drawInRect:rect2 withFont:font];

			//Update Counters
		counter++;
		lastDegree += degree;
	}
	
	
	
}

- (void)dealloc {
    [super dealloc];
}


@end
