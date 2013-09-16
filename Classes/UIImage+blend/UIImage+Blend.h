//
//  UIImage+Blend.h
//  Sharp
//
//  Created by Siva Sankard on 11/06/13.
//  Copyright (c) 2013 RMN infoteh. All rights reserved.

#import <UIKit/UIKit.h>

@interface UIImage (Blend)

- (UIImage *)imageBlendedWithImage:(UIImage *)overlayImage blendMode:(CGBlendMode)blendMode alpha:(CGFloat)alpha;

@end
