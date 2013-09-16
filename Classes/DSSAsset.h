//
//  DSSAsset.h
//  Sharp
//
//  Created by Siva Sankard on 12/06/13.
//  Copyright (c) 2013 RMN infoteh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@class DSSAsset;

@protocol DSSAssetDelegate <NSObject>

@optional
- (void)assetSelected:(DSSAsset *)asset;

@end

@interface DSSAsset : NSObject

@property (nonatomic, retain) ALAsset *asset;
@property (nonatomic, assign) id<DSSAssetDelegate> parent;
@property (nonatomic, assign) BOOL selected;

- (id)initWithAsset:(ALAsset *)asset;

@end
