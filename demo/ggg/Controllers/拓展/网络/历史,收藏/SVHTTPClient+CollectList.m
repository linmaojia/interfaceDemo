//
//  SVHTTPClient+SameProducts.m
//  ETao
//
//  Created by LXY on 16/5/17.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "SVHTTPClient+CollectList.h"
#import "YZGMyCollecProductModel.h"
#import "YZGMyCollecShopModel.h"
#import "YZGMyCollectViewController.h"
@implementation SVHTTPClient (CollectList)

+ (void)getCollectProductArrayWithPageNum:(NSInteger)PageNum Type:(CollectListType)collectListType IsShowSV:(BOOL)isShowSV target:(id)target CallBack:(CollectProductArrayCallback)collectProductArrayCallback{
    
    //配置全局请求头
    [[SVHTTPClient sharedClient] setGlobalHeaderField];
    [[SVHTTPClient sharedClient] setSendParametersAsJSON:YES];
    
    //第一次请求 出现等待框
    if (PageNum == 1 && isShowSV) {
        [SVProgressHUD show];
    }
    
    NSString *url = nil;
    if(collectListType == collectProduct)
    {
        url = [APICollectProductList stringByAppendingString:@"?rowsPerPage=10&pageNumber="];
    }
    else if(collectListType == collectshop)
    {
        url = [APICollectShopList stringByAppendingString:@"?rowsPerPage=10&pageNumber="];
    }
    
    
    url = [url stringByAppendingString:[NSString stringWithFormat:@"%ld",(long)PageNum]];
    
    [[SVHTTPClient sharedClient] GET:url  parameters:nil completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        if (PageNum == 1 && isShowSV) {
            [SVProgressHUD dismiss];
        }
       
        
        
        if(PageNum == 1)
        {
            //移除空视图
            YZGMyCollectViewController *viewController = (YZGMyCollectViewController *)target;
            [viewController.view removeEmptyView];
            
            //判断错误类型
            EmptyViewTypes type = [self dealEmptyViewTypeWithData:response error:error];
            //step2成功处理
            if(type == EmptyViewTypesucceed)
            {
                if(collectListType == collectProduct)
                {
                    NSArray *productArray = [YZGMyCollecProductModel mj_objectArrayWithKeyValuesArray:(NSArray *)response];
                    collectProductArrayCallback(productArray);
                    
                }
                else if(collectListType == collectshop)
                {
                    NSArray *shopArray = [YZGMyCollecShopModel mj_objectArrayWithKeyValuesArray:(NSArray *)response];
                    collectProductArrayCallback(shopArray);
                    
                }
                
            }
            
            else if(type == EmptyViewTypeEmptyData && collectListType == collectProduct)
            {
                
               collectProductArrayCallback([NSArray new]);
            }
            else
            {
                //处理错误视图
                YZGMyCollectViewController *viewController = (YZGMyCollectViewController *)target;
                
                [viewController.view showEmptyViewWithtype:type IsOrder:NO refresh:^{
                    
                    [viewController.view removeEmptyView];
                    
                    if(type == EmptyViewTypeEmptyData)
                    {
                        //这里处理事件 一般为跳转控制器
                        //调用无参数无返回值方法
                        //((void (*)(id, SEL))objc_msgSend)(viewController, NSSelectorFromString(@"PushHomeViewController"));
                    }
                    else
                    {
                        //调用带一个参数但无返回值的方法(一般为页数)
                        //((void (*)(id, SEL, NSInteger))objc_msgSend)(viewController, NSSelectorFromString(@"getDataWithPageNum:"), 1);
                        
                    }
                    
                }];
                
            }
            
        }
        
        else
        {
            
            if(collectListType == collectProduct)
            {
                NSArray *productArray = [YZGMyCollecProductModel mj_objectArrayWithKeyValuesArray:(NSArray *)response];
                
                collectProductArrayCallback(productArray);
                
            }
            else if(collectListType == collectshop)
            {
                NSArray *shopArray = [YZGMyCollecShopModel mj_objectArrayWithKeyValuesArray:(NSArray *)response];
                collectProductArrayCallback(shopArray);
                
            }
            
            
        }
        
        
        
    }];
}


@end
