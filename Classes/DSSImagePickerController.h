//
//  DSSImagePickerControllerViewController.h
//  Sharp
//
//  Created by Siva Sankard on 12/06/13.
//  Copyright (c) 2013 RMN infoteh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSSAssetSelectionDelegate.h"

@class  DSSImagePickerController;

@protocol DSSImagePickerControllerDelegate <UINavigationControllerDelegate>

- (void)dssImagePickerController:(DSSImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info;
- (void)dssImagePickerControllerDidCancel:(DSSImagePickerController *)picker;

@end

@interface DSSImagePickerController : UINavigationController<DSSAssetSelectionDelegate>

@property (nonatomic, assign) id<DSSImagePickerControllerDelegate> delegate;

- (void)cancelImagePicker;

@end
