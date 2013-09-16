//
//  HomeViewController.h
//  Sharp
//
//  Created by Siva Sankard on 11/06/13.
//  Copyright (c) 2013 RMN infoteh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "LoadMainViewController.h"

@interface HomeViewController : UIViewController<UITextFieldDelegate>
{
    UIImageView *lanchImg;
    UITextField *userName, *passWord;
}
@end
