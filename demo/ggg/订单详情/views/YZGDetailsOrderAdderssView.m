//
//  YZGMineTableHeadView.m
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGDetailsOrderAdderssView.h"


@interface YZGDetailsOrderAdderssView ()
@property (nonatomic, strong) UIView *topBgView;    /**< 图片背景view */
@property (nonatomic, strong) UIView *bottomView;    /**< 底部背景view */
@property (nonatomic, strong) UILabel *nameLab;    /**< 名称 */
@property (nonatomic, strong) UILabel *phoneLab;    /**< 名称 */
@property (nonatomic, strong) UIImageView *adderssImg;    /**< 地址图片 */
@property (nonatomic, strong) UILabel *adderssLab;    /**< 地址 */
@property (nonatomic, strong) UIView *lineView;            /**<  线条 */
@property (nonatomic, strong) UILabel *companyLab;    /**< 公司 */
@property (nonatomic, strong) UILabel *logisticalLab;    /**< 物流 */
@property (nonatomic, strong) UILabel *logisticalPhoneLab;    /**< 物流电话 */

@end

@implementation YZGDetailsOrderAdderssView


#pragma mark ************** 懒加载控件
- (UIView *)topBgView {
    if (!_topBgView) {
        _topBgView = [[UIView alloc] init];
        _topBgView.backgroundColor = [UIColor whiteColor];
    }
    return _topBgView;
}
- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [UIColor whiteColor];
        _bottomView.layer.borderWidth = 0.5;
        _bottomView.layer.borderColor = RGB(227, 229, 230).CGColor;
    }
    return _bottomView;
}
- (UILabel *)nameLab {
    if (!_nameLab) {
        _nameLab = [[UILabel alloc] init];
        _nameLab.textAlignment = NSTextAlignmentLeft;
        _nameLab.font = systemFont(16);
        _nameLab.textColor = [UIColor blackColor];
        _nameLab.text = @"和志向";
    }
    return _nameLab;
}
- (UILabel *)phoneLab {
    if (!_phoneLab) {
        _phoneLab = [[UILabel alloc] init];
        _phoneLab.textAlignment = NSTextAlignmentLeft;
        _phoneLab.font = systemFont(16);
        _phoneLab.textColor = [UIColor blackColor];
        _phoneLab.text = @"1423234333";
    }
    return _phoneLab;
}
- (UILabel *)adderssLab {
    if (!_adderssLab) {
        _adderssLab = [[UILabel alloc] init];
        _adderssLab.textAlignment = NSTextAlignmentLeft;
        _adderssLab.font = systemFont(12);
        _adderssLab.textColor = [UIColor blackColor];
        _adderssLab.numberOfLines = 0;//上面两行设置多行显示
        _adderssLab.text = @"广东省中山市古镇个虎一定的王洪刚发你";
    }
    return _adderssLab;
}
- (UIImageView *)adderssImg {
    if (!_adderssImg) {
        _adderssImg = [[UIImageView alloc] init];
        _adderssImg.image = [UIImage imageNamed:@"icon_add"];
    }
    return _adderssImg;
}
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = RGB(227, 229, 230);
    }
    return _lineView;
}
- (UILabel *)companyLab {
    if (!_companyLab) {
        _companyLab = [[UILabel alloc] init];
        _companyLab.textAlignment = NSTextAlignmentLeft;
        _companyLab.font = systemFont(12);
        _companyLab.textColor = [UIColor blackColor];
        _companyLab.text = @"公司名称: 偶鞥报灯饰";
    }
    return _companyLab;
}
- (UILabel *)logisticalLab {
    if (!_logisticalLab) {
        _logisticalLab = [[UILabel alloc] init];
        _logisticalLab.textAlignment = NSTextAlignmentLeft;
        _logisticalLab.font = systemFont(12);
        _logisticalLab.textColor = [UIColor blackColor];
        _logisticalLab.text = @"物流公司: 浙江物流";
    }
    return _logisticalLab;
}
- (UILabel *)logisticalPhoneLab {
    if (!_logisticalPhoneLab) {
        _logisticalPhoneLab = [[UILabel alloc] init];
        _logisticalPhoneLab.textAlignment = NSTextAlignmentLeft;
        _logisticalPhoneLab.font = systemFont(12);
        _logisticalPhoneLab.textColor = [UIColor blackColor];
        _logisticalPhoneLab.text = @"134544343434";
    }
    return _logisticalPhoneLab;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubviewsForAdderssView];
        [self addConstraintsForAdderssView];
  
    }
    return self;
}
- (void)setModel:(YZGNextOhterDetailModel *)model{
    _model = model;
    
    self.phoneLab.text = model.deliverPhone;
    
    //判断详细地址是否为空
    if([model.deliverInfo rangeOfString:@"null"].location == NSNotFound )
    {
        NSLog(@"不存在");
        self.adderssLab.text = model.deliverInfo;
    }
    else
    {
      
       NSString *adderss = [model.deliverInfo substringWithRange:NSMakeRange(0, model.deliverInfo.length -4)];
       self.adderssLab.text = adderss;
    }
    

    //判断是否存在公司名称
    if([model.deliverName rangeOfString:@"("].location == NSNotFound )
    {
        NSLog(@"不存在");
        self.nameLab.text = model.deliverName;
        self.companyLab.text = @"公司名称: 暂无";   //公司名称
        
    }
    else
    {
        NSLog(@"存在");
        //取出用户名称
        NSRange theRange=[model.deliverName rangeOfString:@"("];
        NSString *name = [model.deliverName substringWithRange:NSMakeRange(0,theRange.location)];
        self.nameLab.text = name;
        
        //取出用户公司名称
        NSRange Range=[model.deliverName rangeOfString:@")"];
        NSString *company = [model.deliverName substringWithRange:NSMakeRange(theRange.location+1,Range.location-theRange.location-1)];
        if(company != nil)
        {
          self.companyLab.text = [NSString stringWithFormat:@"公司名称: %@",company];
        }
        else
        {
          self.companyLab.text = @"公司名称: 暂无";
        }
        
        
    }

    //物流信息
   if(model.logisticsInfo != nil)
   {
       
       //判断是否存物流电话
       if([model.logisticsInfo rangeOfString:@"("].location == NSNotFound )
       {
           NSLog(@"不存在");
           self.logisticalLab.text = [NSString stringWithFormat:@"物流公司: %@",model.logisticsInfo];
           self.logisticalPhoneLab.text = @"";
       }
       else
       {
           //取出物流公司名称
           NSRange theRange=[model.logisticsInfo rangeOfString:@"("];
           NSString *text = [model.logisticsInfo substringWithRange:NSMakeRange(0,theRange.location)];
           self.logisticalLab.text = [NSString stringWithFormat:@"物流公司: %@",text];
           
           //取出物流电话
           NSRange Range=[model.logisticsInfo rangeOfString:@")"];
           NSString *phone = [model.logisticsInfo substringWithRange:NSMakeRange(theRange.location+1,Range.location-theRange.location-1)];
           self.logisticalPhoneLab.text = phone;
       }
       
       

   }
   else
    {
       self.logisticalLab.text = @"物流公司: 暂无";
        self.logisticalPhoneLab.text = @"";
    }
    
    
}

#pragma mark ************** 添加子控件
- (void)addSubviewsForAdderssView
{
    
    [self addSubview:self.topBgView];
    [self addSubview:self.bottomView];
    
    [self.topBgView addSubview:self.nameLab];
    [self.topBgView addSubview:self.phoneLab];
    [self.topBgView addSubview:self.adderssImg];
    [self.topBgView addSubview:self.adderssLab];
    [self.bottomView addSubview:self.companyLab];
    [self.bottomView addSubview:self.logisticalLab];
    [self.bottomView addSubview:self.logisticalPhoneLab];
}
#pragma mark ************** 添加约束
- (void)addConstraintsForAdderssView
{
    
    
    [_topBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.equalTo(@(70));
    }];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topBgView.bottom);
        make.left.right.equalTo(self);
        make.bottom.equalTo(self);
    }];
    //顶部
    [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topBgView).offset(AUTO_MATE_WIDTH(45));
        make.top.equalTo(_topBgView).offset(5);
        make.height.equalTo(@(30));
        make.width.equalTo(@(100));
    }];
    [_phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLab.right);
        make.top.equalTo(_topBgView).offset(5);
        make.height.equalTo(@(30));
        make.width.equalTo(@(AUTO_MATE_WIDTH(120)));
    }];
    
    [_adderssLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLab);
        make.right.equalTo(_topBgView).offset(-10);
        make.top.equalTo(_nameLab.bottom);
        make.height.equalTo(@(30));
    }];
    [_adderssImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_adderssLab.left).offset(-5);
        make.centerY.equalTo(_adderssLab);
        make.height.equalTo(@(17));
        make.width.equalTo(@(14));
    }];

    //底部
    [_companyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bottomView).offset(AUTO_MATE_WIDTH(45));
        make.top.equalTo(_bottomView).offset(5);
        make.height.equalTo(@(20));
        make.right.equalTo(_bottomView).offset(-20);
    }];
    [_logisticalLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bottomView).offset(AUTO_MATE_WIDTH(45));
        make.top.equalTo(_companyLab.bottom);
        make.height.equalTo(@(20));
        make.width.equalTo(@(150));
    }];
    [_logisticalPhoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_logisticalLab.right);
        make.right.equalTo(_bottomView).offset(-5);
        make.top.equalTo(_logisticalLab.top);
        make.height.equalTo(@(20));
    }];
}

@end
