//
//  GetOrderList.m
//  ggg
//
//  Created by LXY on 16/9/24.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGOrderManager.h"
#import "YZGOrderModel.h"
#import "YZGOrderViewController.h"
#import "YZGErrorViews.h"
#import "YZGDataManage.h"
@interface YZGOrderManager ()
@property (nonatomic,assign) YZGOrderViewController *orderVC;
@end
@implementation YZGOrderManager
- (void)getOrderListWithPageNum:(NSInteger)PageNum orderStatus:(OrderStatus)orderStatus target:(id)target CallBack:(OrderListCallback)orderListCallback{
    ESWeakSelf;
    
    __weakSelf.orderVC = target;
    
    if (PageNum == 1)
    {
        [SVProgressHUD show];//第一次请求 出现等待框
    }
    
    //配置全局请求头
    [[SVHTTPClient sharedClient] setGlobalHeaderField];
    [[SVHTTPClient sharedClient] setSendParametersAsJSON:YES];
    
    NSString *url = nil;
    switch (orderStatus) {
        case OrderStatusAll:
        {
            url = [APIURL stringByAppendingString:@"/v1/order/99?rowsPerPage=10&pageNumber="];
            break;
        }
        case OrderStatusNonPayment:
        {
            url = [APIURL stringByAppendingString:@"/v1/order/0?rowsPerPage=10&pageNumber="];
            break;
        }
        case OrderStatusNonDelive:
        {
            url = [APIURL stringByAppendingString:@"/v1/order/1?rowsPerPage=10&pageNumber="];
            break;
        }
        case OrderStatusNonReceive:
        {
            url = [APIURL stringByAppendingString:@"/v1/order/3?rowsPerPage=10&pageNumber="];
            break;
        }
        case OrderStatusFinish:
        {
            url = [APIURL stringByAppendingString:@"/v1/order/4?rowsPerPage=10&pageNumber="];
            break;
        }
        case OrderStatusCancel:
        {
            url = [APIURL stringByAppendingString:@"/v1/order/5?rowsPerPage=10&pageNumber="];
            break;
        }
    }
    url = [url stringByAppendingString:[NSString stringWithFormat:@"%ld",(long)PageNum]];
    
    [[SVHTTPClient sharedClient] GET:url  parameters:nil completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        [SVProgressHUD dismiss];
        
        [__weakSelf removeErrorView];//移除错误视图
        
        if(PageNum == 1)
        {
           EmptyViewTypes type = [YZGDataManage dealEmptyViewTypeWithData:response error:error];
            
            if(type == EmptyViewTypesucceed )
            {
                NSArray *orderListArray = [YZGOrderModel mj_objectArrayWithKeyValuesArray:(NSArray *)response];
                
                orderListCallback(orderListArray);
            }
            else
            {
                orderListCallback([NSArray new]);
                [__weakSelf showErrorView:type];//显示错误视图
            }
        }
        else
        {
            
            NSArray *orderListArray = [YZGOrderModel mj_objectArrayWithKeyValuesArray:(NSArray *)response];
            
            orderListCallback(orderListArray);
        }
        
    }];
}
/*移除错误视图*/
- (void)removeErrorView
{
    for (UIView *view in self.orderVC.rootTableView.subviews)
    {
        if ([view isKindOfClass:[YZGErrorViews class]])
        {
            YZGErrorViews *noneView = (YZGErrorViews *)view;
            [noneView removeFromSuperview];
        }
    }
}

/*加载错误视图*/
- (void)showErrorView:(EmptyViewTypes)type
{
    ESWeakSelf;
    YZGErrorViews *errorView = [[YZGErrorViews alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    errorView.errorType = type;
    errorView.ErrorBtnClick = ^()
    {
        if(type == EmptyViewTypeEmptyData)
        {
            [__weakSelf.orderVC PushHomeViewController];//调转到首页
        }
        else
        {
            [__weakSelf.orderVC getDataWithPageNum:1];//重新请求数据
        }
    };
    [self.orderVC.rootTableView addSubview:errorView];
}
@end
