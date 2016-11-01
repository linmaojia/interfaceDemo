//
//  YZGUserSettingViewController.m
//  yzg
//
//  Created by LXY on 16/6/2.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGProductDetailViewVC.h"
#import "YZGProductManager.h"
#import "YZGProductDetailModel.h"
#import "YZGProductDetailTableView.h"
#import "PhotoBroswerVC.h"
#import "YZGProductDetailTableHeadView.h"
#import "YZGOrderButtonView.h"
@interface YZGProductDetailViewVC ()

@property (nonatomic, strong) UIImageView *leftImg;         /**<  产品图片 */
@property (nonatomic, strong) YZGProductManager *manager;  
@property (nonatomic, strong) YZGProductDetailModel *model;
@property (nonatomic, strong) YZGProductDetailTableView *tableView;
@property (nonatomic, strong) YZGProductDetailTableHeadView *headView;

@property (nonatomic, strong) YZGOrderButtonView *titleView;


@end

@implementation YZGProductDetailViewVC

#pragma mark ************** 懒加载控件

- (YZGOrderButtonView *)titleView {
    if (!_titleView) {
        ESWeakSelf;
        _titleView = [[YZGOrderButtonView alloc] initWithFrame:CGRectMake(0, 0, 54*3, 44)];
        _titleView.buttonArray = @[@"商品", @"详情", @"推荐"];
        _titleView.index = self.index;
        _titleView.orderButtonClick = ^(NSInteger index)
        {
            NSLog(@"xxx---%ld",index);
            [__weakSelf.tableView scrollToRowAtIndexPath:index];
        };
        
    }
    return _titleView;
}
- (YZGProductDetailTableHeadView *)headView {
    
    if (!_headView) {
        _headView = [[YZGProductDetailTableHeadView alloc] initWithFrame:CGRectMake(0, 0, 0, SCREEN_WIDTH + 80)];
        
    }
    return _headView;
}
- (YZGProductDetailTableView *)tableView
{
    if (!_tableView)
    {
        ESWeakSelf;
        _tableView = [[YZGProductDetailTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.tableHeaderView = self.headView;
        _tableView.procuctImgClickBlack = ^(NSIndexPath *indexPath){
            
            NSArray *urlArray = [__weakSelf.manager  getImageViewUrlArray];
            
            [__weakSelf imageViewTapWithNSIndexPath:indexPath ImageUrls:urlArray];
        };
        _tableView.sameCellClick = ^(NSString *productId){
             __weakSelf.productId = productId;
            [__weakSelf getData];
        };
        _tableView.titleIndexBlack = ^(NSInteger index){
            __weakSelf.titleView.index = index;
        };
    }
    return _tableView;
    
}
- (YZGProductManager *)manager {
    if (!_manager) {
        _manager = [[YZGProductManager alloc]init];
    }
    return _manager;
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self setNav];//设置导航栏
    
    [self getData];//获取数据
    
    [self addSubviewsForView];
    
    [self addConstraintsForView];
    

}
#pragma mark ************** 设置导航栏
- (void)setNav
{
    
    self.navigationItem.titleView =self.titleView;
    
    self.view.backgroundColor = RGB(235, 235, 241);
    UIButton  *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.frame = CGRectMake(0, 0, 40, 40);
    [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //将leftItem设置为自定义按钮
    leftBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0);
    UIBarButtonItem  *leftItem =[[UIBarButtonItem alloc]initWithCustomView: leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
}

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark ************** 获取数据
- (void)getData
{
   
    ESWeakSelf;
  [self.manager getProductDetailWithProductId:self.productId target:self CallBack:^(YZGProductDetailModel *model) {
      __weakSelf.model = model;
  }];
}


- (void)setModel:(YZGProductDetailModel *)model
{
    _model = model;
   
    [self.tableView setContentOffset:CGPointMake(0,0) animated:NO];
    
    self.tableView.model = model;
    
    self.headView.model = model;
    
    if(self.index == 2)
    {
        [self.tableView scrollToRowAtIndexPath:2];
    }
   
}
#pragma mark **************** 点击头部/底部产品图片时触发操作，弹窗图片浏览控制器
- (void)imageViewTapWithNSIndexPath:(NSIndexPath *)indexPath ImageUrls:(NSArray *)imageUrls
{
    
    ESWeakSelf
    [PhotoBroswerVC show:self type:PhotoBroswerVCTypeModal index:indexPath.row photoModelBlock:^NSArray *{
        
        NSArray *networkImages= imageUrls;
        
        NSMutableArray *modelsM = [NSMutableArray arrayWithCapacity:networkImages.count];
        for (NSUInteger i = 0; i< networkImages.count; i++)
        {
            PhotoModel *pbModel=[[PhotoModel alloc] init];
            pbModel.mid = i + 1;
            pbModel.image_HD_U = networkImages[i];
       
            UIImageView *imageV = [[UIImageView alloc] init];
            imageV.frame = __weakSelf.view.bounds;
            [imageV sd_setImageWithURL:[NSURL URLWithString:imageUrls[i]] placeholderImage:[UIImage imageNamed:@"logo_del_pro"] options:SDWebImageRetryFailed | SDWebImageLowPriority];
            pbModel.sourceImageView = imageV;
            [modelsM addObject:pbModel];
        }
        return modelsM;
    }];
    
}

#pragma mark ************** 添加子控件
- (void)addSubviewsForView
{
   [self.view addSubview:self.tableView];

}
#pragma mark ************** 添加约束
- (void)addConstraintsForView
{
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
@end
