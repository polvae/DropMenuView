//
//  TwoTypeContentView.h
//  TStyleMenuView
//
//  Created by KingSoft on 17/4/13.
//  Copyright © 2017年 Sen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^myBlockAction)(NSDictionary *);

@interface TwoTypeContentView : UIView

@property (nonatomic, copy)myBlockAction cllickAction;
@property (nonatomic, strong)NSMutableArray *selectedItem;
@property (nonatomic, strong) NSArray  *dataArr;

@end
