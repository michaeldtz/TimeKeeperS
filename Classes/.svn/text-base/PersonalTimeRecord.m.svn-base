//
//  TeamMember.m
//  Team Communicator
//
//  Created by Michael Dietz on 18.04.10.
//  Copyright 2010 MD. All rights reserved.
//

#import "PersonalTimeRecord.h"


@implementation PersonalTimeRecord

@synthesize uniqueID, shortText, workdate, confirmed, hours, recordingDate, minutes;

-(float)hoursWithMinutesAsFloat{
	return ((float) hours) + ((float)minutes / (float)60);
}

- (id)initWithCoder: (NSCoder *)coder
{
	self.uniqueID      = [coder decodeObjectForKey:@"uniqueID"];	
	self.shortText     = [coder decodeObjectForKey:@"shortText"];
	self.workdate      = [coder decodeObjectForKey:@"date"];
	self.recordingDate = [coder decodeObjectForKey:@"recordingdate"]; 
	self.confirmed     = [coder decodeBoolForKey:@"confirmed"];
	self.hours         = [coder decodeIntForKey:@"hours"];
	self.minutes       = [coder decodeIntForKey:@"minutes"];
	return self;
}


- (void)encodeWithCoder:(NSCoder *)coder;
{
	
    [coder encodeObject:uniqueID       forKey:@"uniqueID"];
    [coder encodeObject:shortText      forKey:@"shortText"];
    [coder encodeObject:workdate       forKey:@"date"];
	[coder encodeObject:recordingDate  forKey:@"recordingdate"];
	[coder encodeBool:confirmed        forKey:@"confirmed"];
	[coder encodeInt:hours             forKey:@"hours"];
	[coder encodeInt:minutes           forKey:@"minutes"];
}



@end

