

#import <UIKit/UIKit.h>
#import "ProductDetail.h"

@interface YZGReceivingFinishCell : UICollectionViewCell

//内部初始化方法
+ (YZGReceivingFinishCell *)workNewsCellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath;


@property (nonatomic, strong) NSIndexPath *indexPath;    /**< indexPath */

@property (nonatomic, strong) ProductDetail *model;    /**< 模型 */


@end
