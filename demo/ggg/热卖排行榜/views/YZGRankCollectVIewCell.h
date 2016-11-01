

#import <UIKit/UIKit.h>



@interface YZGRankCollectVIewCell : UICollectionViewCell

//内部初始化方法
+ (YZGRankCollectVIewCell *)hotProductsCellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath;


@property(nonatomic, copy)void(^cellBrandNameClick)(NSIndexPath *index);   /**< cell选中按钮点击回调 */

@property (nonatomic, strong) UILabel *titleLab;  

@property (nonatomic, assign) BOOL isShowLine;


@end
