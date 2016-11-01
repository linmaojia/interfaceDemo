//
//  GetOrderList.m
//  ggg
//
//  Created by LXY on 16/9/24.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGProductManager.h"

@interface YZGProductManager ()
@property (nonatomic, strong) YZGProductDetailModel *model;
@end
@implementation YZGProductManager



- (NSArray *)getImageViewUrlArray
{
    NSMutableArray *imageUrls = [NSMutableArray array];
    
    NSArray *imgArray = _model.gintroduce;
    
    for(int i = 0; i<imgArray.count; i++)
    {
        YZGProductIntroduceModel *model = imgArray[i];
    
        [imageUrls addObject:[model.path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding ]];
    }
    return imageUrls;
}
+ (NSArray *)getOneSectionTitleArray:(YZGProductDetailModel *)model
{

    NSString *pruductIlluminantNum = [NSString stringWithFormat:@"   光源数量: %zd",model.illuminantNum.integerValue];
    NSString *pruductWidth = [NSString stringWithFormat:@"   宽度(W): %@ (mm)",model.specWidth];
    NSString *pruductHeight = [NSString stringWithFormat:@"   高度(H): %@ (mm)",model.specHeight];
    NSString *pruductLength = [NSString stringWithFormat:@"   深度(D): %@ (mm)",model.specLength];
    NSString *pruductApplicableRegion = [NSString stringWithFormat:@"   适用空间: %@",model.applicableRegion];
    NSString *pruductStyle = [NSString stringWithFormat:@"   风格: %@",model.styleLabel];
    NSString *pruductColor = [NSString stringWithFormat:@"   颜色: %@",model.bodyColorLabel];
    NSString *pruductMaterials = [NSString stringWithFormat:@"   材质: %@",model.madeLabel];
    NSArray *titleArray = @[pruductIlluminantNum,pruductWidth,pruductHeight,pruductLength,pruductApplicableRegion,pruductStyle,pruductColor,pruductMaterials];
    
    return titleArray;
}

/**< 获取商品详情Model */
- (void)getProductDetailWithProductId:(NSString *)productId target:(id)target CallBack:(ProductDetailCallback)productDetailCallback
{
    
    [SVProgressHUD show];
    //配置全局请求头
    [[SVHTTPClient sharedClient] setGlobalHeaderField];
    
    [SVHTTPClient sharedClient].sendParametersAsJSON = YES;
    
    ESWeakSelf;
    [[SVHTTPClient sharedClient] GET:[appendStr(APIURL, ProductDetailPath) stringByAppendingString:productId] parameters:nil completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        [SVProgressHUD dismiss];
        if (error)
        {
            
            if ([response isKindOfClass:[NSDictionary class]]) {
                if ([[(NSDictionary *)response allKeys] containsObject:@"message"]) {
                    NSString *errorString = response[@"message"];
                    [SVProgressHUD showErrorWithStatus:errorString];
                }
            } else {
                [SVProgressHUD showErrorWithStatus:@"请求失败"];
            }
        }
        else
        {
            __weakSelf.model = [YZGProductDetailModel mj_objectWithKeyValues:(NSDictionary *)response];
            
            productDetailCallback(__weakSelf.model);
        }
    }];

}

@end
