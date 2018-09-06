//
//  ItemTypeManager.h
//  TimeKeeper
//
//  Created by Michael Dietz on 09.12.10.
//  Copyright 2010 SAP MD. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ItemTypeManager : NSObject {

	NSMutableArray* itemTypes;
}

@property(assign, readonly) NSMutableArray* itemTypes;

+(ItemTypeManager*)getInstance;
+(NSString*)text4ItemType:(int)itemtype;
-(void)saveItemList;
-(void)reloadItemList;
-(void)changeNameAtIndex:(int)index:(NSString*)newName;


@end
