//
//  ViewController.m
//  ggg
//
//  Created by LXY on 16/8/3.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "ViewController.h"
#import "MJShoppingCarVC.h"
#import "RefundCloseVC.h"
#import "YZGMyCollectViewController.h"
#import "YZGRemarksView.h"
#import "YZGAddExpressController.h"
#import "YZGChooseExpressController.h"
#import "YZGEditExpressVC.h"
#import "YZGUserAddressAddVC.h"
#import "YZGremarkView.h"
#import "YZGPayFinishViewController.h"
#import "YZGReturnAlertView.h"
#import "YZGUserAddressSettingVC.h"
#import "YZGEditExpressVC.h"
#import "YZGOrderViewController.h"
#import "RefuldViewController.h"
#import "RefundCloseVC.h"
#import "RefundSuccessVC.h"
#import "KViewController.h"
#import "TextViewController.h"
#import "YZGProductDetailViewVC.h"
#import "YZGProductListlViewVC.h"
#import "YZGSearchController.h"
#import "YZGRankingListViewVC.h"
#import "YZGClassifyVC.h"
#import "YZGShopViewController.h"
#import "YZGAllBrandViewController.h"
#import "YZGHomeViewVC.h"
#import "YZGMyServiceController.h"
#import "YZGWeiBoController.h"
@interface ViewController ()
{
    NSMutableArray *buttonArray;    /**< 按钮数组 */
    NSMutableArray *buttonArray1;    /**< 按钮数组 */
}
@property (nonatomic, strong) UIView *bottomView;    /**< 底部视图 */
@property (nonatomic, strong) UIView *bottomView1;    /**< 底部视图 */

@end

@implementation ViewController


- (UIView *)bottomView{
    
    if(!_bottomView){
        
        buttonArray = [NSMutableArray new];//使用数组约束
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = [UIColor whiteColor];
        NSArray *array = [NSArray arrayWithObjects:@"购物车",@"订单列表",@"收货地址管理",@"收藏页面",@"物流地址管理",@"支付成功",@"退款详情",@"订单列表按钮",@"我的收藏" ,@"商品详情",nil];
        for(int i=0;i<array.count;i++){
            
            UIButton *button=[UIButton buttonWithType:UIButtonTypeSystem];
            
            button.backgroundColor = RGB(238, 91, 40);
            [button setTitleColor:[UIColor whiteColor] forState:0];
            [button setTitle:array[i] forState:UIControlStateNormal];
            button.titleLabel.font= boldSystemFont(15);
            button.tag=100+i;
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.bottomView addSubview:button];
            [buttonArray addObject:button];
            
        }
        
        
    }
    return _bottomView;
}
- (UIView *)bottomView1{
    
    if(!_bottomView1){
        
        buttonArray1 = [NSMutableArray new];//使用数组约束
        _bottomView1 = [[UIView alloc]init];
        _bottomView1.backgroundColor = [UIColor whiteColor];
        NSArray *array = [NSArray arrayWithObjects:@"商品详情",@"同类推荐",@"商品列表",@"搜索页面",@"排行榜",@"分类",@"首页",@"客服",@"微博图片" ,@"商品详情",nil];
        for(int i=0;i<array.count;i++){
            
            UIButton *button=[UIButton buttonWithType:UIButtonTypeSystem];
            
            button.backgroundColor = RGB(238, 91, 40);
            [button setTitleColor:[UIColor whiteColor] forState:0];
            [button setTitle:array[i] forState:UIControlStateNormal];
            button.titleLabel.font= boldSystemFont(15);
            button.tag=200+i;
            [button addTarget:self action:@selector(buttonAction1:) forControlEvents:UIControlEventTouchUpInside];
            [self.bottomView1 addSubview:button];
            [buttonArray1 addObject:button];
            
        }
        
        
    }
    return _bottomView1;
}
#pragma mark ************************* 监听button方法
-(void)buttonAction1:(UIButton *)sender{
    switch (sender.tag) {
        case 200:{
            YZGProductDetailViewVC *vc = [[YZGProductDetailViewVC alloc]init];
            vc.index = 0;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            break;
        case 201:{
            YZGProductDetailViewVC *vc = [[YZGProductDetailViewVC alloc]init];
            vc.index = 2;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 202:{
            YZGProductListlViewVC *vc = [[YZGProductListlViewVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 203:{
            YZGSearchController *vc = [[YZGSearchController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 204:{
            YZGRankingListViewVC *vc = [[YZGRankingListViewVC alloc]init];
            vc.hotArray = @[@"壁灯", @"吊灯",@"台灯",@"落地灯",@"吸顶灯",@"镜前灯",@"烛台灯",@"商业照明",@"开关插座",@"光源灯带",@"家居饰品",@"家具",@"其他"];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 205:{
            YZGClassifyVC *vc = [[YZGClassifyVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 206:{
            YZGHomeViewVC *vc = [[YZGHomeViewVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 207:{
            YZGMyServiceController *vc = [[YZGMyServiceController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 208:{
            YZGWeiBoController *vc = [[YZGWeiBoController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        
            
  
        default:
            break;
    }
    
    
    
}




#pragma mark ************************* 监听button方法
-(void)buttonAction:(UIButton *)sender{
    switch (sender.tag) {
        case 100:{
            MJShoppingCarVC *vc = [[MJShoppingCarVC alloc]init];
            vc.isShowBack = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            break;
        case 101:{
            YZGOrderViewController *cartVC = [[YZGOrderViewController alloc] initWithOrderType:AllOrder];
            [self.navigationController pushViewController:cartVC animated:YES];
        }
            break;
        case 102:{
            
            YZGUserAddressSettingVC *vc = [[YZGUserAddressSettingVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 103:{
            
            YZGMyCollectViewController *vc = [[YZGMyCollectViewController alloc]init];
            vc.collectType = product;
            [self.navigationController pushViewController:vc animated:YES];
        
            break;
            }
        case 104:{
            
            YZGEditExpressVC *vc = [[YZGEditExpressVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 105:{
            
            YZGPayFinishViewController *vc = [[YZGPayFinishViewController alloc]init];
            vc.price = 9.00;
            [self.navigationController pushViewController:vc animated:YES];
       
            break;
             }
        case 106:{
            
            RefuldViewController *vc = [[RefuldViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        
            break;
            }
        case 107:{
           
            KViewController *vc = [[KViewController alloc]init];
            vc.index = 3;
            [self.navigationController pushViewController:vc animated:YES];
            
            break;
        }
        case 109:{
            
          
            
            break;
        }
        default:
            break;
    }
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.bottomView];
    
    [_bottomView makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(@100);
        make.top.bottom.equalTo(self.view);
    }];
    
    //平均分配 水平
    
    [buttonArray mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:5 leadSpacing:5 tailSpacing:5];
    [buttonArray makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(@100);
        make.left.equalTo(self.bottomView);
    }];
    
    
    
    
    [self.view addSubview:self.bottomView1];
    
    [_bottomView1 makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(@100);
        make.left.equalTo(_bottomView.right).offset(20);
        make.top.bottom.equalTo(self.view);
    }];
    
    //平均分配 水平
    
    [buttonArray1 mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:5 leadSpacing:5 tailSpacing:5];
    [buttonArray1 makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(@100);
        make.left.equalTo(self.bottomView1);
    }];

}
#pragma mark **************** 进入购物车
- (void)sameBtnClick
{
    MJShoppingCarVC *cartVC = [[MJShoppingCarVC alloc] init];
    cartVC.isShowBack = YES;
    [self.navigationController pushViewController:cartVC animated:YES];
}

- (IBAction)xxx:(id)sender {
    
    [YZGRemarksView showRemarksViewWithTitle:@"" PlacehoderText:@"请输入山炮憋住" ConfirmBlock:^(NSString *text) {
        
    } CancelBlock:^{
        
    }];
    
    
    
    
    
    //    RefuldViewController *cartVC = [[RefuldViewController alloc] init];
    //
    //    [self.navigationController pushViewController:cartVC animated:YES];
    
    
    //    RefundCloseVC *cartVC = [[RefundCloseVC alloc] init];
    //
    //    [self.navigationController pushViewController:cartVC animated:YES];
    
    
    //    YZGMyCollectViewController *cartVC = [[YZGMyCollectViewController alloc] init];
    //    cartVC.collectType = product;
    //    [self.navigationController pushViewController:cartVC animated:YES];
    
//    YZGMyCollectViewController *cartVC = [[YZGMyCollectViewController alloc] init];
//    cartVC.collectType = shop;
//    [self.navigationController pushViewController:cartVC animated:YES];
    
//    YZGAddExpressController *cartVC = [[YZGAddExpressController alloc] init];
//    [self.navigationController pushViewController:cartVC animated:YES];
    
//    YZGChooseExpressController *cartVC = [[YZGChooseExpressController alloc] init];
//    [self.navigationController pushViewController:cartVC animated:YES];
    
//    YZGEditExpressVC *cartVC = [[YZGEditExpressVC alloc] init];
//    [self.navigationController pushViewController:cartVC animated:YES];
    
//    YZGUserAddressAddVC *cartVC = [[YZGUserAddressAddVC alloc] init];
//    [self.navigationController pushViewController:cartVC animated:YES];
    
}
- (IBAction)gg:(id)sender {
  
    YZGPayFinishViewController *cartVC = [[YZGPayFinishViewController alloc] init];
     [self.navigationController pushViewController:cartVC animated:YES];
    
}
- (IBAction)xggg:(id)sender {
    

    YZGReturnAlertView *alert = [[YZGReturnAlertView alloc]initWithTitle:@"便宜不等人，请三思而行~"];
    alert.alertNoBlock = ^(){};
    alert.alertYesBlock = ^(){
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
