//
//  YZGMineTableOrderCell.m
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGProductDetailImageCell.h"

@interface YZGProductDetailImageCell()

@property (nonatomic, strong) UIImageView *productImg;         /**<  品牌图片 */


@end
@implementation YZGProductDetailImageCell


#pragma mark ************** 懒加载控件

- (UIImageView *)productImg {
    if (!_productImg) {
        _productImg = [[UIImageView alloc] init];
        _productImg.image = [UIImage imageNamed:@"logo_del_pro"];
    }
    return _productImg;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
      

        [self addSubviewsForCell];
        [self addConstraintsForCell];
    }
    return self;
}
#pragma mark ************** 设置cell 内容
- (void)setModel:(YZGProductIntroduceModel *)model{
    _model = model;
    
    NSString *urlString = model.path;
    
    NSURL *imgUrl = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    
    __block CGFloat viewH = 0;
    [_productImg sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"logo_del_pro"] options:SDWebImageLowPriority | SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if (image)
        {
            //判断图片是否有值，避免出现除以零的情况导致崩溃
            viewH = SCREEN_WIDTH * image.size.height / image.size.width;
            
            model.cellHeight = viewH;
           
            if(self.cellHeightBlack)
            {
                self.cellHeightBlack(viewH);
            }

        }
        
    }];
    
    
    
}

#pragma mark ************** 添加子控件
- (void)addSubviewsForCell
{
    
    [self.contentView addSubview:self.productImg];


}
#pragma mark ************** 添加约束
- (void)addConstraintsForCell
{
    [_productImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
}

@end
