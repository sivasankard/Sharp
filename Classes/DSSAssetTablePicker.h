//
//  DSSAssetTablePicker.h
//  Sharp
//
//  Created by Siva Sankard on 12/06/13.
//  Copyright (c) 2013 RMN infoteh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "DSSAsset.h"
#import "DSSAssetSelectionDelegate.h"

@interface DSSAssetTablePicker : UITableViewController<DSSAssetDelegate>

@property (nonatomic, assign) id <DSSAssetSelectionDelegate> parent;
@property (nonatomic, retain) ALAssetsGroup *assetGroup;
@property (nonatomic, retain) NSMutableArray *dssAssets;
@property (nonatomic, retain) IBOutlet UILabel *selectedAssetsLabel;
@property (nonatomic, assign) BOOL singleSelection;
@property (nonatomic, assign) BOOL immediateReturn;

- (int)totalSelectedAssets;
- (void)preparePhotos;

- (void)doneAction:(id)sender;

- (void)assetSelected:(DSSAsset *)asset;


@end
