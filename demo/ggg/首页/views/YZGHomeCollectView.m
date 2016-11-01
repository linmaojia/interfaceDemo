//
//  YZGMyCollectProduductFootView.m
//  ggg
//
//  Created by LXY on 16/9/6.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGHomeCollectView.h"
#import "YZGProductListCollectCell.h"
#import "YZGHomeADSectionHeadView.h"
#import "YZGHomeOneSectionCell.h"
#import "YZGHomeTwoSectionHeadView.h"
#import "YZGHomeHotStyleCell.h"
@interface YZGHomeCollectView ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) NSArray *hotStyleArray;  /**< 热门风格 */

@end

@implementation YZGHomeCollectView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    
    if (self = [super initWithFrame:frame collectionViewLayout:layout])
    {
        self.delegate = self;
        
        self.dataSource = self;
        
        self.backgroundColor = [UIColor colorWithHexColorString:@"f9f9f9"];
     
        
       [self registerCellAndReuseViewForCollectionview];
        
        
    }
    return self;
}
#pragma mark **************** 注册cell和reuseView
- (void)registerCellAndReuseViewForCollectionview
{
  /* */
    
  [self registerClass:[YZGHomeADSectionHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ADReusableView"];
  [self registerClass:[YZGHomeTwoSectionHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"TwoSectionHeadView"];
  [self registerClass:[YZGHomeOneSectionCell class] forCellWithReuseIdentifier:@"YZGHomeOneSectionCell"];
  [self registerClass:[YZGHomeHotStyleCell class] forCellWithReuseIdentifier:@"YZGHomeHotStyleCell"];

    

}
- (void)setModel:(YZGHomeModel *)model
{
    _model = model;
    
    self.hotStyleArray = _model.hotStyles;//热门风格
    
    [self reloadData];
}
- (void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    
 
    
    
    [self reloadData];
}

#pragma mark - CollectionView 代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if(section == 0)
    {
         return 1;
    }
    else
    {
       return  self.hotStyleArray.count;
    }
   
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section == 0)
    {
      YZGHomeOneSectionCell *cell = (YZGHomeOneSectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"YZGHomeOneSectionCell" forIndexPath:indexPath];
      cell.model =  _model.classifies;
        return cell;
    }
    else if(indexPath.section == 1)
    {
         YZGHomeHotStyleCell *cell = (YZGHomeHotStyleCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"YZGHomeHotStyleCell" forIndexPath:indexPath];
          cell.model = self.hotStyleArray[indexPath.row];
        
        return cell;
    }
    else
    {
        YZGHomeHotStyleCell *cell = (YZGHomeHotStyleCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"YZGHomeHotStyleCell" forIndexPath:indexPath];
        NSArray *styles = _model.hotStyles;
        cell.model = styles[indexPath.row];
        
        return cell;
    }
    
}
#pragma mark ************** headView
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    ESWeakSelf;
    UICollectionReusableView *reusableview = nil;//头部
    if (kind == UICollectionElementKindSectionHeader ){
        
        if(indexPath.section == 0)
        {
            YZGHomeADSectionHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ADReusableView" forIndexPath:indexPath];
            headerView.dataArray = _model.banners;
            reusableview = headerView;
        }
        else if(indexPath.section == 1)//热门风格
        {
            YZGHomeTwoSectionHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"TwoSectionHeadView" forIndexPath:indexPath];
            reusableview = headerView;
        }
        
        
    }
    
    return reusableview;
    
    
}
#pragma mark **************** 设置分区头高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        return CGSizeMake(self.frame.size.width,150);
    }
    else if(section == 1)
    {
        return CGSizeMake(self.frame.size.width,50);
    }
    else
    {
        return CGSizeMake(self.frame.size.width,50);
    }
 
    
}
#pragma mark **************** 设置cell 布局
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellWidth = 0;
    CGFloat cellHeight = 0;
    if(indexPath.section == 0)
    {
        cellWidth = SCREEN_WIDTH;
        cellHeight = 240;
    }
    else if(indexPath.section == 1)
    {
        cellWidth = SCREEN_WIDTH;
        cellHeight = 70;
    }
     return  CGSizeMake(cellWidth, cellHeight);
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    ProductDetail *productDetail = _dataArray[indexPath.item];
//    NSString *productId = productDetail.seqid;
//    
//    if(self.cellClick)
//    {
//       self.cellClick(productId);
//    }
    
}

@end
