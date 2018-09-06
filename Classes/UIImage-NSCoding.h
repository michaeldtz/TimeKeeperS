//
//  UIImage-NSCoding.h
//  Team Communicator
//
//  Created by Michael Dietz on 17.04.10.
//  Copyright 2010 MD. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIImageNSCoding <NSCoding> 

-(id)initWithCoder:(NSCoder*)decoder;
-(void)encodeWithCoder:(NSCoder*)encoder;

@end
