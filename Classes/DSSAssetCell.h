//
//  DSSAssetCell.h
//  Sharp
//
//  Created by Siva Sankard on 12/06/13.
//  Copyright (c) 2013 RMN infoteh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSSAssetCell : UITableViewCell

- (id)initWithAssets:(NSArray *)assets reuseIdentifier:(NSString *)identifier;
- (void)setAssets:(NSArray *)assets;


@end
