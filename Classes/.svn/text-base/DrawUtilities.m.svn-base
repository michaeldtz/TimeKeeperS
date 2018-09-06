	//
	//  DrawUtilities.m
	//  TimeKeeper
	//
	//  Created by Michael Dietz on 12.11.10.
	//  Copyright 2010 SAP MD. All rights reserved.
	//

#import "DrawUtilities.h"


@implementation DrawUtilities

+(void)drawText:(NSString*)text:(int)x:(int)y:(int)width:(int)align{
	[DrawUtilities drawText:text :x :y :width :align :12 :[UIColor whiteColor]];
}

+(void)drawText:(NSString*)text:(int)x:(int)y:(int)width:(int)align:(int)fontSize{
	[DrawUtilities drawText:text :x :y :width :align :fontSize :[UIColor whiteColor]];
}

+(void)drawText:(NSString*)text:(int)x:(int)y:(int)width:(int)align:(int)fontSize:(UIColor*)color{
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	CGContextSaveGState(ctx);
	CGContextSetFillColorWithColor(ctx, color.CGColor);
	
	UIFont* font = [UIFont fontWithName:@"Arial" size:fontSize];
	
	int textWidth  = [text sizeWithFont:font].width;
	int textHeight = [text sizeWithFont:font].height;
	int textX     = x;
	
	if(align == 1){
		textX += (width - textWidth) / 2;
	} else 	if(align == 2){
		textX += (width - textWidth);		
	}
	
	CGRect   rect  = CGRectMake(textX, y, textWidth, textHeight);
	[text drawInRect:rect withFont:font];
	
	CGContextRestoreGState(ctx);
}

@end
