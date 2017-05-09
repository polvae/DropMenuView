//
//  TwoTypeCollectionViewCell.m
//  TStyleMenuView
//
//  Created by KingSoft on 17/4/13.
//  Copyright © 2017年 Sen. All rights reserved.
//

#import "TwoTypeCollectionViewCell.h"
#import "UIView+Extension.h"

@interface TwoTypeCollectionViewCell ()
@property (nonatomic, strong)UIButton *typeBtn;

@end

@implementation TwoTypeCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        
        [self buildSubView];
    }
    return self;
}

- (void)buildSubView{
    UIButton *typeBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.kwidth, self.kheight)];
    [typeBtn setTitleColor:[UIColor colorWithRed:(153)/255.0 green:(153)/255.0 blue:(153)/255.0 alpha:(1)] forState:UIControlStateNormal];
    [typeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    typeBtn.backgroundColor = [UIColor whiteColor];
    typeBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [self.contentView  addSubview:typeBtn];
    self.typeBtn = typeBtn;
    [self.typeBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)clickAction:(UIButton *)btn{
    if (self.clickAction) {
        self.clickAction(btn.selected);
    }
    if (!btn.selected) {
        btn.backgroundColor = [UIColor whiteColor];
    }else{
        btn.backgroundColor =[UIColor colorWithRed:(38)/255.0 green:(182)/255.0 blue:(274)/255.0 alpha:(1)] ;

    }
  
}

- (void)refreshUI:(TwoTypeRowModel *)mode{
    
    [self.typeBtn setTitle:mode.rowType forState:UIControlStateNormal];
    self.typeBtn.selected = mode.isSelected;
    if (!mode.isSelected) {
         self.typeBtn.backgroundColor = [UIColor whiteColor];
    }else{
         self.typeBtn.backgroundColor =[UIColor colorWithRed:(38)/255.0 green:(182)/255.0 blue:(274)/255.0 alpha:(1)] ;
    }
}

@end
