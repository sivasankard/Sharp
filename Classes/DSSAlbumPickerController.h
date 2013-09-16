//
//  DSSAlbumPickerController.h
//  Sharp
//
//  Created by Siva Sankard on 12/06/13.
//  Copyright (c) 2013 RMN infoteh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "DSSAssetSelectionDelegate.h"


@interface DSSAlbumPickerController : UITableViewController<DSSAssetSelectionDelegate>

@property (nonatomic, assign) id<DSSAssetSelectionDelegate> parent;
@property (nonatomic, retain) NSMutableArray *assetGroups;

@end
