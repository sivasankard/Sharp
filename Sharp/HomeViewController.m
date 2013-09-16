//
//  HomeViewController.m
//  Sharp
//
//  Created by Siva Sankard on 11/06/13.
//  Copyright (c) 2013 RMN infoteh. All rights reserved.
//

#import "HomeViewController.h"
#import "FlipBoardNavigationController.h"
#import "PhotoPicViewController.h"
#import "SlideViewController.h"
#import "CropViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIImage *lanchImage = [UIImage imageNamed:@"images.jpg"];
    lanchImg = [[UIImageView alloc]initWithFrame:self.view.bounds];
    lanchImg.image = lanchImage;
    [self.view addSubview:lanchImg];
    [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(loadMainView) userInfo:nil repeats:NO];
}
-(void)loadMainView
{
    [lanchImg removeFromSuperview];
    self.view.backgroundColor = [UIColor colorWithRed:0.72 green:0.91 blue:1 alpha:1];
    UIImage *logo = [UIImage imageNamed:@"mouse.png"];
    UIImageView *logoImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, logo.size.width, logo.size.height)];
    logoImage.image = logo;
    [self.view addSubview:logoImage];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(logoImage.frame.origin.x + logoImage.frame.size.width + 10, (logoImage.frame.origin.y + logoImage.frame.size.height)/3, 150, 50)];
    titleLabel.text = @"ABC Actions";
    titleLabel.font = [UIFont italicSystemFontOfSize:26.0f];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:titleLabel];
    
    UIView *padding = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 40)];
    UIView *paddingPassword = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 40)];
    
    userName = [[UITextField alloc]initWithFrame:CGRectMake(10, logoImage.frame.origin.y + logoImage.frame.size.height, 300, 40)];
    userName.backgroundColor = [UIColor whiteColor];
    userName.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
    userName.layer.cornerRadius = 5.0;
    userName.layer.masksToBounds = YES;
    userName.leftView = padding;
    userName.delegate = self;
    userName.leftViewMode = UITextFieldViewModeAlways;
    userName.placeholder = @"UserName";
    [self.view addSubview:userName];
    
    passWord = [[UITextField alloc]initWithFrame:CGRectMake(10, userName.frame.origin.y + userName.frame.size.height+10, 300, 40)];
    passWord.backgroundColor = [UIColor whiteColor];
    passWord.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
    passWord.layer.cornerRadius = 5.0;
    passWord.layer.masksToBounds = YES;
    passWord.leftView = paddingPassword;
    passWord.delegate = self;
    passWord.leftViewMode = UITextFieldViewModeAlways;
    passWord.placeholder = @"PassWord";
    [self.view addSubview:passWord];
    
    UIButton *signUpButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    signUpButton.frame = CGRectMake(50, passWord.frame.origin.y + passWord.frame.size.height + 10, 100, 40);
    [signUpButton setTitle:@"SignUp" forState:UIControlStateNormal];
    [self.view addSubview:signUpButton];
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    loginButton.frame = CGRectMake(signUpButton.frame.origin.x + signUpButton.frame.size.width + 20, passWord.frame.origin.y + passWord.frame.size.height + 10, 100, 40);
    [loginButton setTitle:@"LogIn" forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(LoginMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    UILabel *aboutABC = [[UILabel alloc]initWithFrame:CGRectMake(10, loginButton.frame.origin.y + loginButton.frame.size.height, 300, 80)];
    aboutABC.text = @"              The New ABC Actions..\n   All the power you want. All day long.";
    aboutABC.numberOfLines = 3;
    aboutABC.font = [UIFont italicSystemFontOfSize:16.0f];
    aboutABC.textColor = [UIColor whiteColor];
    aboutABC.backgroundColor = [UIColor clearColor];
    [self.view addSubview:aboutABC];

    UIButton *forgotPAsswordButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    forgotPAsswordButton.frame = CGRectMake(80, aboutABC.frame.origin.y + aboutABC.frame.size.height, 160, 40);
    [forgotPAsswordButton setTitle:@"Forgot Password" forState:UIControlStateNormal];
    [self.view addSubview:forgotPAsswordButton];
    
    UITapGestureRecognizer *tapGester = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickMe)];

    [self.view addGestureRecognizer:tapGester];
    
}
-(void)clickMe
{
    [userName resignFirstResponder];
    [passWord resignFirstResponder];
}
-(void)LoginMethod
{
    LoadMainViewController *loadView = [[LoadMainViewController alloc]init];
    UINavigationController *loadNavController = [[UINavigationController alloc]initWithRootViewController:loadView];
    [loadNavController.navigationBar setTintColor:[UIColor lightGrayColor]];
    PhotoPicViewController *photoView = [[PhotoPicViewController alloc]init];
    UINavigationController *photoNavController = [[UINavigationController alloc]initWithRootViewController:photoView];
    [photoNavController.navigationBar setTintColor:[UIColor lightGrayColor]];
    SlideViewController *slideView = [[SlideViewController alloc]init];
    UINavigationController *slideNavController = [[UINavigationController alloc]initWithRootViewController:slideView];
    [slideNavController.navigationBar setTintColor:[UIColor lightGrayColor]];
    CropViewController *cropView = [[CropViewController alloc]init];
    UINavigationController *cropNavController = [[UINavigationController alloc]initWithRootViewController:cropView];
    [cropNavController.navigationBar setTintColor:[UIColor lightGrayColor]];
    UITabBarController *tabController = [[UITabBarController alloc]init];
    tabController.viewControllers = [NSArray arrayWithObjects:loadNavController, photoNavController, slideNavController, cropNavController, nil];
    if ([tabController.tabBar respondsToSelector:@selector(setTintColor:)]) {
        [tabController.tabBar setTintColor:[UIColor lightGrayColor]];
    }
    [self.flipboardNavigationController pushViewController:tabController];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
