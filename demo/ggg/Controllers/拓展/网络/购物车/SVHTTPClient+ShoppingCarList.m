

#import "SVHTTPClient+ShoppingCarList.h"
#import "MJShoppingCarModel.h"
#import "MJShoppingCarVC.h"
//购物车列表
@implementation SVHTTPClient (ShoppingCarList)

+ (void)getShoppingCarListWithTarget:(id)target CallBack:(ShoppingCarListCallback)shoppingCarListCallback {
    
    [SVProgressHUD showWithStatus:@"正在刷新购物车,请稍等"];
    
    //配置全局请求头
    [[SVHTTPClient sharedClient] setGlobalHeaderField];
    
    [SVHTTPClient sharedClient].sendParametersAsJSON = YES;
    
    [[SVHTTPClient sharedClient] GET:APIGetShoppingCarList parameters:nil completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        [SVProgressHUD dismiss];
        
        //移除空视图
        MJShoppingCarVC *viewController = (MJShoppingCarVC *)target;
        [viewController.view removeEmptyView];
        
        //step1
        //判断错误类型
        EmptyViewTypes type = [self dealEmptyViewTypeWithData:response error:error];
        
        //step2成功处理
        if(type == EmptyViewTypesucceed)
        {
            NSArray *shoppingCarListArray = [MJShoppingCarModel mj_objectArrayWithKeyValuesArray:response];
            shoppingCarListCallback(shoppingCarListArray);
        }
        //step3失败处理
        else
        {
            
            if(type == EmptyViewTypeEmptyData)
            {
                shoppingCarListCallback((NSArray *)response);
            }
            
            //处理错误视图
            MJShoppingCarVC *viewController = (MJShoppingCarVC *)target;
            
            [viewController.view showEmptyViewWithtype:type IsOrder:NO refresh:^{
                
                [viewController.view removeEmptyView];
                
                if(type == EmptyViewTypeEmptyData)
                {
                    //这里处理事件 一般为跳转控制器
                    //调用无参数无返回值方法
   
                    ((void (*)(id, SEL))objc_msgSend)(viewController, NSSelectorFromString(@"PushHomeViewController"));
    
                }
                else
                {
                    //调用无参数无返回值方法
                    //((void (*)(id, SEL))objc_msgSend)(viewController, NSSelectorFromString(@"requestData"));
                }

            }];
            
        }
        
        
    }];
}

@end
