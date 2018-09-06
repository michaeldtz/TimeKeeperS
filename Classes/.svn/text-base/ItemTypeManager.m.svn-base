	//
	//  ItemTypeManager.m
	//  TimeKeeper
	//
	//  Created by Michael Dietz on 09.12.10.
	//  Copyright 2010 SAP MD. All rights reserved.
	//

#import "ItemTypeManager.h"


@implementation ItemTypeManager

@synthesize itemTypes;

static ItemTypeManager* instance;

+(ItemTypeManager*)getInstance{
	if(instance == nil)
		instance = [[ItemTypeManager alloc] init];
	return instance;
}

-(void)reloadItemList{
	NSUserDefaults* prefs = [NSUserDefaults standardUserDefaults];
	NSData* data = (NSData*)[prefs objectForKey:@"ITEMTYPELIST"];
	if (data != nil)
		itemTypes = [NSKeyedUnarchiver unarchiveObjectWithData:data];
	
	if (itemTypes == nil){
			//Create With Default Types
		itemTypes = [[NSMutableArray alloc] init];
		[itemTypes addObject:@"Project"];
		[itemTypes addObject:@"Service Order"];
		[itemTypes addObject:@"Opportunity"];
		[itemTypes addObject:@"Marketing"];
		[itemTypes addObject:@"Innovation"];
		[itemTypes addObject:@"Others"];
	}
	
	[itemTypes retain];
	
	[self saveItemList];
}

-(void)saveItemList{
	NSUserDefaults* prefs = [NSUserDefaults standardUserDefaults];
	NSData* data = [NSKeyedArchiver archivedDataWithRootObject:itemTypes];	
	[prefs setObject:data forKey:@"ITEMTYPELIST"];
	[prefs synchronize];	
}

-(void)changeNameAtIndex:(int)index:(NSString*)newName{
	[itemTypes replaceObjectAtIndex:index withObject:newName];
	[self saveItemList];
}

-(id)init{
	if((self = [super init])){
		[self reloadItemList];
	}
	return self;
}

+(NSString*)text4ItemType:(int)itemtype{
	NSString* text = [instance.itemTypes objectAtIndex:itemtype];
	return NSLocalizedString(text, @"");
}

@end
