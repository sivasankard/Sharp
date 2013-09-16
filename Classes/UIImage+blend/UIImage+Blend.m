//
//  UIImage+Blend.m
//  Sharp
//
//  Created by Siva Sankard on 11/06/13.
//  Copyright (c) 2013 RMN infoteh. All rights reserved.
//

#import "UIImage+Blend.h"

@implementation UIImage (Blend)

- (UIImage *)imageBlendedWithImage:(UIImage *)overlayImage blendMode:(CGBlendMode)blendMode alpha:(CGFloat)alpha {
    
    UIGraphicsBeginImageContext(self.size);  
    
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    [self drawInRect:rect];
    
    [overlayImage drawAtPoint:CGPointMake(0, 0) blendMode:blendMode alpha:alpha];
    
    UIImage *blendedImage = UIGraphicsGetImageFromCurrentImageContext();  
    UIGraphicsEndImageContext();
    
    return blendedImage;
}

@end
