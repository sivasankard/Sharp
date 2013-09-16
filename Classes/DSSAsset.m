//
//  DSSAsset.m
//  Sharp
//
//  Created by Siva Sankard on 12/06/13.
//  Copyright (c) 2013 RMN infoteh. All rights reserved.
//

#import "DSSAsset.h"
#import "DSSAssetTablePicker.h"

@implementation DSSAsset

@synthesize asset = _asset;
@synthesize parent = _parent;
@synthesize selected = _selected;

- (id)initWithAsset:(ALAsset*)asset
{
	self = [super init];
	if (self) {
		self.asset = asset;
        _selected = NO;
    }
    
	return self;
}

- (void)toggleSelection
{
    self.selected = !self.selected;
}

- (void)setSelected:(BOOL)selected
{
    _selected = selected;
    if (selected) {
        if (_parent != nil && [_parent respondsToSelector:@selector(assetSelected:)]) {
            [_parent assetSelected:self];
        }
    }
}
@end
