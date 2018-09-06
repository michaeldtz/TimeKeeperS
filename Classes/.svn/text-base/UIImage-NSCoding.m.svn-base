//
//  UIImage-NSCoding.m
//  Team Communicator
//
//  Created by Michael Dietz on 17.04.10.
//  Copyright 2010 MD. All rights reserved.
//

#import "UIImage-NSCoding.h"
#define kEncodingKey @"UIImage"

@implementation UIImage(NSCoding)


-(id)initWithCoder:(NSCoder*)decoder{
	
	if(self = [super init]){
		
		NSData* data = [decoder decodeObjectForKey:kEncodingKey];
		self = [self initWithData:data];
		
	}
	
	return self;	
}

-(void)encodeWithCoder:(NSCoder*)encoder{
	NSData* data = UIImagePNGRepresentation(self);
	[encoder encodeObject:data forKey:kEncodingKey];
}


@end
