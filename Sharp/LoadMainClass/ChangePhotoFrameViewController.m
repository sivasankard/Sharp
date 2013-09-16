//
//  ChangePhotoFrameViewController.m
//  Sharp
//
//  Created by Siva Sankard on 12/06/13.
//  Copyright (c) 2013 RMN infoteh. All rights reserved.
//

#import "ChangePhotoFrameViewController.h"
#import "UIImage+vImage.h"

static CGFloat ImageHeight  = 150.0;
static CGFloat ImageWidth  = 320.0;

@interface ChangePhotoFrameViewController ()

@end

@implementation ChangePhotoFrameViewController

- (void)updateImg {
    CGFloat yOffset   = _tableView.contentOffset.y;
    
    if (yOffset < 0) {
        
        CGFloat factor = ((ABS(yOffset)+ImageHeight)*ImageWidth)/ImageHeight;
        CGRect f = CGRectMake(-(factor-ImageWidth)/2, 0, factor, ImageHeight+ABS(yOffset));
        self.imgProfile.frame = f;
    } else {
        CGRect f = self.imgProfile.frame;
        f.origin.y = -yOffset;
        self.imgProfile.frame = f;
    }
}
-(void)image:(UIImage*)currentImag
{
    _selectedImage = currentImag;
    _originalImg = currentImag;
    self.imgProfile = [[UIImageView alloc] initWithImage:_selectedImage];
    self.imgProfile.frame = CGRectMake(0, 0, ImageWidth, ImageHeight);
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.imgProfile];
    [self.view addSubview:self.tableView];
}
- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor blackColor]; //[UIColor colorWithRed:0.91f green:0.99f blue:0.99f alpha:1];
        
        _framesArray = [[NSMutableArray alloc]initWithObjects:@"Original", @"gaussianBlur", @"edgeDetection", @"emboss", @"sharpen", @"unsharpen", @"rotate", @"dilate", @"erode", @"gradient", @"tophat", @"equalization", nil];
        
        self.title = @"Original";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    CGRect bounds = self.view.bounds;
    _tableView.frame = bounds;
}

#pragma mark - Table View Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self updateImg];
}

#pragma mark - Table View Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0)
		return 1;
	else
		return [_framesArray count];
	
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0)
		return ImageHeight;
    else
		return 44.0;
	
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellReuseIdentifier   = @"SectionTwoCell";
    NSString *windowReuseIdentifier = @"SectionOneCell";
    
    UITableViewCell *cell = nil;
    
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:windowReuseIdentifier];
        if (!cell) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:windowReuseIdentifier];
        }
    } else {
      //  cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
        
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseIdentifier];
           // cell.contentView.backgroundColor = [UIColor colorWithRed:0.12f green:0.23f blue:0.39f alpha:1];
            
            UIImageView *cellImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 43)];
            cellImage.backgroundColor = [UIColor colorWithRed:0.12f green:0.23f blue:0.39f alpha:1];
            cellImage.userInteractionEnabled = YES;
            [cell.contentView addSubview:cellImage];
            
            cell.textLabel.text = [_framesArray objectAtIndex:indexPath.row];
            cell.textLabel.font = [UIFont italicSystemFontOfSize:20.0f];
            cell.textLabel.textColor = [UIColor whiteColor];
        
        }
       

    }
    
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
    return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%d",indexPath.row);
    switch (indexPath.row)
    {
        case 0:
            _imgProfile.image = _originalImg;
            self.title = @"Original";
            break;
        case 1:
            _imgProfile.image = [self.selectedImage gaussianBlur];
            break;
        case 2:
            _imgProfile.image = [self.selectedImage edgeDetection];
            self.title = @"edgeDetection";
            break;
        case 3:
            _imgProfile.image = [self.selectedImage emboss];
            self.title = @"emboss";
            break;
        case 4:
            _imgProfile.image = [self.selectedImage sharpen];
            self.title = @"sharpen";
            break;
        case 5:
            _imgProfile.image = [self.selectedImage unsharpen];
            self.title = @"unsharpen";
            break;
        case 6:
            _imgProfile.image = [self.selectedImage rotateInRadians:M_PI_2 * 0.3];
            self.title = @"rotate";
            break;
        case 7:
            _imgProfile.image = [self.selectedImage dilateWithIterations:3];
            self.title = @"dilate";
            break;
        case 8:
            _imgProfile.image = [self.selectedImage erodeWithIterations:3];
            self.title = @"erode";
            break;
        case 9:
            _imgProfile.image = [self.selectedImage gradientWithIterations:3];
            self.title = @"gradient";
            break;
        case 10:
            _imgProfile.image = [self.selectedImage tophatWithIterations:4];
            self.title = @"tophat";
            break;
        case 11:
            _imgProfile.image = [self.selectedImage equalization];
            self.title = @"equalization";
            break;
        default:
            break;
    }

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
