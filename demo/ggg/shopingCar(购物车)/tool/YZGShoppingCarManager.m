//
//  YZGShoppingCarManager.m
//  ggg
//
//  Created by LXY on 16/9/29.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGShoppingCarManager.h"

@implementation YZGShoppingCarManager
/**< 获取选中购物车id数组 */
- (NSMutableArray *)getCarIDArray
{
    NSMutableArray *cartIdArray = [NSMutableArray array];
    for(MJShoppingCarModel *brandModel in self.dataArray)
    {
        for(Products *product in brandModel.products)
        {
            if(product.select)
            {
                [cartIdArray addObject:product.cartId];
            }
        }
    }
    return cartIdArray;
}

/**< 获取选中购物车产品id数组 */
- (NSMutableArray *)getProductIDArray
{
    NSMutableArray *productArray = [NSMutableArray array];
    for(MJShoppingCarModel *brandModel in self.dataArray)
    {
        for(Products *product in brandModel.products)
        {
            if(product.select)
            {
                [productArray addObject:product.productID];
            }
        }
    }
       return productArray;
}

/**< 判断是否库存不足 */
- (BOOL)isStocksInsufficient
{
    BOOL isStock = YES;
    //判断选中的数组中是否存在库存不足的商品
    for(int i = 0;i<self.dataArray.count;i++)
    {
        MJShoppingCarModel * bandModel = self.dataArray[i];
        for(int j = 0;j<bandModel.products.count;j++)
        {
            Products *productModel = bandModel.products[j];
            if(productModel.select)
            {
                ProductDetail *productDetail = productModel.productDetail;
                if(productModel.productQty > productDetail.stock)
                {
                    isStock = NO;
                }
            }
            
        }
        
    }
    return isStock;
}
 /**< 清除没有选中的数据 */
- (NSMutableArray *)updateDataArray
{
    NSMutableArray *selectArray = [NSMutableArray new];
    selectArray = [NSMutableArray arrayWithArray:self.dataArray];
    for(int i = 0;i<selectArray.count;i++)
    {
        MJShoppingCarModel * bandModel = selectArray[i];
        for(int j = 0;j<bandModel.products.count;j++)
        {
            Products *productModel = bandModel.products[j];
            if(!productModel.select)
            {
                [bandModel.products removeObject:productModel];
                j--;
                
            }
            
        }
        
    }
    
    for(int i = 0;i<selectArray.count;i++)
    {
        MJShoppingCarModel * bandModel = selectArray[i];
        if(!bandModel.select)
        {
            
            if(bandModel.products.count == 0)
            {
                [selectArray removeObject:bandModel];
                i--;
            }
            
        }
    }
    
    return selectArray;
}



@end
