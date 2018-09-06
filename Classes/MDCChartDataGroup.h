//
//  SumGroupObject.h
//  TimeKeeper
//
//  Created by Dietz, Michael on 5/5/10.
//  Copyright 2010 MD. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MDCChartDataGroup : NSObject {

	NSString* catDescription;
	NSString* cat;
	NSString* description;
	NSString* valueLabel;
	float     value;
	
}

@property(retain) NSString* catDescription;
@property(retain) NSString* cat;
@property(retain) NSString* description;
@property(retain) NSString* valueLabel;
@property(assign) float     value;

-(id)init;

@end
