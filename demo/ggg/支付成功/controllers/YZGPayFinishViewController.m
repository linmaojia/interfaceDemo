//  Created by LXY on 16/6/2.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGPayFinishViewController.h"
#import "YZGReceivingFinishCell.h"
#import "YZGPayFinishHeadView.h"
//#import "YZGTabBarControllerConfig.h"
#import "YZGOrderViewController.h"
#import "MJShoppingCarVC.h"
//#import "YZGOrderViewController.h"
#import "SVHTTPClient+Explosion.h"
#import "YZGExplosionModel.h"
//#import "YZGProductDetailViewController.h"
//#import "YZGWeekklyNewProductViewController.h"
#import "MJRefresh.h"
@interface YZGPayFinishViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
{
    NSInteger _currentPage;     /**< 分页 */
}
@property (nonatomic, strong) UIImageView *yzgImg;    /**< YZG图标 */

@property (nonatomic, strong) NSMutableArray *dataArray;       /**< 数据源 */

@property (nonatomic, strong) UICollectionView *rootCollectionView;    /**< 本周上新 */


@end

@implementation YZGPayFinishViewController

#pragma mark - 懒加载控件
- (NSMutableArray *)dataArray {
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        
    }
    return _dataArray;
}
- (UICollectionView *)rootCollectionView {
    if (!_rootCollectionView) {
        ESWeakSelf;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //上 左 下 右 的距离(整个collection)不包括cell与cell 的距离
        layout.sectionInset = UIEdgeInsetsMake(0.0f, 10.0f, 10.0f, 10.0f);
        //列与列之间的间距
        layout.minimumInteritemSpacing = 10;
        //行与行之间的间距
        layout.minimumLineSpacing = 10;
        layout.itemSize = CGSizeMake((SCREEN_WIDTH-30)/2, 240);//cell的大小
        _rootCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _rootCollectionView.delegate = self;
        _rootCollectionView.dataSource = self;
        _rootCollectionView.backgroundColor = RGB(247, 247, 247);
        [_rootCollectionView registerClass:[YZGReceivingFinishCell class] forCellWithReuseIdentifier:NSStringFromClass([YZGReceivingFinishCell class])];//注册cell
        [_rootCollectionView registerClass:[YZGPayFinishHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([YZGPayFinishHeadView class])];//注册头部
        _rootCollectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            _currentPage ++;
            [__weakSelf loaddata];
        }];
        
        
    }
    return _rootCollectionView;
}


#pragma mark ************** 设置不能左滑返回
- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _currentPage = 1;
    
    [self setNav];//设置导航栏
    
    [self addConstraintsForFinishVC];//控件布局
    
    [self loaddata];//获取为你推荐列表
}

#pragma mark ************** 获取为你推荐列表
- (void)loaddata{
    ESWeakSelf;
    NSDictionary *params = @{@"rowsPerPage":@"10",@"pageNumber":@(_currentPage)};
   [SVHTTPClient getOrderListWithParams:params CallBack:^(NSArray *explosionArray) {
       
       [__weakSelf.dataArray addObjectsFromArray:explosionArray];
       
       [__weakSelf.rootCollectionView reloadData];
       
       [__weakSelf.rootCollectionView.mj_footer endRefreshing];
       
       if(explosionArray.count == 0)
       {
           [__weakSelf.rootCollectionView.mj_footer endRefreshingWithNoMoreData];//设置没有更多数据
       }
   }];

    
}
#pragma mark ************** 自定义方法
- (void)setNav{
    
    self.title = @"订单支付成功";
    self.view.backgroundColor = RGB(235, 235, 241);
    //返回按钮
    UIButton  *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.frame = CGRectMake(0, 0, 40, 40);
    [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //将leftItem设置为自定义按钮
    leftBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0);
    UIBarButtonItem  *leftItem =[[UIBarButtonItem alloc]initWithCustomView: leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
}
#pragma mark ************** 返回按钮点击
- (void)backAction {
    
    for (UIViewController *vc in self.navigationController.viewControllers) {
        //返回到购物车界面
        if ([vc isKindOfClass:[MJShoppingCarVC class]])
        {
            [self.navigationController popToViewController:vc animated:YES];
        }
        
        //返回到订单列表
        if ([vc isKindOfClass:[YZGOrderViewController class]])
        {
            [self.navigationController popToViewController:vc animated:YES];
        }
    }
}
#pragma mark ************** CollectionView 代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YZGReceivingFinishCell *cell = [YZGReceivingFinishCell workNewsCellWithCollectionView:collectionView forIndexPath:indexPath];
    cell.indexPath = indexPath;
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ProductDetail *productDetail = self.dataArray[indexPath.row];
    NSString *productId = productDetail.seqid;
    //跳转到商品详情
//    YZGProductDetailViewController *VC = [[YZGProductDetailViewController alloc]init];
//    VC.seqId = productId;
//    [self.navigationController pushViewController:VC animated:YES];
}

//headView
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    //头部
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader ){
        
        YZGPayFinishHeadView *finishHeadView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader  withReuseIdentifier:NSStringFromClass([YZGPayFinishHeadView class]) forIndexPath:indexPath];
        finishHeadView.price = self.price;
        
        finishHeadView.blackBtnBlack = ^(NSString *title){
            
            if([title isEqualToString:@"查看订单"])
            {
                //跳转到订单列表 支付成功列表,代发货状态
                YZGOrderViewController *cartVC = [[YZGOrderViewController alloc] initWithOrderType:WaitShipped];
                [self.navigationController pushViewController:cartVC animated:YES];
            }
            else if([title isEqualToString:@"回到首页"])
            {
                [self.navigationController.tabBarController setSelectedIndex:0];
                
                UIWindow *window = [UIApplication sharedApplication].keyWindow;
                //配置tabBarController
                [window setRootViewController:self.navigationController.tabBarController];
                
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        };
        
        //本周上新回调
        finishHeadView.newImgClickBlack = ^(){
//            NSLog(@"本周上新");
//            YZGWeekklyNewProductViewController *VC = [[YZGWeekklyNewProductViewController alloc]init];
//            VC.localImageName = @"banner";
//            [self.navigationController pushViewController:VC animated:YES];
        };
        
        reusableview = finishHeadView;
        
    }
    
    return reusableview;
}

#pragma mark ************** 定义headView的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(SCREEN_WIDTH,270);
}

#pragma mark ************** 添加约束
- (void)addConstraintsForFinishVC
{
    [self.view addSubview:self.rootCollectionView];
    
    
    [_rootCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);//等同于父视图
    }];
}

@end
