//
//  MaskViewController.h
//  Sharp
//
//  Created by Siva Sankard on 13/06/13.
//  Copyright (c) 2013 RMN infoteh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MaskViewController : UIViewController
{
    NSMutableArray *masksArrayList;
}
@property UIImageView *selectedImage, *maskImg;
@property CGFloat lastScale, lastRotation;
@property UIScrollView *scroll;
-(void)maskImage : (UIImage*)currentImage;
@end
