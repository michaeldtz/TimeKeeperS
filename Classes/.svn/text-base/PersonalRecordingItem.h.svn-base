//
//  Team.h
//  Team Communicator
//
//  Created by Michael Dietz on 16.04.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CacheDataManager.h"
#import "UIImage-NSCoding.h"
#import "PersonalTimeRecord.h"

@interface PersonalRecordingItem : NSObject <NSCoding> {

	NSString* name;
	NSString* description;
	NSString* uniqueID;
	UIImage*  image;
	int       type;
	int       planEffort;
	int       startedTimeRecording;
	NSString* startTimeRecDate;
	
	NSMutableArray* timeRecords;
	
}

@property(retain, nonatomic) NSMutableArray*  timeRecords;
@property(retain, nonatomic) NSString* uniqueID;
@property(retain, nonatomic) NSString* name;
@property(retain, nonatomic) NSString* description;
@property(retain, nonatomic) UIImage*  image;
@property(assign, nonatomic) int startedTimeRecording;
@property(assign, nonatomic) int type;
@property(assign, nonatomic) int planEffort;

+(PersonalRecordingItem*)createItem:(NSString*)_name:(NSString*)_description:(int)_planEffort:(int)_type:(UIImage*)_image;

-(void)addRecord:(PersonalTimeRecord*)record;
-(float)countTotalHours;
-(NSDate*)getLatestRecordingDate;

@end
