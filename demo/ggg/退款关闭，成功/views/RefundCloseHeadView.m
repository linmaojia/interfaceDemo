//
//  RefundCloseHeadView.m
//  ggg
//
//  Created by LXY on 16/8/26.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "RefundCloseHeadView.h"

@interface RefundCloseHeadView()
@property (nonatomic, strong) UILabel *refundStateLab;   /**< 退款状态 */
@property (nonatomic, strong) UILabel *refundReasonLab;   /**< <#name#> */
@property (nonatomic, strong) UILabel *refundTimeLab;   /**< <#name#> */
@property (nonatomic, strong) UILabel *reasonLab;

@end

@implementation RefundCloseHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviewsForView];
        [self addConstraintsView];
    }
    return self;
}
- (UILabel *)refundStateLab {
    if (!_refundStateLab) {
        _refundStateLab = [[UILabel alloc] init];
        _refundStateLab.font = [UIFont boldSystemFontOfSize:16];
        _refundStateLab.text = @"退款关闭";
    }
    return _refundStateLab;
}
- (UILabel *)refundReasonLab {
    if (!_refundReasonLab) {
        _refundReasonLab = [[UILabel alloc] init];
        _refundReasonLab.font = [UIFont systemFontOfSize:14];
        _refundReasonLab.text = @"关闭原因: ";
    }
    return _refundReasonLab;
}
- (UILabel *)reasonLab {
    if (!_reasonLab) {
        _reasonLab = [[UILabel alloc] init];
        _reasonLab.font = [UIFont systemFontOfSize:14];
        _reasonLab.numberOfLines = 0;
        _reasonLab.text = @"由于卖家已发货，请您联系卖家或申请平台介入";
        _reasonLab.textColor = [UIColor grayColor];
    }
    return _reasonLab;
}
- (UILabel *)refundTimeLab {
    if (!_refundTimeLab) {
        _refundTimeLab = [[UILabel alloc] init];
        _refundTimeLab.font = [UIFont systemFontOfSize:14];
        _refundTimeLab.text = @"关闭时间: ";
    }
    return _refundTimeLab;
}
- (void)setCloseTime:(NSString *)closeTime
{
    
    _refundTimeLab.text = [NSString stringWithFormat:@"关闭时间: %@",closeTime];
    
    [self mutableAttributedLab:_refundTimeLab :closeTime];

}
- (void)setCloseReason:(NSString *)closeReason
{
    
    CGRect placehoderRect=[closeReason boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-75, MAXFLOAT)  options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    CGFloat height = placehoderRect.size.height;
    //更新约束
    [_reasonLab mas_updateConstraints:^(MASConstraintMaker *make){
        make.height.equalTo(@(height));
    }];
    _reasonLab.text = closeReason;

}
- (void)mutableAttributedLab:(UILabel *)lab :(NSString *)text{
    
    //label富文本
    NSString *string = lab.text;
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:string];
    [attrString addAttribute:NSForegroundColorAttributeName
                       value:[UIColor grayColor]
                       range:[string rangeOfString:text]];

    lab.attributedText = attrString;
    lab.textAlignment = NSTextAlignmentLeft;
 
}

#pragma mark ************** 添加子控件
- (void)addSubviewsForView
{
    [self addSubview:self.refundStateLab];
    [self addSubview:self.refundReasonLab];
    [self addSubview:self.reasonLab];
    [self addSubview:self.refundTimeLab];
}
#pragma mark ************** 添加约束
- (void)addConstraintsView
{
    
    [_refundStateLab makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(self).offset(15);
        make.height.equalTo(@35);
    }];
    [_refundReasonLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_refundStateLab.bottom).offset(5);
        make.left.equalTo(_refundStateLab);
        make.width.equalTo(@65);
        make.height.equalTo(@15);
    }];

    [_reasonLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_refundReasonLab);
        make.left.equalTo(_refundReasonLab.right);
        make.right.equalTo(self).offset(-5);
        make.height.equalTo(@15);
    }];


    [_refundTimeLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_reasonLab.bottom).offset(10);
        make.left.equalTo(_refundStateLab);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(_refundReasonLab);
    }];
}

@end
