	//
	//  UIImageUtils
	//  TimeKeeper
	//
	//  Created by Dietz, Michael on 5/4/10.
	//  Copyright 2010 MD. All rights reserved.
	//
@interface UIImage (UIImageUtils)
- (UIImage *)cropImageBySize:(CGRect)bounds;
- (UIImage *)createSmallThumbnailPicWithSize:(NSInteger)thumbnailSize
          :(NSUInteger)borderSize
               :(NSUInteger)cornerRadius
       :(CGInterpolationQuality)quality;
- (UIImage *)resizeImage:(CGSize)newSize
	interpolationQuality:(CGInterpolationQuality)quality;
- (UIImage *)resizeImage:(UIViewContentMode)contentMode
								 :(CGSize)bounds
				   :(CGInterpolationQuality)quality;
- (UIImage *)createImageWithRoundCorners:(NSInteger)cornerSize :(NSInteger)borderSize;
- (BOOL)hasAlpha;
- (UIImage *)imageWithAlpha;
- (UIImage *)createImageWithBorder:(NSUInteger)borderSize;
@end