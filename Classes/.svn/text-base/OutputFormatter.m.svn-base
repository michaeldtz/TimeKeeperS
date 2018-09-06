	//
	//  DateOutputtttter.m
	//  TimeKeeper
	//
	//  Created by Dietz, Michael on 10/26/10.
	//  Copyright 2010 SAP MD. All rights reserved.
	//

#import "OutputFormatter.h"


@implementation OutputFormatter

static BOOL noLeadingZeros;

+(void)deactivateLeadingZeroForMinutes:(BOOL)deactive{
	noLeadingZeros = deactive;
}

+(NSString*)minutesToString:(int)minutes{
	
	NSString* minString;
	
	if(minutes == 1)
		minString = [NSString stringWithFormat:NSLocalizedString(@"%d Minute",@""),minutes];
	else
		minString = [NSString stringWithFormat:NSLocalizedString(@"%d Minutes",@""),minutes];
	
	if(!noLeadingZeros){
		if(minutes < 10){
			minString = [NSString stringWithFormat:@"0%@", minString];
		}
	}
	
	return minString;
}

+(NSString*)hoursToString:(int)hours{
	if(hours == 1)
		return [NSString stringWithFormat:NSLocalizedString(@"%d Hour",@""),hours];
	else
		return [NSString stringWithFormat:NSLocalizedString(@"%d Hours",@""),hours];
}

+(NSString*)hoursAndMinutesToString:(int)hours:(int)minutes{
	NSString* hrsString = [OutputFormatter hoursToString:hours];
	NSString* minString = [OutputFormatter minutesToString:minutes];
	NSLog(@"MINU %@", minString);
	return [NSString stringWithFormat:@"%@, %@", hrsString, minString];
}

+(NSString*)hoursAndMinutesToStringFromFloat:(float)hoursWithMinutes{
	int hours = hoursWithMinutes;
	hoursWithMinutes -= hours;
	int minutes = hoursWithMinutes * 60;
	return [OutputFormatter hoursAndMinutesToString:hours :minutes];
}

+(NSString*)hoursAndMinutesToSimpleString:(int)hours:(int)minutes{
	NSString* hrsString = @"";
	if(hours < 10)
		hrsString = [NSString stringWithFormat:@"0%d", hours];
	else
		hrsString = [NSString stringWithFormat:@"%d", hours];
	
	NSString* minString = @""; 
	if(minutes < 10)
		minString = [NSString stringWithFormat:@"0%d", minutes];
	else 
		minString = [NSString stringWithFormat:@"%d", minutes];
	
	return [NSString stringWithFormat:@"%@:%@", hrsString, minString];
}

+(NSString*)hoursAndMinutesToMediumString:(int)hours:(int)minutes{
	NSString* hrsString = @"";
	if(hours < 10)
		hrsString = [NSString stringWithFormat:@"0%d", hours];
	else
		hrsString = [NSString stringWithFormat:@"%d", hours];
	
	NSString* minString = @""; 
	if(minutes < 10)
		minString = [NSString stringWithFormat:@"0%d", minutes];
	else 
		minString = [NSString stringWithFormat:@"%d", minutes];
	
	return [NSString stringWithFormat:NSLocalizedString(@"%@ h, %@ min",@""), hrsString, minString];
}

+(NSString*)hoursAndMinutesToSimpleStringFromFloat:(float)hoursWithMinutes{
	int hours = hoursWithMinutes;
	hoursWithMinutes -= hours;
	int minutes = hoursWithMinutes * 60;
	return [OutputFormatter hoursAndMinutesToSimpleString:hours :minutes];
}




@end
