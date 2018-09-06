//
//  DateOutputtttter.h
//  TimeKeeper
//
//  Created by Dietz, Michael on 10/26/10.
//  Copyright 2010 SAP MD. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface OutputFormatter : NSObject {

}

+(NSString*)minutesToString:(int)minutes;
+(NSString*)hoursToString:(int)hours;
+(NSString*)hoursAndMinutesToString:(int)hours:(int)minutes;
+(NSString*)hoursAndMinutesToStringFromFloat:(float)hoursWithMinutes;
+(NSString*)hoursAndMinutesToSimpleString:(int)hours:(int)minutes;
+(NSString*)hoursAndMinutesToSimpleStringFromFloat:(float)hoursWithMinutes;
+(NSString*)hoursAndMinutesToMediumString:(int)hours:(int)minutes;

+(void)deactivateLeadingZeroForMinutes:(BOOL)active;

@end
