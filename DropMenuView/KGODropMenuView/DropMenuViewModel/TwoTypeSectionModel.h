//
//  TwoTypeSectionModel.h
//  TStyleMenuView
//
//  Created by KingSoft on 17/4/14.
//  Copyright © 2017年 Sen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TwoTypeSectionModel : NSObject

@property (nonatomic, copy)NSString *sectionStr;
@property (nonatomic, strong)NSMutableArray *rowTypeArr;
@property (nonatomic, assign)NSUInteger selectNum;

@end
