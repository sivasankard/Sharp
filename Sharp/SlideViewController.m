//
//  NewsViewController.m
//  Sharp
//
//  Created by Siva Sankard on 11/06/13.
//  Copyright (c) 2013 RMN infoteh. All rights reserved.
//

#import "SlideViewController.h"

@interface SlideViewController ()

@end

@implementation SlideViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
       // self.title = @"Slide";
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.navigationItem.title = @"Slideshow";
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"slide" image:[UIImage imageNamed:@"Filmstrip.png"] tag:0];
    
    //UIBarButtonItem *picImages = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(picPhotosMethod)];
    //self.navigationItem.rightBarButtonItem = picImages;
    
    UILabel *selectImagesLal = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 150, 20)];
    selectImagesLal.backgroundColor = [UIColor clearColor];
    selectImagesLal.text = @"Select Images : ";
    [self.view addSubview:selectImagesLal];
    
    UIButton *selectImagesButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    selectImagesButton.frame = CGRectMake(selectImagesLal.frame.origin.x+selectImagesLal.frame.size.width, 16, 120, 30);
    [selectImagesButton setTitle:@"New Images" forState:UIControlStateNormal];
    [selectImagesButton addTarget:self action:@selector(picPhotosMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:selectImagesButton];
    
    UILabel *selectSongLal = [[UILabel alloc]initWithFrame:CGRectMake(10, 70, 150, 20)];
    selectSongLal.backgroundColor = [UIColor clearColor];
    selectSongLal.text = @"Select Song : ";
    [self.view addSubview:selectSongLal];
    
    UIButton *selectSongsButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    selectSongsButton.frame = CGRectMake(selectSongLal.frame.origin.x+selectSongLal.frame.size.width, 66, 120, 30);
    [selectSongsButton setTitle:@"New Song" forState:UIControlStateNormal];
    // [selectImagesButton addTarget:self action:@selector(uploadImagesMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:selectSongsButton];
    
    
    newsLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 120, 300, 50)];
    newsLabel.numberOfLines = 2;
    newsLabel.backgroundColor = [UIColor clearColor];
    newsLabel.textAlignment = UITextAlignmentCenter;
    newsLabel.text = @"No new images selected.";
    [self.view addSubview:newsLabel];
    
    UILabel *slideShowLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 200, 150, 20)];
    slideShowLbl.backgroundColor = [UIColor clearColor];
    slideShowLbl.text = @"Slide Show : ";
    [self.view addSubview:slideShowLbl];
    
    UIButton *slideShowButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    slideShowButton.frame = CGRectMake(slideShowLbl.frame.origin.x+slideShowLbl.frame.size.width, 196, 120, 30);
    [slideShowButton setTitle:@"SlideShow" forState:UIControlStateNormal];
    [slideShowButton addTarget:self action:@selector(slideShowMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:slideShowButton];
}

-(void)picPhotosMethod
{
    
}

-(void)slideShowMethod
{
    SlideDetailViewController *slideDetailView = [[SlideDetailViewController alloc]init];
    [self presentViewController:slideDetailView animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
