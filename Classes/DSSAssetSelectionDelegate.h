//
//  DSSAssetSelectionDelegate.h
//  Sharp
//
//  Created by Siva Sankard on 12/06/13.
//  Copyright (c) 2013 RMN infoteh. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DSSAssetSelectionDelegate <NSObject>

- (void)selectedAssets:(NSArray *)assets;

@end

