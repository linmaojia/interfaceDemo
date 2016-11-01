//
//  YZGMyCollectProduductFootView.m
//  ggg
//
//  Created by LXY on 16/9/6.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGAllBrandCollectView.h"
#import "YZGAllBrandCollectCell.h"
@interface YZGAllBrandCollectView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation YZGAllBrandCollectView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    
    if (self = [super initWithFrame:frame collectionViewLayout:layout])
    {
        self.delegate = self;
        
        self.dataSource = self;
        
       [self registerClass:[YZGAllBrandCollectCell class] forCellWithReuseIdentifier:@"AllBrandCollectCell"];//注册cell
      
        self.backgroundColor = [UIColor colorWithHexColorString:@"f9f9f9"];
        
        
    }
    return self;
}

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    
    [self reloadData];
}
#pragma mark - CollectionView 代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YZGAllBrandCollectCell *cell = (YZGAllBrandCollectCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"AllBrandCollectCell" forIndexPath:indexPath];
    cell.model = _dataArray[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
 
    
}

@end
