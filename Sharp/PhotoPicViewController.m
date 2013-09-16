//
//  PhotoPicViewController.m
//  Sharp
//
//  Created by Siva Sankard on 11/06/13.
//  Copyright (c) 2013 RMN infoteh. All rights reserved.
//

#import "PhotoPicViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "MaskViewController.h"

@interface PhotoPicViewController ()

@end

@implementation PhotoPicViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _appDelegate = (HomeAppDelegate*)[[UIApplication sharedApplication]delegate];
    
    self.navigationItem.title = @"Mask";
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@" Mask" image:[UIImage imageNamed:@"Mask.png"] tag:0];
    
   // UIBarButtonItem *picImages = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(picPhotosMethod)];
  //  self.navigationItem.rightBarButtonItem = picImages;
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(2, 0, 316, 365)];
    _scrollView.backgroundColor = [UIColor colorWithRed:0.91f green:0.99f blue:0.99f alpha:1];
    _scrollView.delegate = self;
    [self.view addSubview: _scrollView];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    if([_appDelegate.imagesArray count]>0) [self customGridViewWithPortraitMode];
}

-(void)picPhotosMethod
{
    
}
-(void)customGridViewWithPortraitMode{
    int coloumn;
    float xChord = 1, yChord = 5;
    coloumn = 4;
    for(int i = 1; i <= [_appDelegate.imagesArray count]; i++)
    {
        UIButton *customButton = [UIButton buttonWithType:UIButtonTypeCustom];
        customButton.frame = CGRectMake(xChord , yChord, 75, 75);
        customButton.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
        [customButton setImage:[_appDelegate.imagesArray objectAtIndex:i-1] forState:UIControlStateNormal];
        customButton.backgroundColor = [UIColor blackColor];
        customButton.layer.cornerRadius = 5.0f;
        customButton.layer.masksToBounds = YES;
        [customButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        customButton.tag = i;
        
        [_scrollView addSubview:customButton];
        
        xChord += 80;
        
        if(i%coloumn == 0){
            yChord += 80;
            xChord = 1;
        }
    }
    int rowCount = [_appDelegate.imagesArray count]/coloumn;
    if([_appDelegate.imagesArray count]>rowCount*coloumn)
        rowCount ++;
    [_scrollView setContentSize:CGSizeMake(316, rowCount * 80)];
}
-(void)buttonClicked:(id)sender
{
    NSLog(@"%d",[sender tag]);
    int senderTag = [sender tag];
    MaskViewController *maskView = [[MaskViewController alloc]init];
    [maskView maskImage:[_appDelegate.imagesArray objectAtIndex:senderTag-1]];
    [self.navigationController pushViewController:maskView animated:YES];
    
//    ChangeFrameViewController *changeFrame = [[ChangeFrameViewController alloc]init];
//    [changeFrame image:[_appDelegate.imagesArray objectAtIndex:senderTag-1]];
//    [self.navigationController pushViewController:changeFrame animated:YES];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
