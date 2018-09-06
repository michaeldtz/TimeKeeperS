//
//  ImageScaler.h
//  Team Communicator
//
//  Created by Michael Dietz on 17.04.10.
//  Copyright 2010 SAP MD. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ImageScaler : NSObject {

}

+(UIImage*)scaleImageToSize:(UIImage*) image:(CGFloat)height:(CGFloat)width; 
+(UIImage*)scaleImageByRatio:(UIImage*) image:(CGFloat)ratioPercentage;
+(UIImage*)scaleImageByHeight:(UIImage*) image:(CGFloat)height;
+(UIImage*)scaleImageByWidth:(UIImage*) image:(CGFloat)width;
+(UIImage*)scaleImageByMaxi:(UIImage*) image:(CGFloat)maxi;
+(UIImage*)scaleImageByMini:(UIImage*) image:(CGFloat)mini;

@end
