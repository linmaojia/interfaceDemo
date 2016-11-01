//
//  YZGMineTableHeadView.m
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGDetailsOrderHeadView.h"
#import "CZCountDownView.h"
#import "YZGDetailsOrderAdderssView.h"
@interface YZGDetailsOrderHeadView ()

@property (nonatomic, strong) UIView *orderTypeBg;            /**<  订单状态背景 */
@property (nonatomic, strong) UILabel *orderTypeLab;    /**< 订单状态文本 */
@property (nonatomic, strong) UIImageView *orderTypeImg;    /**< 订单状态图片 */
@property (nonatomic, strong) CZCountDownView *timeStamp;    /**< 倒计时 */
@property (nonatomic, strong) YZGDetailsOrderAdderssView *adderssView;    /**< 地址信息 */
@property (nonatomic, strong) UILabel *status;    /**< 细节状态 */
@end

@implementation YZGDetailsOrderHeadView


#pragma mark ************** 懒加载控件
- (UILabel *)status {
    if (!_status) {
        _status = [[UILabel alloc] init];
        _status.textColor = [UIColor whiteColor];
        _status.font = systemFont(12);
        _status.textAlignment = NSTextAlignmentLeft;
    }
    return _status;
}
- (UIView *)orderTypeBg {
    if (!_orderTypeBg) {
        _orderTypeBg = [[UIView alloc] init];
        _orderTypeBg.backgroundColor = mainColor;
    }
    return _orderTypeBg;
}
- (UILabel *)orderTypeLab {
    if (!_orderTypeLab) {
        _orderTypeLab = [[UILabel alloc] init];
        _orderTypeLab.textAlignment = NSTextAlignmentLeft;
        _orderTypeLab.font = boldSystemFont(18);
        _orderTypeLab.textColor = [UIColor whiteColor];
        _orderTypeLab.text = @"等待买家付款";
    }
    return _orderTypeLab;
}
- (CZCountDownView *)timeStamp {
    if (!_timeStamp) {
        _timeStamp = [[CZCountDownView alloc] init];
        _timeStamp.timerStopBlock = ^(){
            NSLog(@"时间到");
        };
    }
    return _timeStamp;
}
- (UIImageView *)orderTypeImg {
    if (!_orderTypeImg) {
        _orderTypeImg = [[UIImageView alloc] init];
        [_orderTypeImg setContentMode:UIViewContentModeScaleAspectFit];
    }
    return _orderTypeImg;
}
- (YZGDetailsOrderAdderssView *)adderssView {
    if (!_adderssView) {
        _adderssView = [[YZGDetailsOrderAdderssView alloc] init];
    }
    return _adderssView;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubviewsForHeadView];
        [self addConstraintsForHeadView];
        
    }
    return self;
}
- (void)setModel:(YZGNextOhterDetailModel *)model{
    _model = model;
    _adderssView.model = self.model;
    switch (model.isCheckState) {
        case 0:
        {
            _orderTypeLab.text = @"等待买家付款";
            _orderTypeImg.image = [UIImage imageNamed:@"icon_my_order_01"];
            _status.hidden = YES;
            _timeStamp.type = 0;
            _timeStamp.timestamp = model.addDate/1000 + 7200 - [NSDate date].timeIntervalSince1970;
            
            break;
        }
       
        case 1:
        {
            _orderTypeLab.text = @"等待卖家发货";
            _orderTypeImg.image = [UIImage imageNamed:@"icon_my_order_02"];
            _status.text = @"订单待确认";
            _timeStamp.hidden = YES;
            
            break;
        }
        case 2:
        {
            _orderTypeLab.text = @"等待卖家发货";
            _orderTypeImg.image = [UIImage imageNamed:@"icon_my_order_02"];
            _status.text = @"你的包裹正整装待发";
            _timeStamp.hidden = YES;
            
            break;
        }
        case 3:
        {
            _orderTypeLab.text = @"卖家已发货";
            _orderTypeImg.image = [UIImage imageNamed:@"icon_my_order_03"];
            _status.hidden = YES;
            _timeStamp.type = 1;
            
            NSInteger time = [self getCurrentDaySurplusSecond:model.deliveryDate/1000];
            if(time < 0)
            {
                _timeStamp.hidden = YES;
            }
            else
            {
                _timeStamp.timestamp = time;
            }
            break;
        }
        case 4:
        {
            _orderTypeLab.text = @"交易成功";
            _orderTypeImg.image = [UIImage imageNamed:@"icon_my_order_04"];
            _status.hidden = YES;
            _timeStamp.hidden = YES;
            
            break;
        }
        case 5:
        {
            _orderTypeLab.text = @"交易已关闭";
            _orderTypeImg.image = [UIImage imageNamed:@"icon_my_order_05"];
            _timeStamp.hidden = YES;
            
            YZGOrderOperator *orderOperator = model.ezgOrderOperator;
             _status.text = orderOperator.operatorAction;
            break;
        }
    }
    
}
//计算订单当天经过时间
- (NSTimeInterval )calculatorWithOrderTime:(NSTimeInterval)timestamp
{
    
    NSDate *beginDate = [NSDate dateWithTimeIntervalSince1970:timestamp];
    
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian]; // 指定日历的算法 NSCalendarIdentifierGregorian,NSGregorianCalendar
    // NSDateComponent 可以获得日期的详细信息，即日期的组成
    NSDateComponents *comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond|NSCalendarUnitWeekOfMonth|NSCalendarUnitWeekday fromDate:beginDate];
    
    //设置时间dataFormatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];  // 设置时间格式
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
    
    [dateFormatter setTimeZone:timeZone]; //设置时区 ＋8:00
    
    //加入当天的日期
    NSString  *someDayStr= [NSString stringWithFormat:@"%ld-%ld-%ld 00:00:00",comps.year,comps.month,comps.day];   // 设置过去的某个时间点比如:2000-01-01 00:00:00
    
    //需要对比的某个时间(订单申请的 当天 0点 时间)
    NSDate *someDayDate = [dateFormatter dateFromString:someDayStr];
    
    //订单申请的时间
    NSTimeInterval beginTime = timestamp + 8 * 60 * 60;
    NSDate *orderBeginDate = [NSDate dateWithTimeIntervalSince1970:beginTime];
    
    //申请订单当天经过时间
    NSTimeInterval courseTime = [orderBeginDate timeIntervalSinceDate:someDayDate];
    
    return courseTime;
}


- (NSInteger)getCurrentDaySurplusSecond:(NSInteger)timestamp
{
    //时间戳
    
    //计算申请退款当天经过的时间 然后 用总时间 减掉
    NSTimeInterval courseTime = [self calculatorWithOrderTime:timestamp];
    
    NSTimeInterval beginTime = timestamp + 8 * 60 * 60;
    NSTimeInterval endTime = beginTime + 16 * 24 * 60 * 60 - courseTime;
    
    //申请退款的时间
    NSDate *beginDate = [NSDate dateWithTimeIntervalSince1970:beginTime];
    //当前时间
    NSDate *currentDate = [NSDate dateWithTimeIntervalSinceNow:8 * 60 * 60];
    //过期时间
    NSDate *endDate = [NSDate dateWithTimeIntervalSince1970:endTime];
    
    //当前时间 跟 申请退款 时间差
    NSInteger currentTime = (NSInteger)[currentDate timeIntervalSinceDate:beginDate];
    
    //过期时间 跟 申请退款 时间差
    NSInteger totalTime = (NSInteger)[endDate timeIntervalSinceDate:beginDate];
    
    //过期时间 - 经过的时间 = 剩余时间
    NSInteger finalTime = totalTime - currentTime;
    
    return finalTime;
}

#pragma mark ************** 添加子控件
- (void)addSubviewsForHeadView
{
    
    [self addSubview:self.orderTypeBg];
    [self addSubview:self.adderssView];
    
    [self.orderTypeBg addSubview:self.status];
    [self.orderTypeBg addSubview:self.orderTypeLab];
    [self.orderTypeBg addSubview:self.timeStamp];
    [self.orderTypeBg addSubview:self.orderTypeImg];
}
#pragma mark ************** 添加约束
- (void)addConstraintsForHeadView
{
    [_orderTypeBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.equalTo(@(100));
    }];
    [_adderssView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(_orderTypeBg.bottom);
        make.bottom.equalTo(self);
    }];
    [_orderTypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(AUTO_MATE_WIDTH(45));
        make.top.equalTo(self).offset(20);
        make.height.equalTo(@(30));
        make.width.equalTo(@(150));
    }];
    [_timeStamp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(AUTO_MATE_WIDTH(45));
        make.top.equalTo(_orderTypeLab.bottom);
        make.height.equalTo(@(20));
        make.width.equalTo(@(150));
    }];
    
    [_status mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(AUTO_MATE_WIDTH(45));
        make.width.equalTo(@(150));
        make.height.equalTo(@(20));
        make.top.equalTo(_orderTypeLab.bottom);
    }];
    
    [_orderTypeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(AUTO_MATE_WIDTH(-45));
        make.top.equalTo(self).offset(10);
        make.height.width.equalTo(@(80));
    }];
}

@end
