//
//  TwoTypeContentView.m
//  TStyleMenuView
//
//  Created by KingSoft on 17/4/13.
//  Copyright © 2017年 Sen. All rights reserved.
//

#import "TwoTypeContentView.h"
#import "UIView+Extension.h"
#import "TwoTypeCollectionViewCell.h"
#import "TwoTypeSectionModel.h"
#import "TwoTypeRowModel.h"
#import "KGOSecTypeHeaderView.h"

//获取屏幕宽度的宏定义
#define KScreenWidth ([UIScreen mainScreen].bounds.size.width)
//获取屏幕高度的宏定义
#define KScreenHeight ([UIScreen mainScreen].bounds.size.height)

@interface TwoTypeContentView ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIButton *clearBtn;
@property (nonatomic, strong) UIButton *sureBtn;
@property (nonatomic, strong) UIView *line;

@property (nonatomic, assign)NSInteger oneSectionIndex;
@property (nonatomic, assign)NSInteger twoSectionIndex;
@property (nonatomic, assign)NSInteger threeSectionIndex;
@property (nonatomic, strong) NSMutableArray  *secDataArr;

@end

@implementation TwoTypeContentView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        self.userInteractionEnabled = YES;
        [self buildSubView];
    }
    
    return self;
}


-(NSMutableArray *)secDataArr{
    if (!_secDataArr) {
        _secDataArr = [NSMutableArray new];
        for (int i = 0; i <  _dataArr.count ; i++) {
            TwoTypeSectionModel *model = [TwoTypeSectionModel new];
            model.selectNum = [self.selectedItem[i] integerValue];
            [model setValuesForKeysWithDictionary:_dataArr[i]];
            [_secDataArr addObject:model];
            if (i == 0) {
                self.oneSectionIndex = [self.selectedItem[i] integerValue];
            }else if (i == 1){
                self.twoSectionIndex = [self.selectedItem[i] integerValue];
            }else{
                self.threeSectionIndex = [self.selectedItem[i] integerValue];
            }
        }
    }
    return _secDataArr;
}


- (void)buildSubView{
    self.backgroundColor =  [UIColor colorWithRed:(240)/255.0 green:(241)/255.0 blue:(245)/255.0 alpha:(1)];
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc]init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical]; //设置竖直滚动
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.minimumLineSpacing = 10;
    // flowLayout.sectionInset = UIEdgeInsetsMake(10, 0, 10, 0);
    
    self.collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.kwidth ,self.kheight) collectionViewLayout:flowLayout];
    self.collectionView.dataSource=self;
    self.collectionView.delegate=self;
    [self.collectionView setBackgroundColor: [UIColor colorWithRed:(240)/255.0 green:(241)/255.0 blue:(245)/255.0 alpha:(1)]];
    [self.collectionView registerClass:[TwoTypeCollectionViewCell class] forCellWithReuseIdentifier:@"TwoTypeCollectionViewCell"];
    [self.collectionView registerClass:[KGOSecTypeHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"KGOSecTypeHeaderView"];
    [self addSubview:self.collectionView];
    
    self.line = [[UIView alloc]init];
    [self addSubview:self.line];
    self.line.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4];
    
    for (int i = 0; i < 2; i++) {
        UIButton *selectedBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 90, 40)];
        [self addSubview:selectedBtn];
        selectedBtn.cornerRadius = selectedBtn.bounds.size.height/2;
        selectedBtn.clipsToBounds = YES;
        [selectedBtn addTarget:self action:@selector(selectClickAction:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            [selectedBtn setTitle:@"清空条件" forState:UIControlStateNormal];
            selectedBtn.backgroundColor =[UIColor colorWithRed:(240)/255.0 green:(241)/255.0 blue:(245)/255.0 alpha:(1)] ;
            
            [selectedBtn setTitleColor:[UIColor colorWithRed:(153)/255.0 green:(153)/255.0 blue:(153)/255.0 alpha:(1)] forState:UIControlStateNormal];
            selectedBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
            selectedBtn.layer.borderWidth = 1;
            self.clearBtn  = selectedBtn;
        }else{
            [selectedBtn setTitle:@"确定" forState:UIControlStateNormal];
            selectedBtn.backgroundColor =[UIColor colorWithRed:(38)/255.0 green:(182)/255.0 blue:(274)/255.0 alpha:(1)] ;
            [selectedBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.sureBtn = selectedBtn;
        }
    }
}
-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    self.collectionView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - 60);
    CGFloat btnW = 120;
    CGFloat padding = (self.size.width - btnW * 2)/3;
    self.clearBtn.frame = CGRectMake(padding, self.size.height - 10 - 40, btnW, 40);
    self.sureBtn.frame = CGRectMake(CGRectGetMaxX(self.clearBtn.frame) + padding, self.size.height - 10 - 40, btnW, 40);
    self.line.frame = CGRectMake(0, self.size.height-60, self.size.width, 0.5);
}

#pragma mark ----clickAction---
- (void)selectClickAction:(UIButton *)btn{
    //全部  3k及以下  3-5k   5-8k   8-10k   10k以上

    NSArray *wageArr = @[
                            @{@"Xzq":@"",@"Xzz":@""},
                            @{@"Xzq":@"0",@"Xzz":@"3000"},
                            @{@"Xzq":@"3000",@"Xzz":@"5000"},
                            @{@"Xzq":@"5000",@"Xzz":@"8000"},
                            @{@"Xzq":@"8000",@"Xzz":@"10000"},
                            @{@"Xzq":@"10000",@"Xzz":@"10000以上"},
                         ];
    
    //工作方式: 空:全部 1:全职 2:兼职 4:实习
    NSArray *workTypeArr = @[@"0",@"1",@"2",@"3"];
    //发布时限: 空:全部  2:今天  3:三天内  7:一周内  30: 一月内
    NSArray *postDateArr = @[@"0",@"1",@"2",@"3",@"4"];
    if (btn == self.sureBtn) {
        NSDictionary *infoDic = @{@"postDate":postDateArr[self.oneSectionIndex],@"wage":wageArr[self.twoSectionIndex],@"workType":workTypeArr[self.threeSectionIndex],@"selectedItem":@[[NSNumber numberWithInteger:self.oneSectionIndex],[NSNumber numberWithInteger:self.twoSectionIndex],[NSNumber numberWithInteger:self.threeSectionIndex]]};
        if (_cllickAction) {
            _cllickAction(infoDic);
        }
    }else{
        for (int i = 0; i < self.secDataArr.count; i++) {
            TwoTypeSectionModel *model = self.secDataArr[i];
            TwoTypeRowModel *rowModel = [TwoTypeRowModel new];
            TwoTypeRowModel *oldModel = [TwoTypeRowModel new];
            if (i == 0) {
               rowModel   = model.rowTypeArr[self.oneSectionIndex];
                self.oneSectionIndex = 0;
            }else if (i == 1){
                rowModel   = model.rowTypeArr[self.twoSectionIndex];
                self.twoSectionIndex = 0;
            }else{
                rowModel   = model.rowTypeArr[self.threeSectionIndex];
                self.threeSectionIndex = 0;
             }
             rowModel.isSelected = NO;
            oldModel = model.rowTypeArr[0];
            oldModel.isSelected = YES;
        }
        [self.collectionView reloadData ];
        NSDictionary *infoDic = @{@"postDate":postDateArr[0],@"wage":wageArr[0],@"workType":workTypeArr[0]};
        if (_cllickAction) {
            _cllickAction(infoDic);
        }
    }
}


#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    TwoTypeSectionModel *model = self.secDataArr[section];
    
    return model.rowTypeArr.count;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{

    return self.secDataArr.count;
    ;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TwoTypeCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TwoTypeCollectionViewCell" forIndexPath:indexPath];
    TwoTypeSectionModel *model = self.secDataArr[indexPath.section];
    TwoTypeRowModel *model1  = model.rowTypeArr[indexPath.row];
    [cell refreshUI:model1];
    __weak typeof(self)weakSelf = self;
    cell.clickAction = ^(BOOL isSelected){
        TwoTypeSectionModel *secModel = weakSelf.secDataArr[indexPath.section];
        for (TwoTypeRowModel *model in secModel.rowTypeArr) {
            model.isSelected = NO;
        }
        TwoTypeRowModel *rowModel  = model.rowTypeArr[indexPath.row];
        rowModel.isSelected = YES;
        [weakSelf.collectionView reloadData ];
        if (indexPath.section == 0) {
            weakSelf.oneSectionIndex = indexPath.row;
        }else if (indexPath.section == 1){
            weakSelf.twoSectionIndex = indexPath.row;
        }else{
            weakSelf.threeSectionIndex = indexPath.row;
        }
    };
    
    return cell;
}
//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return  CGSizeMake(80, 35);  //设置cell宽高
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5,10, 10, 10);
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    KGOSecTypeHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"KGOSecTypeHeaderView" forIndexPath:indexPath];
    TwoTypeSectionModel *model = self.secDataArr[indexPath.section];
    headerView.type = model.sectionStr;
    return headerView;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(KScreenWidth, 35);
}
@end
