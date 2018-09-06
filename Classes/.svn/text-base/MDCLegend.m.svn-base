	//
	//  MDCLegend.m
	//  TimeKeeper
	//
	//  Created by Michael Dietz on 12.11.10.
	//  Copyright 2010 SAP MD. All rights reserved.
	//

#import "MDCLegend.h"
#import "MDCLegendObject.h"
#import "DrawUtilities.h"

#define SQUARE_SIZE 15

@implementation MDCLegend

@synthesize rowFlex, maxRowsOrCols, multiDataFormat;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		maxRowsOrCols = 2;
		rowFlex = YES;
	}
	return self;
}

- (void)drawRect:(CGRect)rect {
	
	int colorCounter = 0;
	NSMutableDictionary* legendObjects = [[NSMutableDictionary alloc] init];
	
	for(id obj in chartGroups){
		if([obj isKindOfClass:[MDCChartDataGroup class]]){
			
			MDCChartDataGroup* group  = (MDCChartDataGroup*)obj;
			MDCLegendObject*   legObj = [legendObjects objectForKey:group.cat];
			if(legObj == nil){
				legObj = [[MDCLegendObject alloc] init];
				legObj.cat      = group.cat;
				legObj.category = group.catDescription;
				legObj.color    = colors[colorCounter];
				[legendObjects setObject:legObj forKey:group.cat];
			}
			
			colorCounter++;
			
			
		} else if([obj isKindOfClass:[NSArray class]]){
			for(MDCChartDataGroup* subGroup in (NSArray*)obj){
				
				MDCLegendObject*   legObj = [legendObjects objectForKey:subGroup.cat];
				if(legObj == nil){
					legObj = [[MDCLegendObject alloc] init];
					legObj.cat      = subGroup.cat;
					legObj.category = subGroup.catDescription;
					legObj.color    = colors[colorCounter];
					[legendObjects setObject:legObj forKey:subGroup.cat];
				}
				
				colorCounter++;
				
			}
			colorCounter = 0;
		}
	}
	
	if([legendObjects count] == 0)
		return;
	
	int cols = 1;
	int rows = 1;
	if(rowFlex){
		cols = maxRowsOrCols;
		rows = cols / [legendObjects count];
	} else {
		rows = maxRowsOrCols;
		cols = rows / [legendObjects count];
	}
	
		//Draw
	int xPos = 15;
	int yPos = 5;
	
	int width  = (int)((int)self.frame.size.width  / cols);
	int height = SQUARE_SIZE + 10;
	
	CGContextRef ctx  = UIGraphicsGetCurrentContext();
	CGContextSetLineWidth(ctx, 4);
	
	
	for(MDCLegendObject* legend in [[legendObjects objectEnumerator] allObjects]){
		
		CGContextSetFillColorWithColor(ctx, legend.color.CGColor);
		CGRect rect = CGRectMake(xPos, yPos, SQUARE_SIZE, SQUARE_SIZE);
		CGContextFillRect(ctx, rect);
		
		CGContextSetFillColorWithColor(ctx, [UIColor whiteColor].CGColor);
		[DrawUtilities drawText:legend.category :(xPos + SQUARE_SIZE + 5) :(yPos + 1) :(width - SQUARE_SIZE - 15):0];
		
		
		if(rowFlex){
			xPos += width; 
		} else {
			yPos += height;			
		}
		
	}
	
	/*
	 CGRect rect = CGRectMake(x, (y + 15*counter) - 1, 30, 12);
	 UIFont* font = [UIFont fontWithName:@"Arial" size:12];
	 [chartGroup.valueLabel drawInRect:rect withFont:font];
	 }
	 
	 //Draw Legend
	 CGContextSetFillColorWithColor(ctx, colors[counter].CGColor);
	 CGRect legendRect = CGRectMake(legendx + valueBuffer, legendy + 15*counter, 10, 10);
	 CGContextFillRect(ctx, legendRect);
	 CGContextSetFillColorWithColor(ctx, [UIColor whiteColor].CGColor);
	 CGRect legendTextRect = CGRectMake(legendx + 15 + valueBuffer, (legendy + 15*counter) - 1, legendWidth, 12);
	 UIFont* legendFont = [UIFont fontWithName:@"Arial" size:12];
	 [chartGroup.description drawInRect:legendTextRect withFont:legendFont];
	 */
}

@end
