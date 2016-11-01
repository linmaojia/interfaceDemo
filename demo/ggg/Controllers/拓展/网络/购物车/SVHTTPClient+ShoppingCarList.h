



#import "SVHTTPClient.h"

//购物车模型数组
typedef void (^ShoppingCarListCallback)(NSArray *shoppingCarListArray);

@interface SVHTTPClient (ShoppingCarList)


/* 获取购物车列表 */
+ (void)getShoppingCarListWithTarget:(id)target CallBack:(ShoppingCarListCallback)shoppingCarListCallback;

@end
