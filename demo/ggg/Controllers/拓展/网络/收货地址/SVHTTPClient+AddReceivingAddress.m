

#import "SVHTTPClient+AddReceivingAddress.h"

@implementation SVHTTPClient (AddReceivingAddress)

+ (void)addReceivingAddressWithParameters:(NSDictionary *)parameters CallBack:(AddReceivingAddressCallback)addReceivingAddressCallback {
    [SVProgressHUD show];
    
    //配置请求头
    [[SVHTTPClient sharedClient] setGlobalHeaderField];
    
    [SVHTTPClient sharedClient].sendParametersAsJSON = YES;
    
    [[SVHTTPClient sharedClient] POST:APIAddAddress parameters:parameters completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        //NSLog(@"%@",parameters);
        
        if(error)
        {
            if ([response isKindOfClass:[NSDictionary class]]) {
                if ([[(NSDictionary *)response allKeys] containsObject:@"message"]) {
                    NSString *errorString = response[@"message"];
                   [SVProgressHUD showErrorWithStatus:errorString];
                }
            } else {
               [SVProgressHUD showErrorWithStatus:@"添加失败"];
            }
            addReceivingAddressCallback(NO);
        }
        else
        {
            [SVProgressHUD showSuccessWithStatus:@"添加成功"];
             addReceivingAddressCallback(YES);
        }
    }];
}


@end
