	//
	//  Team.m
	//  Team Communicator
	//
	//  Created by Michael Dietz on 16.04.10.
	//  Copyright 2010 __MyCompanyName__. All rights reserved.
	//
#import "PersonalRecordingItem.h"

@implementation PersonalRecordingItem

@synthesize name, description, image, timeRecords, type, planEffort, startedTimeRecording, uniqueID;


+(PersonalRecordingItem*)createItem:(NSString*)_name:(NSString*)_description:(int)_planEffort:(int)_type:(UIImage*)_image{
	PersonalRecordingItem* item        = [[PersonalRecordingItem alloc] init];
	item.name        = _name;
	item.description = _description;
	item.image       = _image;
	item.planEffort  = _planEffort;
	item.type        = _type;

		//Generate UUID
	CFUUIDRef theUUID = CFUUIDCreate(NULL);
	item.uniqueID = (NSString*) CFUUIDCreateString(NULL, theUUID);
	
	[CacheDataManager addToItemList:item];
	
	return item;
}

-(void)addRecord:(PersonalTimeRecord*)record{
	if(timeRecords == nil)
		timeRecords = [[NSMutableArray alloc] initWithCapacity:1];
	
		//Generate UUID
	CFUUIDRef theUUID = CFUUIDCreate(NULL);
	record.uniqueID = (NSString*) CFUUIDCreateString(NULL, theUUID);
	CFRelease(theUUID);
	
		//Add record
	[timeRecords addObject:record];
	[CacheDataManager saveItemList];	
}

-(float)countTotalHours{
	float hours = 0;
	for(PersonalTimeRecord* record in self.timeRecords){
		hours += [record hoursWithMinutesAsFloat];
	}
	return hours;
}

-(NSDate*)getLatestRecordingDate{
	NSDate* latest = [NSDate dateWithTimeIntervalSince1970:0];
	for(PersonalTimeRecord* record in self.timeRecords){
		if([latest laterDate:record.recordingDate])
			latest = record.recordingDate;
	}
	return latest;
}

#pragma mark NSConding

- (id)initWithCoder: (NSCoder *)coder {
	self.uniqueID             = [coder decodeObjectForKey:@"uniqueID"];	
	self.name                 = [coder decodeObjectForKey:@"itemname"];	
	self.description          = [coder decodeObjectForKey:@"itemdescription"];
	self.image                = [coder decodeObjectForKey:@"itemimage"];
	self.type                 = [coder decodeIntForKey:@"itemtype"]; 
	self.planEffort           = [coder decodeIntForKey:@"itemplannedeffortint"]; 
	self.timeRecords          = [coder decodeObjectForKey:@"people"];
	self.startedTimeRecording = [coder decodeIntForKey:@"startedtimerecordingint"];
	
	if(self.uniqueID == nil|| [self.uniqueID isEqualToString:@""]) {
		CFUUIDRef theUUID = CFUUIDCreate(NULL);
		self.uniqueID = (NSString*) CFUUIDCreateString(NULL, theUUID);
	}
	
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {   
    [coder encodeObject:self.uniqueID             forKey:@"uniqueID"];
    [coder encodeObject:self.name                 forKey:@"itemname"];
    [coder encodeObject:self.description          forKey:@"itemdescription"];
    [coder encodeObject:self.image                forKey:@"itemimage"];
	[coder encodeInt:self.type                    forKey:@"itemtype"];
	[coder encodeInt:self.planEffort              forKey:@"itemplannedeffortint"];
	[coder encodeObject:self.timeRecords          forKey:@"people"];
	[coder encodeInt:self.startedTimeRecording    forKey:@"startedtimerecordingint"];
}




@end
