//
//  ChangeFrameViewController.h
//  Sharp
//
//  Created by Siva Sankard on 13/06/13.
//  Copyright (c) 2013 RMN infoteh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "UIView+Origami.h"
#import "GzColors.h"

@interface ChangeFrameViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>
{
    UIButton *swipeButton;
    BOOL isPaint, isColor;
    UIView *colorView;
    UISlider *slider;
    UIColor *selectedColor;
}
@property UIView *centerView, *sideView;
@property UIScrollView *colorScrollView;
@property UITableView *listTable;
@property UIImageView *selectedImage;
@property UIImage *currentImage, *selectedBackGroundImage;
@property NSMutableArray *framesArray;
@property (nonatomic, strong) NSArray *colorCollection;

-(void)image:(UIImage*)currentImag;

@end
