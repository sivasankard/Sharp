//
//  MaskViewController.m
//  Sharp
//
//  Created by Siva Sankard on 13/06/13.
//  Copyright (c) 2013 RMN infoteh. All rights reserved.
//

#import "MaskViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface MaskViewController ()

@end

@implementation MaskViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        NSString   *hexString = @"0xFFB0E0E6";
        unsigned rgbValue = 0;
        NSScanner *scanner = [NSScanner scannerWithString:hexString];
        [scanner setScanLocation:1]; // bypass '#' character
        [scanner scanHexInt:&rgbValue];
        
        self.view.backgroundColor  = [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIBarButtonItem *settingsBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(settingsMethod)];
    self.navigationItem.rightBarButtonItem = settingsBtn;
    
}


- (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

-(void)settingsMethod
{
    _scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 315, 320, 50)];
  //  _scroll.backgroundColor = [UIColor clearColor];
    _scroll.layer.borderColor = [UIColor whiteColor].CGColor;
    _scroll.layer.borderWidth = 2.0f;
    [_scroll setBackgroundColor:[UIColor colorWithWhite:1.0f alpha:0.5f]];
    _scroll.scrollEnabled = YES;
    _scroll.showsHorizontalScrollIndicator = YES;
    [self.view addSubview:_scroll];
    
    masksArrayList = [[NSMutableArray alloc]initWithObjects:[UIImage imageNamed:@"1371145107_Mask.png"],[UIImage imageNamed:@"1371145107_Mask.png"],[UIImage imageNamed:@"1371145107_Mask.png"],[UIImage imageNamed:@"1371145107_Mask.png"],[UIImage imageNamed:@"1371145107_Mask.png"],[UIImage imageNamed:@"1371145107_Mask.png"],[UIImage imageNamed:@"1371145107_Mask.png"],[UIImage imageNamed:@"1371145107_Mask.png"],[UIImage imageNamed:@"1371145107_Mask.png"],[UIImage imageNamed:@"1371145107_Mask.png"], nil];
    
    
    [self customGridViewWithPortraitMode];
    
}
-(void)maskImage : (UIImage*)currentImage
{
    _selectedImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 300, 370)];
    _selectedImage.image = currentImage;
    _selectedImage.userInteractionEnabled = YES;
    [self.view addSubview:_selectedImage];
    
}

-(void)customGridViewWithPortraitMode
{
    float xChord = 1, yChord = 2.5;
    for(int i = 1; i <= [masksArrayList count]; i++)
    {
        UIButton *customButton = [UIButton buttonWithType:UIButtonTypeCustom];
        customButton.frame = CGRectMake(xChord , yChord, 45, 45);
        customButton.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
        [customButton setImage:[masksArrayList objectAtIndex:i-1] forState:UIControlStateNormal];
        customButton.backgroundColor = [UIColor clearColor];
        customButton.layer.cornerRadius = 5.0f;
        customButton.layer.masksToBounds = YES;
        [customButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        customButton.tag = i;
        
        [_scroll addSubview:customButton];
        
        xChord += 47.5;
    }
    [_scroll setContentSize:CGSizeMake([masksArrayList count]*47.5, 50)];
}
-(void)buttonClicked:(id)sender
{
    //[_maskImg removeFromSuperview];
    _maskImg = [[UIImageView alloc]initWithFrame:CGRectMake(50, 300, 70, 70)];
    _maskImg.image = [masksArrayList objectAtIndex:[sender tag]];
    _maskImg.userInteractionEnabled = YES;
    _maskImg.layer.cornerRadius= 5.0;
    _maskImg.layer.masksToBounds = YES;
     [self.view addSubview:_maskImg];
    
    _lastScale = 0;
    
    UIPanGestureRecognizer * pan1 = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(moveObject:)];
    pan1.minimumNumberOfTouches = 1;
    [_maskImg addGestureRecognizer:pan1];
    
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchObject:)];
    [_maskImg addGestureRecognizer:pinch];
    
    UIRotationGestureRecognizer *rotate = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotateObject:)];
    [_maskImg addGestureRecognizer:rotate];
    
    [_scroll removeFromSuperview];

}
-(void)moveObject:(UIPanGestureRecognizer *)pan;
{
    _maskImg.center = [pan locationInView:_maskImg.superview];
}
-(void)pinchObject:(UIPinchGestureRecognizer *)sender
{
    if([(UIPinchGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
        _lastScale = 1.0;
    }
    
    CGFloat scale = 1.0 - (_lastScale - [(UIPinchGestureRecognizer*)sender scale]);
    
    CGAffineTransform currentTransform = _maskImg.transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, scale, scale);
    
    [_maskImg setTransform:newTransform];
    
    _lastScale = [(UIPinchGestureRecognizer*)sender scale];

}
-(void)rotateObject:(UIRotationGestureRecognizer*)sender
{
    if([(UIRotationGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
        
        _lastRotation = 0.0;
        return;
    }
    
    CGFloat rotation = 0.0 - (_lastRotation - [(UIRotationGestureRecognizer*)sender rotation]);
    
    CGAffineTransform currentTransform = _maskImg.transform;
    CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform,rotation);
    
    [_maskImg setTransform:newTransform];
    
    _lastRotation = [(UIRotationGestureRecognizer*)sender rotation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
