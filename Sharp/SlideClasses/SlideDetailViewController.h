//
//  SlideDetailViewController.h
//  Sharp
//
//  Created by Siva Sankard on 18/06/13.
//  Copyright (c) 2013 RMN infoteh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LTransitionImageView.h"
#import "HomeAppDelegate.h"

@interface SlideDetailViewController : UIViewController
{
    LTransitionImageView *_transitionImageView;
    HomeAppDelegate *appDelegate;
}
@end
