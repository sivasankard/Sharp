//
//  ChangePhotoFrameViewController.h
//  Sharp
//
//  Created by Siva Sankard on 12/06/13.
//  Copyright (c) 2013 RMN infoteh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangePhotoFrameViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) UIImage *selectedImage, *originalImg;
@property (nonatomic, retain) UIImageView *imgProfile;
@property (nonatomic, retain) UITableView *tableView;
@property NSMutableArray *framesArray;
-(void)image:(UIImage*)currentImag;
@end
