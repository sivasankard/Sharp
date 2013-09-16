//
//  ChangeFrameViewController.m
//  Sharp
//
//  Created by Siva Sankard on 13/06/13.
//  Copyright (c) 2013 RMN infoteh. All rights reserved.
//

#import "ChangeFrameViewController.h"
#import "UIView+Origami.h"
#import "UIImage+vImage.h"
#import "GRAlertView.h"

@interface ChangeFrameViewController ()
{
   // BOOL currDirection;
}
@end

@implementation ChangeFrameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Original";
        self.view.backgroundColor =[UIColor lightGrayColor];
    }
    return self;
}
-(void)image:(UIImage*)currentImag
{
    _currentImage = currentImag;
    _selectedBackGroundImage = currentImag;
    
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(swipeToRight)];
    self.navigationItem.rightBarButtonItem = rightBar;
    
    _centerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    _centerView.backgroundColor = [UIColor whiteColor];
    
    _selectedImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 370)];
    _selectedImage.image = _currentImage;
    [_selectedImage setBackgroundColor:[UIColor blackColor]];
    [_centerView addSubview:_selectedImage];
    
    swipeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    swipeButton.frame = CGRectMake(250, 10, 60, 30);
    [swipeButton setTitle:@"Paint" forState:UIControlStateNormal];
    [swipeButton addTarget:self action:@selector(swipeToRight) forControlEvents:UIControlEventTouchUpInside];
   // [self.centerView addSubview:swipeButton];
    
    [self.view addSubview:_centerView];
    isPaint = NO;
    
    UILongPressGestureRecognizer *tapGester = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressMethod:)];
    tapGester.minimumPressDuration = 0.5;
    [_centerView addGestureRecognizer:tapGester];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

}
-(void)viewWillDisappear:(BOOL)animated{
    if(isPaint)
    {
        [swipeButton setTitle:@"Paint" forState:UIControlStateNormal];
        [_centerView hideOrigamiTransitionWith:self.sideView
                                 NumberOfFolds:3
                                      Duration:0.7
                                     Direction:XYOrigamiDirectionFromRight
                                    completion:^(BOOL finished) {
                                    }];
    }
}

#pragma mark - Gesters.

-(void)longPressMethod:(UILongPressGestureRecognizer*)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan)
    {
        GRAlertView *alertView = [[GRAlertView alloc]initWithTitle:@"Share Photo" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Photo Library", @"FaceBook", @"Email", @"Twitter", nil];
        alertView.style = GRAlertStyleAlert;
        alertView.animation = 1;
        [alertView show];
    }
   
}

-(void)shareToList
{
    
}
-(void)swipeToRight
{
    _sideView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 168, 480)];
    _sideView.backgroundColor = [UIColor blackColor];
    
     _framesArray = [[NSMutableArray alloc]initWithObjects:@"Set Color", @"Original", @"gaussianBlur", @"edgeDetection", @"emboss", @"sharpen", @"unsharpen", @"rotate", @"dilate", @"erode", @"gradient", @"tophat", @"equalization", @"Black&White", nil];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 168, 368) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
     tableView.backgroundColor = [UIColor blackColor];
    [_sideView addSubview:tableView];
    
    
    if(!isPaint)
    {
        [swipeButton setTitle:@"Close" forState:UIControlStateNormal];
        [_centerView showOrigamiTransitionWith:_sideView
                                       NumberOfFolds:3 Duration:0.7 Direction:XYOrigamiDirectionFromRight completion:^(BOOL finished) {
                                       } ];
    }
    else
    {
        [swipeButton setTitle:@"Paint" forState:UIControlStateNormal];
        [_centerView hideOrigamiTransitionWith:self.sideView
                                           NumberOfFolds:3
                                                Duration:0.7
                                               Direction:XYOrigamiDirectionFromRight
                                              completion:^(BOOL finished) {
                                              }];
    }
    isPaint = !isPaint;

}

#pragma mark - UITableViewDelegate, DataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_framesArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [_framesArray objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont italicSystemFontOfSize:20.0f];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%d",indexPath.row);
    isColor = NO;
    switch (indexPath.row)
    {
        case 0:
            //_selectedImage.image = [self getImageWithUnsaturatedPixelsOfImage:_selectedBackGroundImage];
            //_selectedImage.image = [self getImageWithTintedColor:_selectedBackGroundImage withTint:[UIColor redColor] withIntensity:0.7];
            self.title = @"Photo with Color";
            isColor = YES;
            break;
        case 1:
            _selectedImage.image = _currentImage;
            self.title = @"Original";
            break;
        case 2:
            _selectedImage.image = [_selectedBackGroundImage gaussianBlur];
            break;
        case 3:
            _selectedImage.image = [_selectedBackGroundImage edgeDetection];
            self.title = @"edgeDetection";
            break;
        case 4:
            _selectedImage.image = [_selectedBackGroundImage emboss];
            self.title = @"emboss";
            break;
        case 5:
            _selectedImage.image = [_selectedBackGroundImage sharpen];
            self.title = @"sharpen";
            break;
        case 6:
            _selectedImage.image = [_selectedBackGroundImage unsharpen];
            self.title = @"unsharpen";
            break;
        case 7:
            _selectedImage.image = [_selectedBackGroundImage rotateInRadians:M_PI_2 * 0.3];
            self.title = @"rotate";
            break;
        case 8:
            _selectedImage.image = [_selectedBackGroundImage dilateWithIterations:3];
            self.title = @"dilate";
            break;
        case 9:
            _selectedImage.image = [_selectedBackGroundImage erodeWithIterations:3];
            self.title = @"erode";
            break;
        case 10:
            _selectedImage.image = [_selectedBackGroundImage gradientWithIterations:3];
            self.title = @"gradient";
            break;
        case 11:
            _selectedImage.image = [_selectedBackGroundImage tophatWithIterations:4];
            self.title = @"tophat";
            break;
        case 12:
            _selectedImage.image = [_selectedBackGroundImage equalization];
            self.title = @"equalization";
            break;
        case 13:
            _selectedImage.image = [self getImageWithUnsaturatedPixelsOfImage:_selectedBackGroundImage];
            self.title = @"Black&White";
            break;
        default:
            break;
    }
    [swipeButton setTitle:@"Paint" forState:UIControlStateNormal];
    [_centerView hideOrigamiTransitionWith:self.sideView
                             NumberOfFolds:3
                                  Duration:0.7
                                 Direction:XYOrigamiDirectionFromRight
                                completion:^(BOOL finished) {
                                    if(isColor)
                                    {
                                        [self changeColorPic];
                                    }
                                }];
    isPaint = NO;
    
    
}

-(UIImage *) getImageWithUnsaturatedPixelsOfImage:(UIImage *)image {
    const int RED = 1, GREEN = 2, BLUE = 3;
    
    CGRect imageRect = CGRectMake(0, 0, image.size.width*2, image.size.height*2);
    
    int width = imageRect.size.width, height = imageRect.size.height;
    
    uint32_t * pixels = (uint32_t *) malloc(width*height*sizeof(uint32_t));
    memset(pixels, 0, width * height * sizeof(uint32_t));
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(pixels, width, height, 8, width * sizeof(uint32_t), colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedLast);
    
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), [image CGImage]);
    
    for(int y = 0; y < height; y++) {
        for(int x = 0; x < width; x++) {
            uint8_t * rgbaPixel = (uint8_t *) &pixels[y*width+x];
            uint32_t gray = (0.3*rgbaPixel[RED]+0.59*rgbaPixel[GREEN]+0.11*rgbaPixel[BLUE]);
            
            rgbaPixel[RED] = gray;
            rgbaPixel[GREEN] = gray;
            rgbaPixel[BLUE] = gray;
        }
    }
    
    CGImageRef newImage = CGBitmapContextCreateImage(context);
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    free(pixels);
    
    UIImage * resultUIImage = [UIImage imageWithCGImage:newImage scale:2 orientation:0];
    CGImageRelease(newImage);
    
    return resultUIImage;
}

-(UIImage *) getImageWithTintedColor:(UIImage *)image withTint:(UIColor *)color withIntensity:(float)alpha {
    CGSize size = image.size;
    
    UIGraphicsBeginImageContextWithOptions(size, FALSE, 2);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [image drawAtPoint:CGPointZero blendMode:kCGBlendModeNormal alpha:1.0];
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextSetBlendMode(context, kCGBlendModeOverlay);
    CGContextSetAlpha(context, alpha);
    
    CGContextFillRect(UIGraphicsGetCurrentContext(), CGRectMake(CGPointZero.x, CGPointZero.y, image.size.width, image.size.height));
    
    UIImage * tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}

-(void)changeColorPic
{
    [self createSimplyfiedOrdenatedColorsArray];
    
    isColor = NO;
    colorView = [[UIView alloc]initWithFrame:CGRectMake(0, -450, 320, 245)];
    [colorView setBackgroundColor:[UIColor yellowColor]];
    [colorView setAlpha:1];
    [self.centerView addSubview:colorView];
    
    _colorScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(2, 0, 316, 210)];
    _colorScrollView.backgroundColor = [UIColor colorWithRed:0.91f green:0.99f blue:0.99f alpha:1];
    _colorScrollView.delegate = self;
    [colorView addSubview: _colorScrollView];
    
    UILabel *alpha = [[UILabel alloc]initWithFrame:CGRectMake(2, 215, 55, 25)];
    alpha.backgroundColor = [UIColor clearColor];
    alpha.text = @"Alpha:";
    [colorView addSubview:alpha];
    
    slider = [[UISlider alloc]initWithFrame:CGRectMake(55, 218, 180, 25)];
    slider.minimumValue = 0;
    slider.maximumValue = 1;
    slider.value = 1;
    [colorView addSubview:slider];
    
    [self customGridView];
    
    
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    doneButton.frame = CGRectMake(245, 220, 70, 25);
    [doneButton setTitle:@"Done" forState:UIControlStateNormal];
    [doneButton addTarget:self action:@selector(donePickingColor) forControlEvents:UIControlEventTouchUpInside];
    [colorView addSubview:doneButton];
    
     [self doAnimation:CGRectMake(0, 0, 320, 245) forView:colorView];
}

-(void)doAnimation:(CGRect)targetFrame forView:(UIView*)targetView
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.7];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:targetView cache:NO];
    targetView.frame = targetFrame;
    [UIView commitAnimations];
}

-(void)customGridView{
    int coloumn;
    float xChord = 1, yChord = 5;
    coloumn = 8;
    for(int i = 1; i <= [self.colorCollection count]; i++)
    {
        UIButton *customButton = [UIButton buttonWithType:UIButtonTypeCustom];
        customButton.frame = CGRectMake(xChord , yChord, 35, 35);
        customButton.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
        [customButton setBackgroundColor:[GzColors colorFromHex:[self.colorCollection objectAtIndex:i-1]]];
        customButton.layer.cornerRadius = 5.0f;
        customButton.layer.masksToBounds = YES;
        [customButton addTarget:self action:@selector(selectedColorButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        customButton.tag = i;
        
        [_colorScrollView addSubview:customButton];
        
        xChord += 40;
        
        if(i%coloumn == 0){
            yChord += 40;
            xChord = 1;
        }
    }
    int rowCount = [self.colorCollection count]/coloumn;
    if([self.colorCollection count]>rowCount*coloumn)
        rowCount ++;
    [_colorScrollView setContentSize:CGSizeMake(316, rowCount * 40)];
}

-(void)selectedColorButtonClicked:(id)sender
{
    int tag = [sender tag];
    selectedColor = [GzColors colorFromHex:[self.colorCollection objectAtIndex:tag-1]];
    colorView.backgroundColor = selectedColor;
}

-(void)donePickingColor
{
    _selectedImage.image = [self getImageWithTintedColor:_selectedBackGroundImage withTint:selectedColor withIntensity:slider.value];
    [self doAnimation:CGRectMake(0, -450, 320, 245) forView:colorView];
    
}

-(void) createSimplyfiedOrdenatedColorsArray{
    self.colorCollection = [NSArray arrayWithObjects:
                            
                            IndianRed,
                            LightCoral,
                            Red,
                            Crimson,
                            Firebrick,
                            DarkRed,
                            
                            Coral,
                            Tomato,
                            OrangeRed,
                            Orange,
                            Gold,
                            Yellow,
                            
                            Pink,
                            HotPink,
                            DeepPink,
                            Fuchsia,
                            Magenta,
                            Purple,
                            
                            SeaGreen,
                            ForestGreen,
                            Green,
                            DarkGreen,
                            OliveDrab,
                            Olive,
                            
                            DeepSkyBlue,
                            CornflowerBlue,
                            RoyalBlue,
                            Blue,
                            DarkBlue,
                            MidnightBlue,
                            
                            Goldenrod,
                            DarkGoldenrod,
                            Chocolate,
                            SaddleBrown,
                            Brown,
                            Maroon,
                            
                            White,
                            Snow,
                            Gainsboro,
                            LightGray,
                            Silver,
                            DarkGray,
                            
                            Gray,
                            DimGray,
                            LightSlateGray,
                            SlateGray,
                            DarkSlateGray,
                            Black, nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
