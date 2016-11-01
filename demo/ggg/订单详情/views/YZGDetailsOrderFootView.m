//
//  YZGMineTableHeadView.m
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGDetailsOrderFootView.h"


@interface YZGDetailsOrderFootView ()
{
    NSArray *nameArray;
    NSArray *detailArray;
}
@property (nonatomic, strong) UIView *spaceView;          /**<  顶部空隙 */
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *orderNumberLab;    /**< 订单编号 */
@property (nonatomic, strong) UILabel *orderCreatTime;    /**< 订单创建时间 */
@property (nonatomic, strong) UIView *remarksView;    /**< 备注背景view */
@property (nonatomic, strong) UILabel *remarksLab;    /**< 备注文本 */


@end

@implementation YZGDetailsOrderFootView


#pragma mark ************** 懒加载控件
- (UIView *)remarksView {
    if (!_remarksView) {
        _remarksView = [[UIView alloc] init];
        _remarksView.backgroundColor = hexColor(FFFFFF);
        _remarksView.userInteractionEnabled = YES;
        _remarksView.layer.borderWidth = 0.5;
        _remarksView.layer.borderColor = RGB(227, 229, 230).CGColor;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(remarkFootClick:)];
        [_remarksView addGestureRecognizer:tap];
        
    }
    return _remarksView;
}
- (UILabel *)remarksLab {
    if (!_remarksLab) {
        _remarksLab = [[UILabel alloc] init];
        _remarksLab.font = [UIFont systemFontOfSize:12];
        _remarksLab.textColor = [UIColor grayColor];
        _remarksLab.backgroundColor = [UIColor whiteColor];
        _remarksLab.text = @"备注:";
        _remarksLab.numberOfLines = 0;
    }
    return _remarksLab;
}
- (UIView *)spaceView {
    if (!_spaceView) {
        _spaceView = [[UIView alloc] init];
        _spaceView.backgroundColor = RGB(247, 247, 247);
        
    }
    return _spaceView;
}
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.borderWidth = 0.5;
        _bgView.layer.borderColor = RGB(227, 229, 230).CGColor;
        
    }
    return _bgView;
}
- (UILabel *)orderNumberLab {
    if (!_orderNumberLab) {
        _orderNumberLab = [[UILabel alloc] init];
        _orderNumberLab.backgroundColor = [UIColor whiteColor];
        _orderNumberLab.textAlignment = NSTextAlignmentLeft;
        _orderNumberLab.font = systemFont(12);
        _orderNumberLab.text = @"订单编号: 678e89279879789 ";
    }
    return _orderNumberLab;
}
- (UILabel *)orderCreatTime {
    if (!_orderCreatTime) {
        _orderCreatTime = [[UILabel alloc] init];
        _orderCreatTime.backgroundColor = [UIColor whiteColor];
        _orderCreatTime.textAlignment = NSTextAlignmentLeft;
        _orderCreatTime.font = systemFont(12);
        _orderCreatTime.text = @"创建时间: 20156979 13：23";
    }
    return _orderCreatTime;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = RGB(247, 247, 247);
        
        [self addSubviewsForDetailFoot];
        [self addConstraintsForDetailFoot];
       
    
        
    }
    return self;
}
#pragma mark ************** 备注点击
-(void)remarkFootClick:(UITapGestureRecognizer *)sender
{
 
    
    if(self.remarkFootBlack)
    {
        self.remarkFootBlack(_remarksLab.text);
    }
}
- (void)setModel:(YZGNextOhterDetailModel *)model{
    _model = model;
    
    //备注
    if([_model.remarks isEqualToString:@""] || _model.remarks == nil)
    {
        _remarksLab.text = @"品牌备注: 无";
    }
    else
    {
        _remarksLab.text = [NSString stringWithFormat:@"品牌备注: %@",_model.remarks];
    }
    
    nameArray = [NSArray array];
    detailArray = [NSArray array];
    
    
    
    if(model.isCheckState == 0)
    {
        nameArray = @[@"订单编号:",@"创建时间:"];
        detailArray = @[model.orderId,[self changeTime:model.addDate]];
    }
    else if(model.isCheckState == 1 || model.isCheckState == 2)
    {
        nameArray = @[@"订单编号:",@"创建时间:",@"付款时间:"];
        detailArray = @[model.orderId,[self changeTime:model.addDate],[self changeTime:model.onlinePayDate]];
    }
    else if(model.isCheckState == 3)
    {
        nameArray = @[@"订单编号:",@"创建时间:",@"付款时间:",@"发货时间:"];
        detailArray = @[model.orderId,[self changeTime:model.addDate],[self changeTime:model.onlinePayDate],[self changeTime:model.deliveryDate]];
    }
    else if(model.isCheckState == 4)
    {
        nameArray = @[@"订单编号:",@"创建时间:",@"付款时间:",@"发货时间:",@"成交时间:"];
        detailArray = @[model.orderId,[self changeTime:model.addDate],[self changeTime:model.onlinePayDate],[self changeTime:model.deliveryDate],[self changeTime:model.completionDate]];
    }
    else if(model.isCheckState == 5)
    {
        nameArray = @[@"订单编号:",@"创建时间:",@"关闭时间:"];
        detailArray = @[model.orderId,[self changeTime:model.addDate],[self changeTime:model.closeDate]];
    }
    
    //添加背景
     [self addSubview:self.bgView];
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_remarksView.bottom).offset(10);
        make.left.right.equalTo(self);
        make.height.equalTo(@(30*nameArray.count));
    }];
    
    [self creatLab];
}
#pragma mark ************** 时间戳转换
- (NSString *)changeTime:(NSInteger)time{
    NSString *strTime;
    NSDate *newdate=[NSDate dateWithTimeIntervalSince1970:time/1000];//NSDate
    //定义时间格式
    NSDateFormatter *dateformatter=[NSDateFormatter new];
    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    //转为字符串
    strTime =[dateformatter stringFromDate:newdate];
    return strTime;
}
#pragma mark ************** 创建label
- (void)creatLab{

    
    for(int i = 0;i<nameArray.count;i++)
    {
        UILabel *Lab = [[UILabel alloc] initWithFrame:CGRectMake(8, i*30, SCREEN_WIDTH, 30)];
        Lab.tag = 200+i;
        Lab.backgroundColor = [UIColor whiteColor];
        Lab.textAlignment = NSTextAlignmentLeft;
        Lab.font = systemFont(12);
        Lab.text = [NSString stringWithFormat:@"%@ %@",nameArray[i],detailArray[i]];
        
        //隐藏付款时间
        if(self.model.isPayType == 1)
        {
            if([nameArray[i] isEqualToString:@"付款时间:"])
            {
              Lab.text = @"付款时间: 暂无";
            }
            
        }
        
        [_bgView addSubview:Lab];
    }
    
   
    
}

- (void)addSubviewsForDetailFoot
{
    
    [self addSubview:self.spaceView];
    [self addSubview:self.remarksView];
    [self.remarksView addSubview:self.remarksLab];
   
}
- (void)addConstraintsForDetailFoot
{
    
    [_spaceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.equalTo(@(10));
    }];
    [_remarksView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_spaceView.bottom);
        make.left.right.equalTo(self);
        make.height.equalTo(@(50));
    }];
    [_remarksLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_remarksView);
        make.height.equalTo(_remarksView);
        make.left.equalTo(_remarksView).offset(20);
        make.right.equalTo(_remarksView).offset(-20);
    }];
    
}

@end
