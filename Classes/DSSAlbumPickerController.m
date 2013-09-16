//
//  DSSAlbumPickerController.m
//  Sharp
//
//  Created by Siva Sankard on 12/06/13.
//  Copyright (c) 2013 RMN infoteh. All rights reserved.
//

#import "DSSAlbumPickerController.h"
#import "DSSImagePickerController.h"
#import "DSSAssetTablePicker.h"

@interface DSSAlbumPickerController ()

@property (nonatomic, retain) ALAssetsLibrary *library;

@end

@implementation DSSAlbumPickerController

@synthesize parent = _parent;
@synthesize assetGroups = _assetGroups;
@synthesize library = _library;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	[self.navigationItem setTitle:@"Loading..."];
    [self.navigationController.navigationBar setTintColor:[UIColor lightGrayColor]];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self.parent action:@selector(cancelImagePicker)];
	[self.navigationItem setRightBarButtonItem:cancelButton];
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
	self.assetGroups = tempArray;
    
    ALAssetsLibrary *assetLibrary = [[ALAssetsLibrary alloc] init];
    self.library = assetLibrary;
    
    // Load Albums into assetGroups
    dispatch_async(dispatch_get_main_queue(), ^
                   {                       
                       // Group enumerator Block
                       void (^assetGroupEnumerator)(ALAssetsGroup *, BOOL *) = ^(ALAssetsGroup *group, BOOL *stop)
                       {
                           if (group == nil) {
                               return;
                           }
                           
                           // added fix for camera albums order
                           NSString *sGroupPropertyName = (NSString *)[group valueForProperty:ALAssetsGroupPropertyName];
                           NSUInteger nType = [[group valueForProperty:ALAssetsGroupPropertyType] intValue];
                           
                           if ([[sGroupPropertyName lowercaseString] isEqualToString:@"camera roll"] && nType == ALAssetsGroupSavedPhotos) {
                               [self.assetGroups insertObject:group atIndex:0];
                           }
                           else {
                               [self.assetGroups addObject:group];
                           }
                           
                           // Reload albums
                           [self performSelectorOnMainThread:@selector(reloadTableView) withObject:nil waitUntilDone:YES];
                       };
                       
                       // Group Enumerator Failure Block
                       void (^assetGroupEnumberatorFailure)(NSError *) = ^(NSError *error) {
                           
                           UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"Album Error: %@ - %@", [error localizedDescription], [error localizedRecoverySuggestion]] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                           [alert show];
                           
                           NSLog(@"A problem occured %@", [error description]);	                                 
                       };	
                       
                       // Enumerate Albums
                       [self.library enumerateGroupsWithTypes:ALAssetsGroupAll
                                                   usingBlock:assetGroupEnumerator 
                                                 failureBlock:assetGroupEnumberatorFailure];
            });    

}


- (void)reloadTableView
{
	[self.tableView reloadData];
	[self.navigationItem setTitle:@"Select an Album"];
}

- (void)selectedAssets:(NSArray*)assets
{
	[_parent selectedAssets:assets];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.assetGroups count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Get count
    ALAssetsGroup *g = (ALAssetsGroup*)[self.assetGroups objectAtIndex:indexPath.row];
    [g setAssetsFilter:[ALAssetsFilter allPhotos]];
    NSInteger gCount = [g numberOfAssets];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ (%d)",[g valueForProperty:ALAssetsGroupPropertyName], gCount];
    [cell.imageView setImage:[UIImage imageWithCGImage:[(ALAssetsGroup*)[self.assetGroups objectAtIndex:indexPath.row] posterImage]]];
	[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];

    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DSSAssetTablePicker *picker = [[DSSAssetTablePicker alloc] initWithNibName: nil bundle: nil];
	picker.parent = self;
    
    picker.assetGroup = [self.assetGroups objectAtIndex:indexPath.row];
    [picker.assetGroup setAssetsFilter:[ALAssetsFilter allPhotos]];
    
	[self.navigationController pushViewController:picker animated:YES];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	return 57;
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


@end
