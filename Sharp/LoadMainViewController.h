//
//  LoadMainViewController.h
//  Sharp
//
//  Created by Siva Sankard on 11/06/13.
//  Copyright (c) 2013 RMN infoteh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "DSSImagePickerController.h"
#import "HomeAppDelegate.h"

@interface LoadMainViewController : UIViewController<DSSImagePickerControllerDelegate,UINavigationControllerDelegate, UIScrollViewDelegate>

@property int columns;
//@property NSMutableArray *imagesArray;
@property UIScrollView *scrollView;
@property BOOL isLabel;
@property UILabel *picTitleLable;
@property HomeAppDelegate *appDelegate;


@end
