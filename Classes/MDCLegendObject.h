//
//  MDCLegendObject.h
//  TimeKeeper
//
//  Created by Michael Dietz on 12.11.10.
//  Copyright 2010 SAP MD. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MDCLegendObject : NSObject {

	NSString* cat;
	NSString* category;
	UIColor*  color;
	
}

@property(retain)NSString* cat;
@property(retain)NSString* category;
@property(retain)UIColor* color;

@end
