//
//  DSSAssetTablePicker.m
//  Sharp
//
//  Created by Siva Sankard on 12/06/13.
//  Copyright (c) 2013 RMN infoteh. All rights reserved.
//

#import "DSSAssetTablePicker.h"
#import "DSSAssetCell.h"
#import "DSSAsset.h"
#import "DSSAlbumPickerController.h"

@interface DSSAssetTablePicker ()

@property (nonatomic, assign) int columns;

@end

@implementation DSSAssetTablePicker

@synthesize parent = _parent;;
@synthesize selectedAssetsLabel = _selectedAssetsLabel;
@synthesize assetGroup = _assetGroup;
@synthesize dssAssets = _dssAssets;
@synthesize singleSelection = _singleSelection;
@synthesize columns = _columns;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
	[self.tableView setAllowsSelection:NO];
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    self.dssAssets = tempArray;
	
    if (self.immediateReturn) {
        
    } else {
        UIBarButtonItem *doneButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneAction:)];
        [self.navigationItem setRightBarButtonItem:doneButtonItem];
        [self.navigationItem setTitle:@"Loading..."];
    }
    
	[self performSelectorInBackground:@selector(preparePhotos) withObject:nil];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.columns = self.view.bounds.size.width / 80;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    self.columns = self.view.bounds.size.width / 80;
    [self.tableView reloadData];
}

- (void)preparePhotos
{    
    NSLog(@"enumerating photos");
    [self.assetGroup enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
        
        if(result == nil) {
            return;
        }
        
        DSSAsset *dssAsset = [[DSSAsset alloc] initWithAsset:result];
        [dssAsset setParent:self];
        [self.dssAssets addObject:dssAsset];
    }];
    NSLog(@"done enumerating photos");
    
    dispatch_sync(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        // scroll to bottom
        int section = [self numberOfSectionsInTableView:self.tableView] - 1;
        int row = [self tableView:self.tableView numberOfRowsInSection:section] - 1;
        if (section >= 0 && row >= 0) {
            NSIndexPath *ip = [NSIndexPath indexPathForRow:row
                                                 inSection:section];
            [self.tableView scrollToRowAtIndexPath:ip
                                  atScrollPosition:UITableViewScrollPositionBottom
                                          animated:NO];
        }
        
        [self.navigationItem setTitle:self.singleSelection ? @"Pick Photo" : @"Pick Photos"];
    });
        
}

- (void)doneAction:(id)sender
{
	NSMutableArray *selectedAssetsImages = [[NSMutableArray alloc] init];
    
	for(DSSAsset *dssAsset in self.dssAssets) {
        
		if([dssAsset selected]) {
			
			[selectedAssetsImages addObject:[dssAsset asset]];
		}
	}
    
    [self.parent selectedAssets:selectedAssetsImages];
}

- (void)assetSelected:(id)asset
{
    if (self.singleSelection) {
        
        for(DSSAsset *dssAsset in self.dssAssets) {
            if(asset != dssAsset) {
                dssAsset.selected = NO;
            }
        }
    }
    if (self.immediateReturn) {
        NSArray *singleAssetArray = [NSArray arrayWithObject:[asset asset]];
        [(NSObject *)self.parent performSelector:@selector(selectedAssets:) withObject:singleAssetArray afterDelay:0];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return ceil([self.dssAssets count]/(float)self.columns);
}
- (NSArray *)assetsForIndexPath:(NSIndexPath *)path
{
    int index = path.row * self.columns;
    int length = MIN(self.columns, [self.dssAssets count] - index);
    return [self.dssAssets subarrayWithRange:NSMakeRange(index, length)];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    DSSAssetCell *cell = (DSSAssetCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[DSSAssetCell alloc] initWithAssets:[self assetsForIndexPath:indexPath] reuseIdentifier:CellIdentifier];
        
    } else {
		[cell setAssets:[self assetsForIndexPath:indexPath]];
	}
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	return 79;
}

- (int)totalSelectedAssets {
    
    int count = 0;
    
    for(DSSAsset *asset in self.dssAssets) {
		if([asset selected]) {
            count++;
		}
	}
    
    return count;
}


@end
