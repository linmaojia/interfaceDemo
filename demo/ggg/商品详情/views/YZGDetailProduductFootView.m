//
//  YZGMyCollectProduductFootView.m
//  ggg
//
//  Created by LXY on 16/9/6.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGDetailProduductFootView.h"
#import "YZGReceivingFinishCell.h"
@interface YZGDetailProduductFootView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation YZGDetailProduductFootView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    
    if (self = [super initWithFrame:frame collectionViewLayout:layout])
    {
        self.delegate = self;
        
        self.dataSource = self;
        
        self.scrollEnabled = NO;
        
       [self registerClass:[YZGReceivingFinishCell class] forCellWithReuseIdentifier:NSStringFromClass([YZGReceivingFinishCell class])];//注册cell
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
    
    YZGReceivingFinishCell *cell = [YZGReceivingFinishCell workNewsCellWithCollectionView:collectionView forIndexPath:indexPath];
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
////headView
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    
//    //头部
//    UICollectionReusableView *reusableview = nil;
//    if (kind == UICollectionElementKindSectionHeader ){
//        
//        UICollectionReusableView *finishHeadView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([UICollectionReusableView class]) forIndexPath:indexPath];
//        
//        UILabel *_handLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
//        _handLab.textColor = [UIColor grayColor];
//        _handLab.font = systemFont(14);
//        _handLab.textAlignment = NSTextAlignmentCenter;
//        _handLab.text = @"/为你推荐/";
//        
//        [finishHeadView addSubview:_handLab];
//        
//        reusableview = finishHeadView;
//        
//    }
//    
//    return reusableview;
//}
////定义headView的尺寸
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
//    return CGSizeMake(SCREEN_WIDTH,40);
//}
@end
