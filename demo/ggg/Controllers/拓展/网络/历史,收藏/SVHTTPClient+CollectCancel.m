

#import "SVHTTPClient+CollectCancel.h"

@implementation SVHTTPClient (CollectCancel)

+ (void)collectCancelOrderType:(Type)type :(NSString *)favoriteId :(CollectCancelCallback)callback {
    [SVProgressHUD show];
    
    //配置全局请求头
    [[SVHTTPClient sharedClient] setGlobalHeaderField];
    
    [SVHTTPClient sharedClient].sendParametersAsJSON = YES;
    
    NSString *url = nil;
    if(type == productType)
    {
          url = [APICancelGoodCollect stringByAppendingString:favoriteId];
    }
    
    else if(type == shopType)
    {
          url = [APICancelShopCollect stringByAppendingString:favoriteId];
    
    }
    
    [[SVHTTPClient sharedClient] GET:url parameters:nil completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        if(error) {
            if ([response isKindOfClass:[NSDictionary class]]) {
                if ([[(NSDictionary *)response allKeys] containsObject:@"message"]) {
                    NSString *errorString = response[@"message"];
                    [SVProgressHUD showErrorWithStatus:errorString];
                }
            } else {
                [SVProgressHUD showErrorWithStatus:@"取消失败"];
            }
            callback(NO);
        }
        else {
          
            [SVProgressHUD  showSuccessWithStatus:@"取消成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                 callback(YES);
            });
          
        }
    }];
}

@end
