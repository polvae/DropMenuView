//
//  ViewController.m
//  DropMenuView
//
//  Created by KingSoft on 2017/5/8.
//  Copyright © 2017年 KingSoft. All rights reserved.
//

#import "ViewController.h"
#import "LSSelectMenuView.h"
#import "OneTypeContentView.h"
#import "TwoTypeContentView.h"
#import "OnetypeCellModel.h"

@interface ViewController ()<LSSelectMenuViewDelegate,LSSelectMenuViewDataSource>{
    LSSelectMenuView* menuView;
     NSArray* menuInfo;
}
@property (nonatomic, copy)NSString *addressName;

@property (nonatomic, copy)NSString *positionTypeName;
@property (nonatomic, strong)NSArray *selectedItemArr;//collectionView选择的item;
@property (nonatomic, strong)NSMutableArray *addressArr;
@property (nonatomic, strong) NSArray  *dataArr;

@end

@implementation ViewController

-(NSMutableArray *)addressArr{
    if (!_addressArr) {
        _addressArr = [NSMutableArray new];
        NSArray *addArr = @[@"长沙",@"长沙县",@"雨花区",@"开福区",@"芙蓉区",@"天心区"];
        for (int i = 0; i < addArr.count; i++) {
            OnetypeCellModel *model = [OnetypeCellModel new];
            model.mc = addArr[i];
            if (i == 0) {
                model.isSelected = YES;
            }
            [_addressArr addObject:model];
        }

    }
    return _addressArr;
}


-(NSArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSArray new];
        _dataArr = @[
                          @{@"sectionStr":@"发布时间",@"rowTypeArr":@[@{@"rowType":@"全部"},@{@"rowType":@"今天"},@{@"rowType":@"最近三天"},@{@"rowType":@"最近一周"},@{@"rowType":@"最近一个月"}]},
                          @{@"sectionStr":@"月薪",@"rowTypeArr":@[@{@"rowType":@"全部"},@{@"rowType":@"3k及以下"},@{@"rowType":@"3-5k"},@{@"rowType":@"5-8k"},@{@"rowType":@"8-10k"},@{@"rowType":@"10k以上"}]},
                          @{@"sectionStr":@"职业类型",@"rowTypeArr":@[@{@"rowType":@"全部"},@{@"rowType":@"全职"},@{@"rowType":@"兼职"},@{@"rowType":@"实习"}]},
                          ];
    }
    return _dataArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _positionTypeName = @"行业名称";
    _addressName = @"长沙";
    self.selectedItemArr = @[[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0]];

    menuInfo = @[self.positionTypeName,self.addressName,@"更多筛选"];
    
    menuView = [[LSSelectMenuView alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, 44)];
    menuView.backgroundColor =  [UIColor colorWithRed:0.973 green:0.973 blue:0.973 alpha:1];
    menuView.delegate = self;
    menuView.dataSource = self;
    [self.view addSubview:menuView];
    UIView* showView = [[UIView alloc] initWithFrame:CGRectMake(0, menuView.frame.origin.y+menuView.frame.size.height, self.view.bounds.size.width, self.view.bounds.size.height-64-44)];
    showView.backgroundColor = [UIColor colorWithRed:0.145 green:0.145 blue:0.145 alpha:0.65];
    [self.view addSubview:showView];
    
    menuView.showView = showView;
}

#pragma mark - LSSelectMenuViewDataSource

- (NSInteger)numberOfItemsInMenuView:(LSSelectMenuView *)menuview{
    return menuInfo.count;
}
- (NSString*)menuView:(LSSelectMenuView *)menuview titleForItemAtIndex:(NSInteger)index{
    return menuInfo[index];
}
- (CGFloat)menuView:(LSSelectMenuView *)menuview heightForCurrViewAtIndex:(NSInteger)index{
    if (index == 1 || index == 0) {
        return 250;
    }
    return 350;
}

- (UIView*)menuView:(LSSelectMenuView *)menuview currViewAtIndex:(NSInteger)index{
    __weak typeof(self)weakSelf = self;
    if (index == 2) {
        TwoTypeContentView* vv = [[TwoTypeContentView alloc] initWithFrame:CGRectZero];
        vv.selectedItem = [weakSelf.selectedItemArr mutableCopy];
        vv.dataArr = weakSelf.dataArr;
        vv.cllickAction = ^(NSDictionary *infoDic){
            [menuView closeCurrViewWithIndex:index];
            weakSelf.selectedItemArr = infoDic[@"selectedItem"];

            NSLog(@"%@",infoDic);
            
        };
        return vv;
    }else if(index == 1){
        OneTypeContentView* vv = [[OneTypeContentView alloc] initWithFrame:CGRectZero];
        vv.addressArr = weakSelf.addressArr;
        vv.clickAction = ^(NSDictionary *dic){
            
            [menuView closeCurrViewWithIndex:index];
            [menuview changeItemNameWithIndex:index andName:dic[@"mc"]];

            NSLog(@"%@",dic);

        };
        return vv;
    }else{
        NSLog(@"可跳转自定义控制器");
        return nil;
    }
}

#pragma mark - LSSelectMenuViewDelegate

- (void)selectMenuView:(LSSelectMenuView *)selectmenuview didSelectAtIndex:(NSInteger)index{
    NSLog(@"show row = %ld",index);
    
}

- (void)selectMenuView:(LSSelectMenuView *)selectmenuview didRemoveAtIndex:(NSInteger)index{
    NSLog(@"remove row = %ld",index);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
