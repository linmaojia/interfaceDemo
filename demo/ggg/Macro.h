

//客户端ID
//密钥
#define ClientId @"0c73bc72abb5bed090f4e7f5bd558bfe"
#define ClientSecret @"beef7f43766ea1161ccac32e50c4a433"
#define appendStr(str1,str2) [[NSString alloc] initWithFormat:@"%@%@",str1, str2]
#define getAuthTokenPath @"/v1/oauth2/token"
//本地环境
//#define LocalEnvironment
//测试环境
#define testingEnvironment
//正式环境
//#define OfficialEnvironment
/**
 *  APIURL 服务器地址
 */

#ifdef LocalEnvironment
#define APIURL              @"http://192.168.0.62:9000"
#endif

#ifdef testingEnvironment
#define APIURL              @"http://121.40.85.110:9100"
#endif

#ifdef OfficialEnvironment
#define APIURL              @"https://ezgapi.edsmall.cn"
#endif

#pragma mark - 个人信息

#pragma mark - 找回密码(重置密码)
//发送验证码到手机
#define APISendMobile                   [APIURL stringByAppendingString:@"/v1/send/"]
//更新密码
#define APIUpdatePassword               [APIURL stringByAppendingString:@"/v1/user/modify"]


//用户个人信息
#define APIUserInformation              [APIURL stringByAppendingString:@"/v1/user/info"]
//修改性别，简介
#define APIUserModifyinfo               [APIURL stringByAppendingString:@"/v1/user/modifyinfo"]
//上传用户头像
#define APIUploadUserImage              [APIURL stringByAppendingString:@"/v1/user/upload"]
//退出登录
#define APIOauthOut                    [APIURL stringByAppendingString:@"/v1/oauth2/out"]
//帮助中心
#define APIHelpCenter                    @"http://wiki.edsmall.cn/?cat=16"
//获取下载二维码
#define APIQrCode                      [APIURL stringByAppendingString:@"/v1/user/qrCode"] 



#pragma mark - 收藏
// 历史记录
#define APICollectHistoryList              [APIURL stringByAppendingString:@"/v1/record/list"]
// 删除所有历史记录
#define APIHistoryAllDelete                [APIURL stringByAppendingString:@"/v1/record/empty"]
// 获取收藏产品列表
#define APICollectProductList              [APIURL stringByAppendingString:@"/v1/favorite/goods/list"]
// 获取收藏品牌列表
#define APICollectShopList                [APIURL stringByAppendingString:@"/v1/favorite/shop/list"]
// 取消商品收藏
#define APICancelGoodCollect                [APIURL stringByAppendingString:@"/v1/favorite/goods/delete/"]
// 取消品牌收藏
#define APICancelShopCollect                [APIURL stringByAppendingString:@"/v1/favorite/shop/delete/"]


#pragma mark - 个人信息（收货地址）
//获取默认收货地址
#define APIGetDefultAddress             [APIURL stringByAppendingString:@"/v1/address/tacitly"]
//设置默认收货地址
#define APIDefultAddress                [APIURL stringByAppendingString:@"/v1/address/tacitly/"]
//删除收货地址
#define APIDeleteAddress                [APIURL stringByAppendingString:@"/v1/address/delete/"] 
//添加收货地址
#define APIAddAddress                   [APIURL stringByAppendingString:@"/v1/address/add"] 
//编辑收货地址
#define APIEditAddress                   [APIURL stringByAppendingString:@"/v1/address/modify"]


/*物流地址管理*/

//物流列表
#define APILogisticsList               [APIURL stringByAppendingString:@"/v1/logistics/list"]
//添加物流地址
#define APIAddLogistics                 [APIURL stringByAppendingString:@"/v1/logistics/add"]
//编辑物流地址
#define APIEditLogistics                   [APIURL stringByAppendingString:@"/v1/logistics/modify"]
//获取默认物流地址
#define APIGetDefultLogistics           [APIURL stringByAppendingString:@"/v1/logistics/tacitly"]
//设置默认物流地址
#define APIDefultLogistics                [APIURL stringByAppendingString:@"/v1/logistics/tacitly/"]
//删除物流地址
#define APIDeleteLogistics                [APIURL stringByAppendingString:@"/v1/logistics/delete/"]




//
//首页
#define APIHomeModel               [APIURL stringByAppendingString:@"/v1/skeleton"]

//排行版列表
#define APIClassifyList               [APIURL stringByAppendingString:@"/v1/classify"]
/*品牌大全路径*/
#define APIAllBrandsPath              [APIURL stringByAppendingString:@"/v2/brand/new"]

//收货地址列表
#define APIGetAddressList               [APIURL stringByAppendingString:@"/v1/address/list"]

#pragma mark - 订单
//获取支付URL
#define APIPay                          [APIURL stringByAppendingString:@"/v1/alipay/instantcredit/mobile?orderIds="]

//添加订单
#define APIOrderAdd                     [APIURL stringByAppendingString:@"/v1/order/add"]
//删除订单
#define APIOrderDelete                  [APIURL stringByAppendingString:@"/v1/order/delete?orderCode="]
//订单详情
#define APIOrderDetail                   [APIURL stringByAppendingString:@"/v1/orders/"]
//取消订单
#define APIOrderCancel                   [APIURL stringByAppendingString:@"/v1/order/cancel?orderCode="]
//订单再购买
#define APIOrderBuyAgain                [APIURL stringByAppendingString:@"/v1/cart/buyAgain?orderCode="]
//确认收货
#define APIOrderReceipt                 [APIURL stringByAppendingString:@"/v1/order/receipt?orderCode="]
//订单数量
#define APIOrderCount                   [APIURL stringByAppendingString:@"/v1/order/orderCount"]


#pragma mark - 购物车
//购物车列表
#define APIGetShoppingCarList           [APIURL stringByAppendingString:@"/v1/cart/info"]
//删除购物车某件商品
#define APIShoppingCarDelete            [APIURL stringByAppendingString:@"/v1/cart/delete/"]
//删除购物车数组商品
#define APIShoppingCarDeleteArray       [APIURL stringByAppendingString:@"/v1/cart/delete/gather"]
//购物车加入收藏
#define APIShoppingCarAddCollect        [APIURL stringByAppendingString:@"/v1/favorite/goods/cart"]
//爆款推荐
#define APIProductExplosion             [APIURL stringByAppendingString:@"/v1/blast"]

//修改购物车
#define APIShoppingCarCountChange       [APIURL stringByAppendingString:@"/v1/cart/add"]
//添加购物车
#define APIAddShopingCar                [APIURL stringByAppendingString:@"/v1/cart/add"]
//获取购物车商品数量
#define APIShoppingCarCount             [APIURL stringByAppendingString:@"/v1/cartQty"]

//修改购物车备注
#define APIShoppingCarRemark             [APIURL stringByAppendingString:@"/v1/cart/modfyProductDesc"]

//商品列表
#define APIProductListPath                [APIURL stringByAppendingString:@"/v1/product/list"]
//排行版列表
#define APIHotProductListPath                [APIURL stringByAppendingString:@"/v1/rank/product"]

#pragma mark - 退款
//申请退款
#define APIDrawbackInformation          [APIURL stringByAppendingString:@"/v1/refund/apply"]
//修改申请退款
#define APIModifyInformation            [APIURL stringByAppendingString:@"/v1/refund/modify"]
//撤销退款
#define APIDeleteInformation            [APIURL stringByAppendingString:@"/v1/refund/modify/"]
//客服接入
#define APIRefundCSImg                  [APIURL stringByAppendingString:@"/v1/refundCSImg"]

//客服接入v2
#define APIIntervention                  [APIURL stringByAppendingString:@"/v1/intervention"]


#pragma mark - 商品详情
/*商品详情路径*/
#define ProductDetailPath @"/v1/product/"
/*商品详情-添加收藏路径*/
#define addToCollectionPath @"/v1/favorite/goods/"
/*商品详情-取消收藏路径*/
#define deleteCollectionPath @"/v1/favorite/goods/delete/"
/*商品详情-添加购物车路径*/
#define addToShopCartPath @"/v1/cart/add"
/*商品详情-获取购物车物品数量*/
#define shopCartProductsCountPath @"/v1/cartQty"

#pragma mark - 首页
/*首页-请求主体信息路径*/
#define HomeSkeletonDataPath @"/v1/skeleton"
/*首页-请求商品推荐路径*/
#define HomeRecommendDataPath @"/v1/blast"
/*首页-请求弹窗路径*/
#define HomeAlertViewDataPath @"/v1/homeimg"

#pragma mark - 商品列表
/*商品列表-默认列表路径*/
#define ProductListPath @"/v1/product/list"
/*商品列表-按条件搜索列表路径*/
#define CondictionProductPath @"/v1/product"

#pragma mark - 品牌大全
/*品牌大全路径*/
#define allBrandsPath @"/v1/brand/new"

#pragma mark - 店铺
/*店铺-全部商品路径*/
#define shopAllGoodsPath @"/v1/brand/show/"
/*店铺-公司信息路径*/
#define companyInfoPath @"/v1/brand/"
/*店铺-客服列表路径*/
#define serviceListPath @"/v1/brand/customer/"

#pragma mark - 登录
/*请求口令路径*/
#define getAuthCodePath @"/v1/oauth2/auth"

#pragma mark - 验证码登录、修改密码
/*获取验证码路径*/
#define GetPassTextCode @"/v1/send/"
/*验证码登录路径*/
#define phoneVerifyPath @"/v1/oauth2/mobileAuth"
/*重置密码申请路径*/
#define verifyPhoneNumber @"/v1/user/retrieve"

#pragma mark - 重置密码
/*重置密码路径*/
#define resetPasswordPath @"/v1/user/resetting"

#pragma mark - EDS百科EDS百科
/*EDS百科路径*/
#define EDSMALLWIKI @"http://wiki.edsmall.cn/?cat=16"

#pragma mark - 分类
/*分类信息路径*/
#define categoryPath @"/v1/classify"

#pragma mark - 组合筛选
/*组合筛选-商品数量路径*/
#define productCountPath @"/v1/product/count"

#pragma mark - 排行榜
/*排行榜路径*/
#define HotListProductPath @"/v1/rank/product"

#pragma mark - 本周上新
/*本周上新路径*/
#define NewProductListPath @"/v1/product/new"

#pragma mark - 远程通知上传极光推送返回的注册ID
/*本周上新路径*/
#define RemoteNotificationRegistrationPath @"/v1/device/push"



