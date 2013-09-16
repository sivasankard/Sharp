//
//  SlideDetailViewController.m
//  Sharp
//
//  Created by Siva Sankard on 18/06/13.
//  Copyright (c) 2013 RMN infoteh. All rights reserved.
//

#import "SlideDetailViewController.h"

@interface SlideDetailViewController ()

@end

@implementation SlideDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor blackColor];
    }
    return self;
}
//- (BOOL)shouldAutorotate{
//    return YES;
//}
//-(NSUInteger)supportedInterfaceOrientations{
//    return UIInterfaceOrientationMaskLandscape;
//}
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
//    return UIInterfaceOrientationLandscapeRight;
//}
//
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
//{
//    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
//}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    appDelegate = (HomeAppDelegate*)[[UIApplication sharedApplication]delegate];
    
    _transitionImageView = [[LTransitionImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 420)];
    _transitionImageView.animationDuration = 3;
    [self.view addSubview:_transitionImageView];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    backButton.frame = CGRectMake(10, 425, 70, 30);
    [backButton setTitle:@"Back" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void) {
        [self startAnimations];
    });
}
- (void)startAnimations
{
    CGFloat delay = _transitionImageView.animationDuration + 1;
    
    _transitionImageView.animationDirection = AnimationDirectionLeftToRight;
    if([appDelegate.imagesArray count])
        {
            _transitionImageView.image = [appDelegate.imagesArray objectAtIndex:0];
            
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void) {
                    _transitionImageView.animationDirection = AnimationDirectionTopToBottom;
                    if([appDelegate.imagesArray count] >1)_transitionImageView.image = [appDelegate.imagesArray objectAtIndex:1];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void) {
                    _transitionImageView.animationDirection = AnimationDirectionRightToLeft;
                    if([appDelegate.imagesArray count] >2)_transitionImageView.image = [appDelegate.imagesArray objectAtIndex:2];
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void) {
                        _transitionImageView.animationDirection = AnimationDirectionBottomToTop;
                       if([appDelegate.imagesArray count] >3) _transitionImageView.image = [appDelegate.imagesArray objectAtIndex:3];
                        
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void) {
                            [self startAnimations];
                        });
                    });
                });
            });

        }
   }
-(void)backToMain
{
    [_transitionImageView removeFromSuperview];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
