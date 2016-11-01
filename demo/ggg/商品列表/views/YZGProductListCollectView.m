//
//  YZGMyCollectProduductFootView.m
//  ggg
//
//  Created by LXY on 16/9/6.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGProductListCollectView.h"
#import "YZGProductListCollectCell.h"
@interface YZGProductListCollectView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation YZGProductListCollectView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    
    if (self = [super initWithFrame:frame collectionViewLayout:layout])
    {
        self.delegate = self;
        
        self.dataSource = self;
        
       [self registerClass:[YZGProductListCollectCell class] forCellWithReuseIdentifier:NSStringFromClass([YZGProductListCollectCell class])];//注册cell
         [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([UICollectionReusableView class])];//注册头部
        self.backgroundColor = [UIColor colorWithHexColorString:@"f9f9f9"];
        
        
    }
    return self;
}

- (void)setHotArray:(NSArray *)hotArray{
    _hotArray = hotArray;
    
    [self reloadData];
}

#pragma mark - CollectionView 代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _hotArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YZGProductListCollectCell *cell = [YZGProductListCollectCell workNewsCellWithCollectionView:collectionView forIndexPath:indexPath];
    cell.indexPath = indexPath;
    cell.model = _hotArray[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProductDetail *productDetail = _hotArray[indexPath.item];
    NSString *productId = productDetail.seqid;
    
    if(self.cellClick)
    {
       self.cellClick(productId);
    }
    
}

@end
