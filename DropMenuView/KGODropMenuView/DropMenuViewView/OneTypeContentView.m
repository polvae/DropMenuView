//
//  ContentView.m
//  TStyleMenuView
//
//  Created by KingSoft on 17/4/13.
//  Copyright © 2017年 Sen. All rights reserved.
//

#import "OneTypeContentView.h"
#import "OneTypeTableViewCell.h"

//获取屏幕宽度的宏定义
#define KScreenWidth ([UIScreen mainScreen].bounds.size.width)
//获取屏幕高度的宏定义
#define KScreenHeight ([UIScreen mainScreen].bounds.size.height)

@interface OneTypeContentView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataArr;

@end

@implementation OneTypeContentView

-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray new];
        _dataArr = [self.addressArr mutableCopy];
        [self.tableView reloadData];
    }
    return _dataArr;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        self.userInteractionEnabled = YES;
        [self buildSubView];
//        [self requestData];
    }
    return self;
}

- (void)buildSubView{
    self.backgroundColor =  [UIColor colorWithRed:(240)/255.0 green:(241)/255.0 blue:(245)/255.0 alpha:(1)];

    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,320 , 300 ) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 50;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[OneTypeTableViewCell class] forCellReuseIdentifier:@"OneTypeTableViewCell"];
    [self addSubview:self.tableView];
    self.tableView.backgroundColor =  [UIColor colorWithRed:(240)/255.0 green:(241)/255.0 blue:(245)/255.0 alpha:(1)];


}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    CGRect frame1 = self.tableView.frame;
    frame1.size.width = frame.size.width;
    frame1.size.height = frame.size.height;
    self.tableView.frame = frame;
}

//- (void)requestData{
//    self.dataArr = self.addressArr;
//    [self.tableView reloadData];
//}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return self.dataArr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OneTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OneTypeTableViewCell"];
    [cell refreshModel:self.dataArr[indexPath.row]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    for (OnetypeCellModel *model in self.dataArr) {
        model.isSelected = NO;
    }
    OnetypeCellModel *model = self.dataArr[indexPath.row];
    model.isSelected = YES;
    [self.tableView reloadData];
    if (self.clickAction) {
        NSDictionary *dic = @{@"mc":model.mc};
        self.clickAction(dic);
    }
}

@end
