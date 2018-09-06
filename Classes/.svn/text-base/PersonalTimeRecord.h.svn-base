	//
	//  TeamMember.h
	//  Team Communicator
	//
	//  Created by Michael Dietz on 18.04.10.
	//  Copyright 2010 MD. All rights reserved.
	//

#import <Foundation/Foundation.h>


@interface PersonalTimeRecord : NSObject {
	
	NSString* uniqueID;
	NSString* shortText;
	NSDate*   workdate;
	NSDate*   recordingDate;
	BOOL      confirmed;
	int       hours;
	int       minutes;
	
}

@property(retain) 	NSString* uniqueID;
@property(retain) 	NSString* shortText;
@property(retain) 	NSDate*   workdate;
@property(retain) 	NSDate*   recordingDate;
@property(assign) 	BOOL      confirmed;
@property(assign) 	int       hours;
@property(assign) 	int       minutes;

-(float)hoursWithMinutesAsFloat;


@end

