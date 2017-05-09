//
//  KGOInterestedCell.m
//  jucaiwang
//
//  Created by KingSoft on 17/3/29.
//  Copyright © 2017年 kingo. All rights reserved.
//

#import "OneTypeTableViewCell.h"
#import "UIView+Extension.h"

@interface OneTypeTableViewCell ()

//@property (nonatomic, strong)UIImageView *companyLogo;
@property (nonatomic, strong)UILabel *titleContent;
@property (nonatomic, strong) UIView *lineView ;
@property (nonatomic, strong) UIImageView *selectedImgView ;

@end

@implementation OneTypeTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self buildSubViews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0];
    }
    return self;
}

-(void)buildSubViews{
    _titleContent = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 320 -10 - 10 , 30)];
//    _titleContent.text = @"湖南歪歪软件有限责任有限公司";
    _titleContent.font = [UIFont systemFontOfSize:15.0];
    _titleContent.textColor = [UIColor colorWithRed:(153)/255.0 green:(153)/255.0 blue:(153)/255.0 alpha:(1)] ;
    [self.contentView addSubview:_titleContent];
    
    UIColor *lineColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = lineColor;
    [self.contentView addSubview:lineView];
    self.lineView = lineView;
    
    self.selectedImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ico_make"]];
    [self.contentView  addSubview:self.selectedImgView];
}

-(void)layoutSubviews{
    self.titleContent.frame = CGRectMake(10, 10, self.size.width - 20 - 16, 30);
    self.lineView.frame = CGRectMake(0, self.size.height - 0.5, self.size.width, 0.5);
    self.selectedImgView.frame = CGRectMake(self.size.width - 20 - 16, (self.size.height - 16)/2, 16, 12);
}

- (void)refreshModel:(OnetypeCellModel *)model{
    self.titleContent.text = model.mc;
    self.selectedImgView.hidden = !model.isSelected;
}

@end
