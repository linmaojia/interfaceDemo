

#import <UIKit/UIKit.h>
#import "YZGClassifylModel.h"

@interface YZGClassifyCollectionCell : UICollectionViewCell

@property (nonatomic, strong) NSIndexPath *indexPath;    /**< indexPath */

@property (nonatomic, strong) YZGClassifylDetailModel *model;    /**< 模型 */


@end
