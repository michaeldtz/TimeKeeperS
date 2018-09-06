	//
	//  ImageScaler.m
	//  Team Communicator
	//
	//  Created by Michael Dietz on 17.04.10.
	//  Copyright 2010 SAP MD. All rights reserved.
	//

#import "ImageScaler.h"


@implementation ImageScaler


+(UIImage*)scaleImageToSize:(UIImage*) image:(CGFloat)height:(CGFloat)width{
	
		// Create a thumbnail version of the image for the event object.
	CGRect rect = CGRectMake(0.0, 0.0, width, height);
    UIGraphicsBeginImageContext(rect.size);
    [image drawInRect:rect];
	
		//UIGraphicsEndImageContext();
	return UIGraphicsGetImageFromCurrentImageContext();
	
	
} 

+(UIImage*)scaleImageByRatio:(UIImage*) image:(CGFloat)ratio{
	
	int width = image.size.width * ratio;
	int height = image.size.height * ratio;
	
		// Create a thumbnail version of the image for the event object.
	CGRect rect = CGRectMake(0.0, 0.0, width, height);
    UIGraphicsBeginImageContext(rect.size);
    [image drawInRect:rect];
	
		//UIGraphicsEndImageContext();
	return UIGraphicsGetImageFromCurrentImageContext();
	
}

+(UIImage*)scaleImageByHeight:(UIImage*) image:(CGFloat)height{
	
	int ratio = height / image.size.height;
	int width = image.size.width * ratio;
	
		// Create a thumbnail version of the image for the event object.
	CGRect rect = CGRectMake(0.0, 0.0, width, height);
    UIGraphicsBeginImageContext(rect.size);
    [image drawInRect:rect];
	
		//UIGraphicsEndImageContext();
	return UIGraphicsGetImageFromCurrentImageContext();
	
}
+(UIImage*)scaleImageByWidth:(UIImage*) image:(CGFloat)width{
	
	int ratio = width / image.size.width;
	int height = image.size.height * ratio;
	
		// Create a thumbnail version of the image for the event object.
	CGRect rect = CGRectMake(0.0, 0.0, width, height);
    UIGraphicsBeginImageContext(rect.size);
    [image drawInRect:rect];
	
		//UIGraphicsEndImageContext();
	return UIGraphicsGetImageFromCurrentImageContext();
	
}

+(UIImage*)scaleImageByMaxi:(UIImage*) image:(CGFloat)maxi{
	if(image.size.width > image.size.height)
		return [ImageScaler scaleImageByWidth:image :maxi];
	else 
		return [ImageScaler scaleImageByHeight:image :maxi];
}

+(UIImage*)scaleImageByMini:(UIImage*) image:(CGFloat)mini{
	if(image.size.width < image.size.height)
		return [ImageScaler scaleImageByWidth:image :mini];
	else 
		return [ImageScaler scaleImageByHeight:image :mini];
}

@end
