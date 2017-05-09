//
//  TwoTypeCollectionViewCell.h
//  TStyleMenuView
//
//  Created by KingSoft on 17/4/13.
//  Copyright © 2017年 Sen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TwoTypeRowModel.h"

typedef void(^myBlockType)(BOOL);

@interface TwoTypeCollectionViewCell : UICollectionViewCell

@property (nonatomic, copy)myBlockType clickAction;
- (void)refreshUI:(TwoTypeRowModel *)mode;

@end
