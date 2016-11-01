//
//  YZGMineTableHeadView.m
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGDetailsOrderSctionFootView.h"
#import "YZGOrderDetailModel.h"
@interface YZGDetailsOrderSctionFootView ()
{
    CGFloat _price;
}
@property (nonatomic, strong) UILabel *totalPrices;        /**< 商品总价格 */

@end

@implementation YZGDetailsOrderSctionFootView
#pragma mark ************** 懒加载控件
- (UILabel *)totalPrices {
    if (!_totalPrices) {
        _totalPrices = [[UILabel alloc] init];
        _totalPrices.textAlignment = NSTextAlignmentRight;
        
        _totalPrices.font = systemFont(12);
        _totalPrices.text = @"共计3件商品 合计 1022.00 元 ";
    }
    return _totalPrices;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame ProductModel:(YZGNextOhterDetailModel *)model{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = RGB(227, 229, 230).CGColor;
        
        [self addSubview:self.totalPrices];
       
         [self showUpViewWithModel:model]; //计算，显示总价格
        
        [_totalPrices mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(self);
            make.right.equalTo(self).offset(-10);
            make.height.equalTo(@(40));
        }];
        
        
       
        
    }
    return self;
}

//计算价格
- (void)showUpViewWithModel:(YZGNextOhterDetailModel *)model{
   // YZGOrderDetailModel *detail = model.ezgOrderdetails;
    
    //处理产品个数
    NSArray *array = model.ezgOrderdetailsArr;
    NSInteger modelArrayCount = 0;
    for (YZGOrderDetailModel *model in array) {
       modelArrayCount = model.productQty + modelArrayCount;
    }
    
    //label富文本
    NSString *string = [NSString stringWithFormat:@"共计 %ld 件商品 合计 %.2f 元",modelArrayCount, model.productMoneyCount];
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:string];
    
    [attrString addAttribute:NSForegroundColorAttributeName
                       value:RGB(38, 66, 136)
                       range:[string rangeOfString:[NSString stringWithFormat:@"%ld",modelArrayCount]]];
    
    [attrString addAttribute:NSForegroundColorAttributeName
                       value:RGB(38, 66, 136)
                       range:[string rangeOfString:[NSString stringWithFormat:@"%.2f", model.productMoneyCount]]];
    
    self.totalPrices.attributedText = attrString;
}

@end
