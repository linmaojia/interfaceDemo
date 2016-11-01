//
//  YZGMineTableHeadView.m
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGRefundSuccessView.h"
#import "YZGSuccessBottomView.h"

@interface YZGRefundSuccessView()

@property (nonatomic, strong) UIView *topBgView;    /**< 白色背景View */
@property (nonatomic, strong) UIView *centerView;    /**< 蓝色背景View */
@property (nonatomic, strong) YZGSuccessBottomView *bottomView;    /**< 红色背景View */

@property (nonatomic, strong) UILabel *timeLab1; /**<  时间1 */
@property (nonatomic, strong) UILabel *timeLab2;  /**<  时间1 */
@property (nonatomic, strong) UILabel *timeLab3; /**<  时间1 */
@property (nonatomic, strong) UILabel *timeLab4;  /**<  时间1 */

//顶部
@property (nonatomic, strong) UILabel *requestLab;  /**<  发起申请 */
@property (nonatomic, strong) UIView *line1;      /**<  中间线 */
@property (nonatomic, strong) UILabel *reasonLab;  /**<  退款原因 */
//中部
@property (nonatomic, strong) UILabel *agreeLab1;  /**<  同意 */
@property (nonatomic, strong) UILabel *agreeLab2;  /**<  同意 */
@property (nonatomic, strong) UIView *line2;      /**<  中间线 */

@property (nonatomic, strong) UILabel *maneyLab;  /**<  价格 */
//三角形
@property (nonatomic, strong) UIImageView *image1;
@property (nonatomic, strong) UIImageView *image2;
@property (nonatomic, strong) UIImageView *image3;
@property (nonatomic, strong) UIImageView *image4;

@end

@implementation YZGRefundSuccessView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = RGB(245, 245, 245);
        
        [self addSubviewsForRefuldView];
        
        [self addConstraintsForRefuldView];

    }
    return self;
}

#pragma mark ************** 懒加载控件
- (UIImageView *)image1 {
    if (!_image1) {
        _image1= [[UIImageView alloc] init];
        _image1.image = [UIImage imageNamed:@"white_jian"];
    }
    return _image1;
}
- (UIImageView *)image2 {
    if (!_image2) {
        _image2= [[UIImageView alloc] init];
        _image2.image = [UIImage imageNamed:@"san"];
    }
    return _image2;
}
- (UIImageView *)image3 {
    if (!_image3) {
        _image3= [[UIImageView alloc] init];
        _image3.image = [UIImage imageNamed:@"san"];
    }
    return _image3;
}
- (UIImageView *)image4 {
    if (!_image4) {
        _image4= [[UIImageView alloc] init];
        _image4.image = [UIImage imageNamed:@"red_jian"];
    }
    return _image4;
}
- (UIView *)line2 {
    if (!_line2) {
        _line2 = [[UIView alloc] init];
        _line2.backgroundColor = [UIColor whiteColor];
    }
    return _line2;
}

- (UILabel *)maneyLab {
    if (!_maneyLab) {
        _maneyLab= [[UILabel alloc] init];
        _maneyLab.font = [UIFont systemFontOfSize:16];
        _maneyLab.backgroundColor = RGB(44, 68, 135);
        _maneyLab.textColor = [UIColor whiteColor];
        _maneyLab.text = @"   退款给买家 3000.00元。";
        _maneyLab.textAlignment = NSTextAlignmentLeft;
        _maneyLab.layer.cornerRadius = 5;
        _maneyLab.layer.masksToBounds = YES;
    }
    return _maneyLab;
}



- (UILabel *)requestLab {
    if (!_requestLab) {
        _requestLab= [[UILabel alloc] init];
        _requestLab.font = [UIFont systemFontOfSize:17];
        _requestLab.text = @"买家发起申请";
        _requestLab.textAlignment = NSTextAlignmentLeft;
    }
    return _requestLab;
}
- (UILabel *)reasonLab {
    if (!_reasonLab) {
        _reasonLab= [[UILabel alloc] init];
        _reasonLab.font = [UIFont systemFontOfSize:16];
        _reasonLab.text = @"发起了申请，货物状态：未发货，原因：拍错/多拍/不想要，金额:12120.00元。";
        _reasonLab.textAlignment = NSTextAlignmentLeft;
        _reasonLab.numberOfLines = 0;
    }
    return _reasonLab;
}

- (UILabel *)agreeLab1 {
    if (!_agreeLab1) {
        _agreeLab1= [[UILabel alloc] init];
        _agreeLab1.font = [UIFont systemFontOfSize:17];
        _agreeLab1.text = @"卖家已同意申请";
        _agreeLab1.textAlignment = NSTextAlignmentLeft;
        _agreeLab1.textColor = [UIColor whiteColor];
    }
    return _agreeLab1;
}
- (UILabel *)agreeLab2 {
    if (!_agreeLab2) {
        _agreeLab2= [[UILabel alloc] init];
        _agreeLab2.font = [UIFont systemFontOfSize:14];
        _agreeLab2.text = @"卖家同意了本次售后服务申请";
        _agreeLab2.textAlignment = NSTextAlignmentLeft;
        _agreeLab2.textColor = [UIColor whiteColor];
    }
    return _agreeLab2;
}

- (UIView *)line1 {
    if (!_line1) {
        _line1 = [[UIView alloc] init];
        _line1.backgroundColor = [UIColor blackColor];
    }
    return _line1;
}

- (UIView *)topBgView {
    if (!_topBgView) {
        _topBgView = [[UIView alloc] init];
        _topBgView.backgroundColor = [UIColor whiteColor];
        _topBgView.layer.cornerRadius = 5;
        _topBgView.layer.masksToBounds = YES;
    }
    return _topBgView;
}
- (UIView *)centerView {
    if (!_centerView) {
        _centerView = [[UIView alloc] init];
        _centerView.backgroundColor = RGB(44, 68, 135);
        _centerView.layer.cornerRadius = 5;
        _centerView.layer.masksToBounds = YES;
    }
    return _centerView;
}
- (YZGSuccessBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[YZGSuccessBottomView alloc] init];
        _bottomView.backgroundColor = RGB(221, 63, 58);
        _bottomView.layer.cornerRadius = 5;
        _bottomView.layer.masksToBounds = YES;
    }
    return _bottomView;
}
- (UILabel *)timeLab1 {
    if (!_timeLab1)
    {
        _timeLab1= [[UILabel alloc] init];
        _timeLab1.font = [UIFont systemFontOfSize:14];
        _timeLab1.text = @"09-23 08:33";
        _timeLab1.textAlignment = NSTextAlignmentCenter;
        _timeLab1.backgroundColor = [UIColor whiteColor];
        _timeLab1.layer.cornerRadius = 3;
        _timeLab1.layer.masksToBounds = YES;
    }
    return _timeLab1;
}
- (UILabel *)timeLab2 {
    if (!_timeLab2) {
        _timeLab2= [[UILabel alloc] init];
        _timeLab2.font = [UIFont systemFontOfSize:14];
        _timeLab2.text = @"09-23 08:33";
        _timeLab2.textAlignment = NSTextAlignmentCenter;
        _timeLab2.backgroundColor = [UIColor whiteColor];
        _timeLab2.layer.cornerRadius = 3;
        _timeLab2.layer.masksToBounds = YES;
    }
    return _timeLab2;
}
- (UILabel *)timeLab3 {
    if (!_timeLab3) {
        _timeLab3= [[UILabel alloc] init];
        _timeLab3.font = [UIFont systemFontOfSize:14];
        _timeLab3.text = @"09-23 08:33";
        _timeLab3.textAlignment = NSTextAlignmentCenter;
        _timeLab3.backgroundColor = [UIColor whiteColor];
        _timeLab3.layer.cornerRadius = 3;
        _timeLab3.layer.masksToBounds = YES;
    }
    return _timeLab3;
}
- (UILabel *)timeLab4 {
    if (!_timeLab4) {
        _timeLab4= [[UILabel alloc] init];
        _timeLab4.font = [UIFont systemFontOfSize:14];
        _timeLab4.text = @"09-23 08:33";
        _timeLab4.textAlignment = NSTextAlignmentCenter;
        _timeLab4.backgroundColor = [UIColor whiteColor];
        _timeLab4.layer.cornerRadius = 3;
        _timeLab4.layer.masksToBounds = YES;
    }
    return _timeLab4;
}


- (void)setOrderModel:(YZGNextOhterDetailModel *)orderModel
{
    YZGOrderDetailModel *detailModel =  orderModel.ezgOrderdetailsArr[self.indexPath.row];
    
    YZGEzgRefund *ezgRefundModel = detailModel.ezgRefund;
    
    //退款原因
    _reasonLab.text = [NSString stringWithFormat:@"发起了申请，货物状态:未发货，原因：%@，金额：%.2f元。",ezgRefundModel.refundReason,ezgRefundModel.refundMoney];
    
    //时间
    _timeLab1.text = [self changeTime:ezgRefundModel.applyDate];//申请时间
    NSString *refundTime = [self changeTime:ezgRefundModel.refundTime];//退款时间
    _timeLab2.text = refundTime;
    _timeLab3.text = refundTime;
    _timeLab4.text = refundTime;
    
    //退款金额
    _maneyLab.text = [NSString stringWithFormat:@"  退款给买家: %.2f元。",ezgRefundModel.refundMoney];
    
    _bottomView.orderModel = orderModel;
    
}
#pragma mark ************** 时间戳转换
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
#pragma mark ************** 添加子控件
- (void)addSubviewsForRefuldView
{
    [self addSubview:self.timeLab1];
    [self addSubview:self.timeLab2];
    [self addSubview:self.topBgView];
    [self addSubview:self.centerView];
    [self addSubview:self.timeLab3];
    [self addSubview:self.timeLab4];
    [self addSubview:self.maneyLab];
    
    [self addSubview:self.bottomView];
    //顶部
    [self.topBgView addSubview:self.requestLab];
    [self.topBgView addSubview:self.line1];
    [self.topBgView addSubview:self.reasonLab];
    //中部
    [self.centerView addSubview:self.agreeLab1];
    [self.centerView addSubview:self.agreeLab2];
    [self.centerView addSubview:self.line2];
    
    //三角形
    [self addSubview:self.image1];
    [self addSubview:self.image2];
    [self addSubview:self.image3];
    [self addSubview:self.image4];

}
#pragma mark ************** 添加约束
- (void)addConstraintsForRefuldView
{
    [_timeLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(20);
        make.width.equalTo(@120);
        make.height.equalTo(@(24));
        make.centerX.equalTo(self);
    }];
    
    [_topBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.right.equalTo(@(-15));
        make.height.equalTo(@(140));
        make.top.equalTo(_timeLab1.bottom).offset(10);
    }];
    
    [_timeLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topBgView.bottom).offset(20);
        make.width.equalTo(_timeLab1);
        make.height.equalTo(_timeLab1);
        make.centerX.equalTo(self);
    }];
    [_centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_timeLab2.bottom).offset(10);
        make.width.equalTo(_topBgView);
        make.centerX.equalTo(self);
        make.height.equalTo(@100);
    }];
    [_timeLab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_centerView.bottom).offset(20);
        make.width.equalTo(_timeLab1);
        make.height.equalTo(_timeLab1);
        make.centerX.equalTo(self);
    }];
    [_maneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_timeLab3.bottom).offset(10);
        make.width.equalTo(_topBgView);
        make.centerX.equalTo(self);
        make.height.equalTo(@50);
    }];
    [_timeLab4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_maneyLab.bottom).offset(20);
        make.width.equalTo(_timeLab1);
        make.height.equalTo(_timeLab1);
        make.centerX.equalTo(self);
    }];
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_timeLab4.bottom).offset(10);
        make.width.equalTo(_topBgView);
        make.centerX.equalTo(self);
        make.height.equalTo(@250);
    }];
    
    //顶部
    [_requestLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(_topBgView).offset(10);
        make.right.equalTo(_topBgView).offset(-10);
        make.height.equalTo(@30);
    }];
    [_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_requestLab.bottom).offset(10);
        make.centerX.equalTo(_topBgView);
        make.height.equalTo(@1);
        make.width.equalTo(_requestLab);

    }];
    [_reasonLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line1.bottom);
        make.bottom.equalTo(_topBgView);
        make.centerX.equalTo(_topBgView);
        make.width.equalTo(_requestLab);
    }];
    //中部
    [_agreeLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(_centerView).offset(10);
        make.right.equalTo(_centerView).offset(-10);
        make.height.equalTo(@30);
    }];
    [_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_agreeLab1.bottom).offset(10);
        make.centerX.equalTo(_centerView);
        make.height.equalTo(@1);
        make.width.equalTo(_agreeLab1);
    }];
    [_agreeLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line2.bottom);
        make.bottom.equalTo(_centerView);
        make.centerX.equalTo(_centerView);
        make.width.equalTo(_agreeLab1);
    }];

    //三角形
    [_image1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topBgView.right).offset(-8);
        make.width.height.equalTo(@25);
        make.top.equalTo(_topBgView).offset(8);
    }];
    [_image2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_centerView.left).offset(8);
        make.width.height.equalTo(@25);
        make.top.equalTo(_centerView).offset(8);
    }];
    [_image3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_maneyLab.left).offset(8);
        make.width.height.equalTo(@25);
        make.top.equalTo(_maneyLab).offset(8);
    }];
    [_image4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_bottomView.left).offset(8);
        make.width.height.equalTo(@25);
        make.top.equalTo(_bottomView).offset(8);
    }];

}

@end
