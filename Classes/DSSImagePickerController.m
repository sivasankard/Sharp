//
//  DSSImagePickerControllerViewController.m
//  Sharp
//
//  Created by Siva Sankard on 12/06/13.
//  Copyright (c) 2013 RMN infoteh. All rights reserved.
//

#import "DSSImagePickerController.h"
#import "DSSAsset.h"
#import "DSSAssetCell.h"
#import "DSSAssetTablePicker.h"
#import "DSSAlbumPickerController.h"

@interface DSSImagePickerController ()

@end

@implementation DSSImagePickerController

@synthesize delegate = _myDelegate;

- (void)cancelImagePicker
{
	if([_myDelegate respondsToSelector:@selector(dssImagePickerControllerDidCancel:)]) {
		[_myDelegate performSelector:@selector(dssImagePickerControllerDidCancel:) withObject:self];
	}
}

- (void)selectedAssets:(NSArray *)assets
{
	NSMutableArray *returnArray = [[NSMutableArray alloc] init];
	
	for(ALAsset *asset in assets) {
        
		NSMutableDictionary *workingDictionary = [[NSMutableDictionary alloc] init];
		[workingDictionary setObject:[asset valueForProperty:ALAssetPropertyType] forKey:@"UIImagePickerControllerMediaType"];
        ALAssetRepresentation *assetRep = [asset defaultRepresentation];
        
        CGImageRef imgRef = [assetRep fullScreenImage];
        UIImage *img = [UIImage imageWithCGImage:imgRef
                                           scale:[UIScreen mainScreen].scale
                                     orientation:UIImageOrientationUp];
        [workingDictionary setObject:img forKey:@"UIImagePickerControllerOriginalImage"];
		[workingDictionary setObject:[[asset valueForProperty:ALAssetPropertyURLs] valueForKey:[[[asset valueForProperty:ALAssetPropertyURLs] allKeys] objectAtIndex:0]] forKey:@"UIImagePickerControllerReferenceURL"];
		
		[returnArray addObject:workingDictionary];
		
	}
	if(_myDelegate != nil && [_myDelegate respondsToSelector:@selector(dssImagePickerController:didFinishPickingMediaWithInfo:)]) {
		[_myDelegate performSelector:@selector(dssImagePickerController:didFinishPickingMediaWithInfo:) withObject:self withObject:[NSArray arrayWithArray:returnArray]];
	} else {
        [self popToRootViewControllerAnimated:NO];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return YES;
    } else {
        return toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
    }
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning
{
    NSLog(@"ELC Image Picker received memory warning.");
    
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}


@end
