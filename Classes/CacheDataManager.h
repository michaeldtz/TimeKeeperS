//
//  DataManager.h
//  Team Communicator
//
//  Created by Michael Dietz on 16.04.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PersonalRecordingItem;

@interface CacheDataManager : NSObject {

	
}

+(NSMutableArray*)loadItemList;
+(void)addToItemList:(PersonalRecordingItem*)item;
+(void)saveItemList;
+(void)reloadItemList;
+(void)clear;
+(void)removeItem:(PersonalRecordingItem*)item;

+(NSString*)getExportDateFormat;
+(void)setExportDateFormat:(NSString*)dateFormat;


@end
