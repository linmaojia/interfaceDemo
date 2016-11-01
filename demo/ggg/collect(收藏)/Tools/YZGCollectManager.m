//
//  YZGCollectManager.m
//  ggg
//
//  Created by LXY on 16/9/27.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGCollectManager.h"
#import "YZGMyCollectViewController.h"
#import "YZGMyCollecProductModel.h"
#import "YZGMyCollecShopModel.h"

@interface YZGCollectManager ()
@property (nonatomic,assign) YZGMyCollectViewController *collectVC;
@end
@implementation YZGCollectManager
/* 获取收藏商品*/
- (void)getCollectProductArrayWithPageNum:(NSInteger)PageNum target:(id)target CallBack:(CollectProductArrayCallback)collectProductArrayCallback
{
    ESWeakSelf;
     __weakSelf.collectVC = target;

    [[SVHTTPClient sharedClient] setGlobalHeaderField];
    [[SVHTTPClient sharedClient] setSendParametersAsJSON:YES];
    
    if (PageNum == 1)
    {
        [SVProgressHUD show];//第一次请求 出现等待框
    }
    
    NSString * url = [APICollectProductList stringByAppendingString:@"?rowsPerPage=10&pageNumber="];

    url = [url stringByAppendingString:[NSString stringWithFormat:@"%ld",(long)PageNum]];
    
    [[SVHTTPClient sharedClient] GET:url  parameters:nil completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
    
         [SVProgressHUD dismiss];
        
         [__weakSelf removeProductErrorView];//移除错误视图
        
        if(PageNum == 1)
        {
           EmptyViewTypes type = [YZGDataManage dealEmptyViewTypeWithData:response error:error];
            if(type == EmptyViewTypesucceed )
            {
                NSArray *productArray = [YZGMyCollecProductModel mj_objectArrayWithKeyValuesArray:(NSArray *)response];
                collectProductArrayCallback(productArray);
            }

            else
            {
                collectProductArrayCallback([NSArray new]);
                [__weakSelf showProductErrorView:type];//显示错误视图
            }
            
        }
        else
        {
            NSArray *productArray = [YZGMyCollecProductModel mj_objectArrayWithKeyValuesArray:(NSArray *)response];
            
            collectProductArrayCallback(productArray);
        }

    }];

}


/* 获取品牌商品*/
- (void)getCollectShopArrayWithPageNum:(NSInteger)PageNum target:(id)target CallBack:(CollectShopArrayCallback)collectShopArrayCallback
{

    ESWeakSelf;
    __weakSelf.collectVC = target;
    //配置全局请求头
    [[SVHTTPClient sharedClient] setGlobalHeaderField];
    [[SVHTTPClient sharedClient] setSendParametersAsJSON:YES];
    
    if (PageNum == 1)
    {
        [SVProgressHUD show];//第一次请求 出现等待框
    }
    NSString * url = [APICollectShopList stringByAppendingString:@"?rowsPerPage=10&pageNumber="];
    
    url = [url stringByAppendingString:[NSString stringWithFormat:@"%ld",(long)PageNum]];
    
    [[SVHTTPClient sharedClient] GET:url  parameters:nil completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        [SVProgressHUD dismiss];
        
        [__weakSelf removeShopErrorView];//移除错误视图
        
        if(PageNum == 1)
        {
            EmptyViewTypes type = [YZGDataManage dealEmptyViewTypeWithData:response error:error];
            if(type == EmptyViewTypesucceed )
            {
                NSArray *array = [YZGMyCollecShopModel mj_objectArrayWithKeyValuesArray:(NSArray *)response];
                collectShopArrayCallback(array);
            }
            else
            {
                collectShopArrayCallback([NSArray new]);
                [__weakSelf showShopErrorView:type];//显示错误视图
            }
            
        }
        else
        {
            NSArray *array = [YZGMyCollecShopModel mj_objectArrayWithKeyValuesArray:(NSArray *)response];
            
            collectShopArrayCallback(array);
        }
        
    }];
}


/*移除品牌错误视图*/
- (void)removeShopErrorView
{
    
    for (UIView *view in self.collectVC.shopTableView.subviews)
    {
        if ([view isKindOfClass:[YZGErrorViews class]])
        {
            YZGErrorViews *noneView = (YZGErrorViews *)view;
            [noneView removeFromSuperview];
        }
    }
}

/*加载错品牌误视图*/
- (void)showShopErrorView:(EmptyViewTypes)type
{
    ESWeakSelf;
    YZGErrorViews *errorView = [[YZGErrorViews alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    errorView.errorType = type;
    errorView.ErrorBtnClick = ^()
    {
        if(type == EmptyViewTypeEmptyData)
        {
            [__weakSelf.collectVC PushHomeViewController];//调转到品牌大全
        }
        else
        {
            [__weakSelf.collectVC getShopDataWithPageNum:1];//重新请求数据
        }
    };
    [self.collectVC.shopTableView addSubview:errorView];
    
}




/*移除商品错误视图*/
- (void)removeProductErrorView
{
    
    for (UIView *view in self.collectVC.productTableView.subviews)
    {
        if ([view isKindOfClass:[YZGErrorViews class]])
        {
            YZGErrorViews *noneView = (YZGErrorViews *)view;
            [noneView removeFromSuperview];
        }
    }
}

/*加载错商品误视图*/
- (void)showProductErrorView:(EmptyViewTypes)type
{
    if(type != EmptyViewTypeEmptyData)
    {
        ESWeakSelf;
        YZGErrorViews *errorView = [[YZGErrorViews alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        errorView.errorType = type;
        errorView.ErrorBtnClick = ^()
        {
           [__weakSelf.collectVC getDataWithPageNum:1];//重新请求数据
        };
        [self.collectVC.productTableView addSubview:errorView];
    }

}

- (void)animationAction:(UIImageView *)moveImg selfView:(UIView *)view CarView:(YZGShoppingCarView *)carView CarCount:(int)carCount{
    
    
    CGRect frames = [moveImg convertRect:moveImg.bounds toView:view];
    
    UIImageView *temImageView = [[UIImageView alloc]initWithFrame:frames];
    
    NSLog(@"%@", NSStringFromCGRect(frames));
    NSLog(@"%@", NSStringFromCGPoint(temImageView.center));
    UIImageView * imageView;
    if(![view.subviews containsObject:imageView])
    {
        imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 5, 5)];
        imageView.image = moveImg.image;
        [imageView setContentMode:UIViewContentModeScaleAspectFill];
        imageView.clipsToBounds=YES;
        imageView.center = temImageView.center;
        imageView.layer.borderWidth = 0.05;
        imageView.layer.borderColor = [UIColor blackColor].CGColor;
        imageView.layer.cornerRadius = imageView.frame.size.width/2;
        imageView.layer.masksToBounds = YES;
        [view addSubview:imageView];
        
        [UIView animateWithDuration:0.2f animations:^{
            imageView.center = CGPointMake(temImageView.frame.origin.x + temImageView.frame.size.width, temImageView.frame.origin.y);
            imageView.transform = CGAffineTransformMakeScale(10, 10);
            
            
        } completion:^(BOOL finished) {
            if (finished) {
                
                NSLog(@"%@",NSStringFromCGRect(imageView.frame));
                CABasicAnimation *bigAnimation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
                bigAnimation.duration=0.1f;
                bigAnimation.fromValue = @10.0;//原始比例
                bigAnimation.toValue=[NSNumber numberWithFloat:11.0f];//放大比例
                bigAnimation.autoreverses=YES;//动画 完成后自动回放
                bigAnimation.repeatCount = 2;//次数
                [imageView.layer addAnimation:bigAnimation forKey:@"ani_scale"];
                
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    // 路径曲线
                    CGPoint fromPoint = imageView.center;
                    UIBezierPath *movePath = [UIBezierPath bezierPath];
                    [movePath moveToPoint:fromPoint];
                    [movePath addQuadCurveToPoint:carView.center controlPoint:CGPointMake(imageView.center.x + 50, imageView.center.y - 80)];
                    
                    // 关键帧
                    CAKeyframeAnimation *moveAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
                    moveAnim.path = movePath.CGPath;
                    moveAnim.removedOnCompletion = NO;
                    /* 设为no 物体最终停留在终点
                     设为yes,物体在最终点消失，重新回到起始点
                     */
                    moveAnim.fillMode = kCAFillModeForwards;
                    moveAnim.duration = 0.5;
                    [imageView.layer addAnimation:moveAnim forKey:nil];
                    
                    [UIView animateWithDuration:0.5 animations:^{
                        
                        imageView.transform = CGAffineTransformMakeScale(3, 3);
                        
                    } completion:^(BOOL finished) {
                        
                        [imageView removeFromSuperview];
                        
                        carView.count =  carCount;
                        
                        CABasicAnimation *bigAnimation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
                        bigAnimation.duration=0.1f;
                        bigAnimation.fromValue = @1.0;//原始比例
                        bigAnimation.toValue=[NSNumber numberWithFloat:01.10f];//放大比例
                        bigAnimation.autoreverses=YES;//动画 完成后自动回放
                        bigAnimation.repeatCount = 2;//次数
                        [carView.layer addAnimation:bigAnimation forKey:@"ani_scale"];
                        
                    }];
                    
                });
            }
        }];
        
    }


}

@end
