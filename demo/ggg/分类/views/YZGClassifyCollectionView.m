//
//  YZGMyCollectProduductFootView.m
//  ggg
//
//  Created by LXY on 16/9/6.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGClassifyCollectionView.h"
#import "YZGClassifyCollectionCell.h"
#import "YZGClassifyCollectionSectionHeadView.h"
@interface YZGClassifyCollectionView ()<UICollectionViewDelegate, UICollectionViewDataSource>


@end

@implementation YZGClassifyCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    
    
    if (self = [super initWithFrame:frame collectionViewLayout:layout])
    {
        self.delegate = self;
        
        self.dataSource = self;
        [self registerClass:[YZGClassifyCollectionCell class] forCellWithReuseIdentifier:@"cellId"];
        [self registerClass:[YZGClassifyCollectionSectionHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
      
        self.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
        self.showsVerticalScrollIndicator = NO;
        //self.backgroundColor = RGB(235, 235, 241);
        self.backgroundColor = [UIColor whiteColor];
        
        
    }
    return self;
}
- (void)setModel:(YZGClassifylModel *)model
{
    _model = model;
    
    [self setContentOffset:CGPointMake(0,0) animated:NO];
    
    [self reloadData];

}


#pragma mark ************** CollectionView 代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _model.subset.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    YZGClassifylSubModel *subModel = _model.subset[section];
    
    return subModel.subset.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    YZGClassifyCollectionCell *cell = (YZGClassifyCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
     cell.indexPath = indexPath;
    YZGClassifylSubModel *subModel = _model.subset[indexPath.section];
    cell.model = subModel.subset[indexPath.item];
    return cell;

    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    YZGClassifylSubModel *subModel = _model.subset[indexPath.section];
    YZGClassifylDetailModel *detailModel = subModel.subset[indexPath.item];
    NSDictionary *params = detailModel.params;
    if(self.cellClick)
    {
       self.cellClick(params);
    }
    
}

#pragma mark ************** headView
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    ESWeakSelf;
    UICollectionReusableView *reusableview = nil;//头部
    if (kind == UICollectionElementKindSectionHeader ){
        
        YZGClassifyCollectionSectionHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
         YZGClassifylSubModel *subModel = _model.subset[indexPath.section];
        headerView.bannerUri = _model.bannerUri;
        headerView.indexPath = indexPath;
        headerView.model = subModel;
        
         headerView.BtnClick = ^(){
            __weakSelf.BtnClick(subModel.subset);//排行版
         };
        headerView.thisWeekNewProductOnLineAction = ^(){
            
            __weakSelf.thisWeekNewProductOnLineAction(_model.params);//点击本周上新回调
        };
        
         reusableview = headerView;
        
    }
    
    return reusableview;
    
    
}

#pragma mark ************** 定义headView的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        return CGSizeMake(self.frame.size.width,80);

    }
    else
    {
        return CGSizeMake(self.frame.size.width,30);

    }
}
#pragma mark ************** 个人背景被点击
-(void)titleImgClick:(UITapGestureRecognizer *)sender
{
}
@end
