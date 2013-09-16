//
//  FlipBoardNavigationController.h
//  Sharp
//
//  Created by Siva Sankard on 11/06/13.
//  Copyright (c) 2013 RMN infoteh. All rights reserved.
//
#import <UIKit/UIKit.h>

typedef void (^FlipBoardNavigationControllerCompletionBlock)(void);

@interface FlipBoardNavigationController : UIViewController

@property(nonatomic, retain) NSMutableArray *viewControllers;

- (id) initWithRootViewController:(UIViewController*)rootViewController;

- (void) pushViewController:(UIViewController *)viewController;
- (void) pushViewController:(UIViewController *)viewController completion:(FlipBoardNavigationControllerCompletionBlock)handler;
- (void) popViewController;
- (void) popViewControllerWithCompletion:(FlipBoardNavigationControllerCompletionBlock)handler;
@end

@interface UIViewController (FlipBoardNavigationController)
@property (nonatomic, retain) FlipBoardNavigationController *flipboardNavigationController;
@end




