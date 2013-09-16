//
//  LoadMainViewController.m
//  Sharp
//
//  Created by Siva Sankard on 11/06/13.
//  Copyright (c) 2013 RMN infoteh. All rights reserved.
//

#import "LoadMainViewController.h"
#import "FlipBoardNavigationController.h"
#import "DSSImagePickerController.h"
#import "DSSAlbumPickerController.h"
#import "DSSAssetTablePicker.h"
#import "HomeAppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "ChangeFrameViewController.h"


@interface LoadMainViewController ()

@property (nonatomic, retain) ALAssetsLibrary *specialLibrary;

@end

@implementation LoadMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor whiteColor];
       // self.title = @"Library";
        self.navigationItem.title = @"Photo Library";
        //_imagesArray = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _appDelegate = (HomeAppDelegate*)[[UIApplication sharedApplication]delegate];
    
    UIBarButtonItem *signOut = [[UIBarButtonItem alloc]initWithTitle:@"SignOut" style:UIBarButtonItemStyleBordered target:self action:@selector(signOutMethod)];
    self.navigationItem.leftBarButtonItem = signOut;
    
    UIBarButtonItem *picImages = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(picPhotosMethod)];
    self.navigationItem.rightBarButtonItem = picImages;
    
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Gallary" image:[UIImage imageNamed:@"Image_capture.png"] tag:0];
   // self.tabBarItem = [UITabBarItem alloc]in
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(2, 0, 316, 365)];
    _scrollView.backgroundColor = [UIColor colorWithRed:0.91f green:0.99f blue:0.99f alpha:1];
    _scrollView.delegate = self;
    [self.view addSubview: _scrollView];
    
    _picTitleLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 130, 300, 50)];
    _picTitleLable.text = @"Press + to get images from your gallary";
    _picTitleLable.numberOfLines = 2;
    _picTitleLable.textAlignment = UITextAlignmentCenter;
    _picTitleLable.textColor = [UIColor lightGrayColor];
    _picTitleLable.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:_picTitleLable];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.columns = self.view.bounds.size.width / 80;
    if([_appDelegate.imagesArray count]>0)
    {
        [self customGridViewWithPortraitMode];
        [_picTitleLable removeFromSuperview];
    }
}

-(void)picPhotosMethod
{
    DSSAlbumPickerController *albumController = [[DSSAlbumPickerController alloc] initWithNibName: nil bundle: nil];
	DSSImagePickerController *elcPicker = [[DSSImagePickerController alloc] initWithRootViewController:albumController];
    [albumController setParent:elcPicker];
	[elcPicker setDelegate:self];
    
    if ([self.tabBarController respondsToSelector:@selector(presentViewController:animated:completion:)]){
        [self.tabBarController presentViewController:elcPicker animated:YES completion:nil];
    } else {
        [self.tabBarController presentModalViewController:elcPicker animated:YES];
    }

}

-(void)signOutMethod
{
    [self.tabBarController.flipboardNavigationController popViewController];
}
#pragma mark DSSImagePickerControllerDelegate Methods

- (void)dssImagePickerController:(DSSImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
{
    [self dismissModalViewControllerAnimated:YES];
    if ([self.tabBarController respondsToSelector:@selector(dismissViewControllerAnimated:completion:)]){
        [self.tabBarController dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.tabBarController dismissModalViewControllerAnimated:YES];
    }
    
    for (NSDictionary *dict in info)
    {
        UIImage *image = [dict objectForKey:UIImagePickerControllerOriginalImage];
        [_appDelegate.imagesArray addObject:image];
    }
  
    [_picTitleLable removeFromSuperview];
    [self customGridViewWithPortraitMode];

/*  //  [_tableView reloadInputViews];
	
//    for (UIView *v in [_scrollView subviews]) {
//        [v removeFromSuperview];
//    }
//    
//	CGRect workingFrame = _scrollView.frame;
//	workingFrame.origin.x = 0;
//    
//    NSMutableArray *images = [NSMutableArray arrayWithCapacity:[info count]];
//	
//	for(NSDictionary *dict in info) {
//        
//        UIImage *image = [dict objectForKey:UIImagePickerControllerOriginalImage];
//        [images addObject:image];
//        
//		UIImageView *imageview = [[UIImageView alloc] initWithImage:image];
//		[imageview setContentMode:UIViewContentModeScaleAspectFit];
//		imageview.frame = workingFrame;
//		
//		[_scrollView addSubview:imageview];
//		[imageview release];
//		
//		workingFrame.origin.x = workingFrame.origin.x + workingFrame.size.width;
//	}
//    
//    self.chosenImages = images;
//	
//	[_scrollView setPagingEnabled:YES];
//	[_scrollView setContentSize:CGSizeMake(workingFrame.origin.x, workingFrame.size.height)];*/
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



- (void)dssImagePickerControllerDidCancel:(DSSImagePickerController *)picker
{
    if ([self respondsToSelector:@selector(dismissViewControllerAnimated:completion:)]){
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self dismissModalViewControllerAnimated:YES];
    }
}

-(void)buttonClicked:(id)sender
{
    NSLog(@"%d",[sender tag]);
    int senderTag = [sender tag];
    ChangeFrameViewController *changeFrame = [[ChangeFrameViewController alloc]init];
    [changeFrame image:[_appDelegate.imagesArray objectAtIndex:senderTag-1]];
    [self.navigationController pushViewController:changeFrame animated:YES];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
