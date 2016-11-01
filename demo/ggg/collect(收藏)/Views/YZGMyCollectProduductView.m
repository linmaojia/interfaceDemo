//
//  YZGShopProduductTableView.m
//  YZGShopInformation
//
//  Created by 李超 on 16/6/9.
//  Copyright © 2016年 lichao. All rights reserved.
//

#import "YZGMyCollectProduductView.h"
#import "YZGMyCollectProductCell.h"
#import "YZGMyCollectProduductFootView.h"
#import "SVHTTPClient+CollectCancel.h"
@interface YZGMyCollectProduductView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) YZGMyCollectProduductFootView *footView; /**< TableView尾部信息 */
@property (nonatomic, strong) UIView *noneView;            /**<  空视图 */
@end
@implementation YZGMyCollectProduductView
- (UIView *)noneView {
    if (!_noneView) {
        _noneView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
        _noneView.backgroundColor = [UIColor colorWithHexColorString:@"f9f9f9"];
        
    }
    return _noneView;
}
- (YZGMyCollectProduductFootView *)footView {
    
    if (!_footView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //上 左 下 右 的距离(整个collection)不包括cell与cell 的距离
        layout.sectionInset = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
        //列与列之间的间距
        layout.minimumInteritemSpacing = 10;
        //行与行之间的间距
        layout.minimumLineSpacing = 10;
        layout.itemSize = CGSizeMake((SCREEN_WIDTH-30)/2, 260);//cell的大小
        ESWeakSelf;
        _footView = [[YZGMyCollectProduductFootView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300) collectionViewLayout:layout];
        _footView.cellClick = ^(NSString *productId){
            __weakSelf.hotCellClick(productId);
           
        };
    }
    return _footView;
}
#pragma ******************* init
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style])
    {
        self.delegate = self;
        self.dataSource = self;
        
        [self registerClass:[YZGMyCollectProductCell class] forCellReuseIdentifier:@"productCell"];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor colorWithHexColorString:@"f9f9f9"];
        
       

    }
    return self;
}
- (void)setProducts:(NSMutableArray *)products
{
    _products = products;
    
    //判断是否显示表头
    if(products.count == 0)
    {
        [self showNoneData];//显示表头
    }
    else
    {
        self.tableHeaderView = nil;
    }
    
    
    [self reloadData];
}
- (void)setHotArray:(NSArray *)hotArray{
 
     _hotArray = hotArray;
    
    CGFloat height = [self caculateRecomendProductFooterHeight:hotArray];
    self.footView.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
    self.tableFooterView = self.footView;
   
    self.footView.hotArray = hotArray;
    [self reloadData];
    
}
#pragma mark **************** 计算为你推荐的高度
- (CGFloat)caculateRecomendProductFooterHeight:(NSArray *)recmendArr
{
    NSInteger row = recmendArr.count / 2;
    row += recmendArr.count % 2;
    CGFloat height = row * 260 + (row + 1)*10;
    if (recmendArr.count == 0)
    {
        height = 0;
    }
    return height;
}
- (void)showNoneData
{
   self.tableHeaderView = self.noneView;
    
    
    UILabel *_titleLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 100, 10, 200, 30)];
    _titleLab.textAlignment = NSTextAlignmentCenter;
    _titleLab.font = systemFont(14);
    _titleLab.text = @"没有关注任何商品,赶紧添加吧";
    _titleLab.textColor = [UIColor grayColor];

    [self.noneView addSubview:_titleLab];
    
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 60, 50, 120, 30)];
    [btn setTitle:@"点击添加" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = mainColor;
    btn.titleLabel.font = systemFont(14);
    btn.layer.cornerRadius = 3;
    btn.layer.masksToBounds = YES;
    [btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchDown];
    
    [self.noneView addSubview:btn];
    
}
#pragma mark ************** 按钮被点击
- (void)BtnClick:(UIButton *)sender{
    if(self.puchHomeVCBlack)
    {
      self.puchHomeVCBlack();
    }
}
#pragma ******************* UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.products.count;
  
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ESWeakSelf;
    YZGMyCollectProductCell *cell = [tableView dequeueReusableCellWithIdentifier:@"productCell" forIndexPath:indexPath];
    cell.model = self.products[indexPath.row];
    cell.sameBtnClickBlack = ^(NSString *productId){
          if(__weakSelf.sameBtnClickBlack)
          {
              __weakSelf.sameBtnClickBlack(productId);
          }
    };
    cell.carBtnClickBlack = ^(NSString *productId,UIImageView *imageView){
        if(__weakSelf.carBtnClickBlack)
        {
            __weakSelf.carBtnClickBlack(productId,imageView);
        }
    };
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}
//-----------------------   添加删除效果
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
     ESWeakSelf;
     //删除按钮
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"取消\n关注" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath){
        
         YZGMyCollecProductModel *model = __weakSelf.products[indexPath.row];
         NSString *favoriteId = model.favoriteId;
        
        NSIndexPath *indexPath_1=[NSIndexPath indexPathForRow:indexPath.row inSection:0];
        NSArray *indexArray=[NSArray arrayWithObject:indexPath_1];
        [tableView reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationNone];
        
        [SVHTTPClient collectCancelOrderType:productType :favoriteId :^(BOOL state) {
            
            if(state)
            {
                if(__weakSelf.reloadDataClick)
                {
                     __weakSelf.reloadDataClick(NO);//刷新数据
                }
               
            }
            
        }];
        
    }];
    //返回按钮数组
    return @[deleteRowAction];
}


#pragma ******************* UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YZGMyCollecProductModel *model = self.products[indexPath.row];
    ProductDetail *productDetail = model.productDetail;
    NSString *productId = productDetail.seqid;
    
    if(self.cellClickBlack)
    {
       self.cellClickBlack(productId);
    }
}
@end
