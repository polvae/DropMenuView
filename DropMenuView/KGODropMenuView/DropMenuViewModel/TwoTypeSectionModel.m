//
//  TwoTypeSectionModel.m
//  TStyleMenuView
//
//  Created by KingSoft on 17/4/14.
//  Copyright © 2017年 Sen. All rights reserved.
//

#import "TwoTypeSectionModel.h"
#import "TwoTypeRowModel.h"

@implementation TwoTypeSectionModel
-(NSMutableArray *)rowTypeArr{
    if (!_rowTypeArr) {
        _rowTypeArr = [NSMutableArray new];
    }
    return _rowTypeArr;
}

-(void)setValue:(id)value forKey:(NSString *)key{
    if ([key isEqualToString:@"rowTypeArr"]) {
        for (int i = 0; i < [value count]; i++) {
            TwoTypeRowModel *model = [TwoTypeRowModel new];

            if (self.selectNum == i) {
                model.isSelected = YES;
            }else{
                model.isSelected = NO;
            }
            [model setValuesForKeysWithDictionary:value[i]];
            [self.rowTypeArr  addObject:model];
            
        }
        
    }else{
        [super setValue:value forKey:key];
    }
}

@end
