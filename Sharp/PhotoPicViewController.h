//
//  PhotoPicViewController.h
//  Sharp
//
//  Created by Siva Sankard on 11/06/13.
//  Copyright (c) 2013 RMN infoteh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeAppDelegate.h"

@interface PhotoPicViewController : UIViewController<UIScrollViewDelegate>

@property HomeAppDelegate *appDelegate;
@property UIScrollView *scrollView;;

@end
