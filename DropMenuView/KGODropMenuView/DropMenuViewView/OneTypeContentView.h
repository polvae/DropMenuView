//
//  ContentView.h
//  TStyleMenuView
//
//  Created by KingSoft on 17/4/13.
//  Copyright © 2017年 Sen. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^oneTypeBlockAction)(NSDictionary *);

@interface OneTypeContentView : UIView

@property (nonatomic, copy)oneTypeBlockAction clickAction;
@property (nonatomic, strong)NSArray *addressArr;

@end
