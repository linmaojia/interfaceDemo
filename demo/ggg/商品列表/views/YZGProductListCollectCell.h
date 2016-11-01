

#import <UIKit/UIKit.h>
#import "ProductDetail.h"

@interface YZGProductListCollectCell : UICollectionViewCell

//内部初始化方法
+ (YZGProductListCollectCell *)workNewsCellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath;


@property (nonatomic, strong) NSIndexPath *indexPath;    /**< indexPath */

@property (nonatomic, strong) ProductDetail *model;    /**< 模型 */


@end
