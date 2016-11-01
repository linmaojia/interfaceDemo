//
//  YZGSuccessBottomView.m
//  ggg
//
//  Created by LXY on 16/9/23.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGSuccessBottomView.h"


@interface YZGSuccessBottomView ()

//尾部
@property (nonatomic, strong) UILabel *successLab;  /**<  退款成功 */
@property (nonatomic, strong) UIView *line4;      /**<  中间线 */
@property (nonatomic, strong) UIView *centerView;
@property (nonatomic, strong) UIView *line3;      /**<  中间线 */
@property (nonatomic, strong) UILabel *numberLab;  /**<  退款编号 */

//中部
@property (nonatomic, strong) UILabel *maneyLab1;
@property (nonatomic, strong) UILabel *maneyLab2;
@property (nonatomic, strong) UILabel *alipayLab;  /**<  支付宝 */

@property (nonatomic, strong) UIImageView *image1;
@property (nonatomic, strong) UIImageView *image2;
@property (nonatomic, strong) UIImageView *image3;

@property (nonatomic, strong) UIImageView *boult1;
@property (nonatomic, strong) UIImageView *boult2;

@property (nonatomic, strong) UILabel *Lab1;
@property (nonatomic, strong) UILabel *Lab2;
@property (nonatomic, strong) UILabel *Lab3;


@end
@implementation YZGSuccessBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        
        [self addSubviewsForBottomView];
        
        [self addConstraintsForBottomView];
        
        [self setBgView];
    }
    return self;
}

- (void)setOrderModel:(YZGNextOhterDetailModel *)orderModel
{
    YZGOrderDetailModel *detailModel =  orderModel.ezgOrderdetailsArr[self.indexPath.row];
    
    YZGEzgRefund *ezgRefundModel = detailModel.ezgRefund;
    
    _maneyLab1.text = [NSString stringWithFormat:@"退款金额: %.2f元",ezgRefundModel.refundMoney];
    
    _maneyLab2.text = [NSString stringWithFormat:@"%.2f元",ezgRefundModel.refundMoney];
    
    NSString *string = ezgRefundModel.refundAccount;//支付宝账号
    
    NSString *refundCount = [string substringFromIndex:string.length- 4];
    
    _alipayLab.text = [NSString stringWithFormat:@"退回支付宝 (**%@)",refundCount];
    
    _numberLab.text = [NSString stringWithFormat:@"退款编号: %@",ezgRefundModel.refundCode];//退款编号
    
     NSString *refundTime = [self changeTime:ezgRefundModel.refundTime];//退款时间
    
    _Lab3.text = [NSString stringWithFormat:@"到账时间\n%@",refundTime];//到账时间

}
- (NSString *)changeTime:(NSInteger)time{
    NSString *strTime;
    NSDate *newdate=[NSDate dateWithTimeIntervalSince1970:time/1000];//NSDate
    //定义时间格式
    NSDateFormatter *dateformatter=[NSDateFormatter new];
    [dateformatter setDateFormat:@"MM-dd HH:mm"];
    //转为字符串
    strTime =[dateformatter stringFromDate:newdate];
    return strTime;
}
- (UILabel *)Lab1 {
    if (!_Lab1) {
        _Lab1= [[UILabel alloc] init];
        _Lab1.font = [UIFont systemFontOfSize:13];
        _Lab1.textColor = RGB(239, 152, 147);
        _Lab1.text = @"卖家已同意";
        _Lab1.textAlignment = NSTextAlignmentCenter;
    }
    return _Lab1;
}
- (UILabel *)Lab2 {
    if (!_Lab2) {
        _Lab2= [[UILabel alloc] init];
        _Lab2.font = [UIFont systemFontOfSize:13];
        _Lab2.textColor = RGB(239, 152, 147);
        _Lab2.text = @"银行处理成功";
        _Lab2.textAlignment = NSTextAlignmentCenter;
    }
    return _Lab2;
}
- (UILabel *)Lab3 {
    if (!_Lab3) {
        _Lab3= [[UILabel alloc] init];
        _Lab3.font = [UIFont systemFontOfSize:13];
        _Lab3.textColor = [UIColor whiteColor];
        _Lab3.text = @"到账时间\n06-14 16:40";
        _Lab3.numberOfLines = 0;
        _Lab3.textAlignment = NSTextAlignmentCenter;
    }
    return _Lab3;
}
- (UIImageView *)boult1 {
    if (!_boult1) {
        _boult1= [[UIImageView alloc] init];
        _boult1.image = [UIImage imageNamed:@"jian"];
        
    }
    return _boult1;
}
- (UIImageView *)boult2 {
    if (!_boult2) {
        _boult2= [[UIImageView alloc] init];
        _boult2.image = [UIImage imageNamed:@"jian"];
    }
    return _boult2;
}
- (UIImageView *)image1 {
    if (!_image1) {
        _image1= [[UIImageView alloc] init];
        _image1.image = [UIImage imageNamed:@"gou"];
      
    }
    return _image1;
}
- (UIImageView *)image2 {
    if (!_image2) {
        _image2= [[UIImageView alloc] init];
        _image2.image = [UIImage imageNamed:@"gou"];
        
    }
    return _image2;
}
- (UIImageView *)image3 {
    if (!_image3) {
        _image3= [[UIImageView alloc] init];
        _image3.image = [UIImage imageNamed:@"img-Payment- date"];
        
    }
    return _image3;
}
- (UILabel *)maneyLab2 {
    if (!_maneyLab2) {
        _maneyLab2= [[UILabel alloc] init];
        _maneyLab2.font = [UIFont systemFontOfSize:14];
        _maneyLab2.textColor = [UIColor whiteColor];
        _maneyLab2.text = @"3000.00元";
        _maneyLab2.textAlignment = NSTextAlignmentLeft;
    }
    return _maneyLab2;
}
- (UILabel *)maneyLab1 {
    if (!_maneyLab1) {
        _maneyLab1= [[UILabel alloc] init];
        _maneyLab1.font = [UIFont systemFontOfSize:14];
        _maneyLab1.textColor = [UIColor whiteColor];
        _maneyLab1.text = @"退款金额: 3000.00元";
        _maneyLab1.textAlignment = NSTextAlignmentLeft;
    }
    return _maneyLab1;
}
- (UILabel *)alipayLab {
    if (!_alipayLab) {
        _alipayLab= [[UILabel alloc] init];
        _alipayLab.font = [UIFont systemFontOfSize:14];
        _alipayLab.textColor = [UIColor whiteColor];
        _alipayLab.text = @"退回支付宝 (**4543)";
        _alipayLab.textAlignment = NSTextAlignmentLeft;
    }
    return _alipayLab;
}
- (UIView *)centerView {
    if (!_centerView) {
        _centerView = [[UIView alloc] init];
        _centerView.backgroundColor = RGB(221, 63, 58);;
    }
    return _centerView;
}
- (UIView *)line3 {
    if (!_line3) {
        _line3 = [[UIView alloc] init];
        _line3.backgroundColor = [UIColor whiteColor];
    }
    return _line3;
}
- (UIView *)line4 {
    if (!_line4) {
        _line4 = [[UIView alloc] init];
        _line4.backgroundColor = [UIColor whiteColor];
    }
    return _line4;
}
- (UILabel *)numberLab {
    if (!_numberLab) {
        _numberLab= [[UILabel alloc] init];
        _numberLab.font = [UIFont systemFontOfSize:15];
        _numberLab.textColor = [UIColor whiteColor];
        _numberLab.text = @"退款编号:882932303002839";
        _numberLab.textAlignment = NSTextAlignmentLeft;
    }
    return _numberLab;
}
- (UILabel *)successLab {
    if (!_successLab) {
        _successLab= [[UILabel alloc] init];
        _successLab.font = [UIFont systemFontOfSize:17];
        _successLab.text = @"退款成功";
        _successLab.textColor = [UIColor whiteColor];
        _successLab.textAlignment = NSTextAlignmentLeft;
    }
    return _successLab;
}
#pragma mark ************** 设置边框
- (void)setBgView
{

    //虚线边框
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.bounds = CGRectMake(0, 0, SCREEN_WIDTH - 50, 140);
    borderLayer.position = CGPointMake(CGRectGetMidX(borderLayer.bounds), CGRectGetMidY(borderLayer.bounds));
    
    borderLayer.path = [UIBezierPath bezierPathWithRect:borderLayer.bounds].CGPath;
    borderLayer.lineWidth = 1.0;
    
    borderLayer.lineDashPattern = @[@8, @8];//虚线边框
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    borderLayer.strokeColor = [UIColor whiteColor].CGColor;
    [_centerView.layer addSublayer:borderLayer];
}
#pragma mark ************** 添加子控件
- (void)addSubviewsForBottomView
{

    [self addSubview:self.successLab];
    [self addSubview:self.line3];
    [self addSubview:self.numberLab];
    [self addSubview:self.line4];
    //中部
    [self addSubview:self.centerView];
    [self.centerView addSubview:self.maneyLab1];
    [self.centerView addSubview:self.maneyLab2];
    [self.centerView addSubview:self.alipayLab];
    
    [self.centerView addSubview:self.image1];
    [self.centerView addSubview:self.image2];
    [self.centerView addSubview:self.image3];

    [self.centerView addSubview:self.boult1];
    [self.centerView addSubview:self.boult2];

    [self.centerView addSubview:self.Lab1];
    [self.centerView addSubview:self.Lab2];
    [self.centerView addSubview:self.Lab3];

}
#pragma mark ************** 添加约束
- (void)addConstraintsForBottomView
{

    [_successLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@30);
    }];
    [_line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_successLab.bottom).offset(10);
        make.centerX.equalTo(self);
        make.height.equalTo(@1);
        make.width.equalTo(_successLab);
    }];
    
    [_numberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-10);
        make.centerX.equalTo(self);
        make.height.equalTo(@20);
        make.width.equalTo(_successLab);
    }];
    [_line4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_numberLab.top).offset(-10);
        make.centerX.equalTo(self);
        make.height.equalTo(@1);
        make.width.equalTo(_successLab);
    }];
    
    //中部
    [_centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.left.equalTo(self).offset(10);
        make.top.equalTo(_line3.bottom).offset(10);
        make.bottom.equalTo(_line4.top).offset(-10);
    }];
    
    [_maneyLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(_centerView).offset(5);
        make.right.equalTo(_centerView).offset(-5);
        make.height.equalTo(@25);
    }];
    [_alipayLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_maneyLab1);
        make.top.equalTo(_maneyLab1.bottom);
        make.height.equalTo(_maneyLab1);
    }];
    [_maneyLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_alipayLab);
        make.right.equalTo(_centerView).offset(-5);
        make.height.equalTo(_maneyLab1);
    }];
  
    ///
    [_image2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_centerView);
        make.width.height.equalTo(@36);
        make.top.equalTo(_alipayLab.bottom).offset(10);
    }];
    [_image1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_centerView).offset(20);
        make.width.height.equalTo(@36);
        make.centerY.equalTo(_image2);
    }];
    [_image3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_centerView).offset(-20);
        make.width.height.equalTo(@36);
        make.centerY.equalTo(_image2);
    }];
    
    //
    [_boult1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_image2);
        make.left.equalTo(_image1.right).offset(20);
        make.right.equalTo(_image2.left).offset(-20);
        make.height.equalTo(@32);
    }];
    [_boult2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_image2);
        make.left.equalTo(_image2.right).offset(20);
        make.right.equalTo(_image3.left).offset(-20);
        make.height.equalTo(@32);
    }];
    
    //
    [_Lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_image1);
        make.top.equalTo(_image1.bottom);
        make.height.equalTo(@20);
        make.width.equalTo(@80);
    }];
    [_Lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_image2);
        make.top.equalTo(_image2.bottom);
        make.height.equalTo(@20);
        make.width.equalTo(@90);
    }];
    [_Lab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_image3);
        make.top.equalTo(_image3.bottom);
        make.height.equalTo(@40);
        make.width.equalTo(@80);
    }];

}
@end
