//
//  YZGMineTableHeadView.m
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGProductDetailTableHeadView.h"
#import "YZGDataManage.h"
#import "NSString+Size.h"
@interface YZGProductDetailTableHeadView ()

/*品牌标签*/
@property (nonatomic, strong) UILabel *titleLable;
/*零售价*/
@property (nonatomic, strong) UILabel *priceLable;
/*库存*/
@property (nonatomic, strong) UILabel *storeLable;
/*批发价*/
@property (nonatomic, strong) UILabel *wholePrice;
/*产品logo*/
@property (nonatomic, strong) UIImageView *logoImageview;
/*产品大图*/
@property (nonatomic, strong) UIImageView *bigImageView;
/*分割线*/
@property (nonatomic, strong) UIView *grayView;

@property (nonatomic, strong) UIView *topBgView;    /**< 图片背景view */
@property (nonatomic, strong) UIView *bottomView;    /**< 底部背景view */
@end

@implementation YZGProductDetailTableHeadView


#pragma mark ************** 懒加载控件
- (UIView *)grayView
{
    if (_grayView == nil)
    {
        _grayView = [[UIView alloc] init];
        _grayView.backgroundColor = [UIColor colorWithHexColorString:@"e4e4e4"];
    }
    return _grayView;
}
- (UILabel *)priceLable
{
    if (_priceLable == nil)
    {
        _priceLable = [[UILabel alloc] init];
        _priceLable.font = [UIFont systemFontOfSize:12];
        _priceLable.text = @"零售价：660.00元";
        _priceLable.numberOfLines = 0;
        _priceLable.textAlignment = NSTextAlignmentRight;
        _priceLable.textColor = RGB(161, 161, 161);
    }
    return _priceLable;
}
- (UILabel *)wholePrice
{
    if (_wholePrice == nil)
    {
        _wholePrice = [[UILabel alloc] init];
        _wholePrice.font = [UIFont systemFontOfSize:15];
        _wholePrice.text = @"批发价：423.00元";
        _wholePrice.numberOfLines = 0;
        _wholePrice.textAlignment = NSTextAlignmentLeft;
        _wholePrice.textColor = RGB(255, 51, 0);
    }
    return _wholePrice;
}
- (UILabel *)titleLable
{
    if (_titleLable == nil)
    {
        _titleLable = [[UILabel alloc] init];
        _titleLable.font = [UIFont systemFontOfSize:14];
        _titleLable.text = @"古窑 ● 玫瑰客厅  /高层/复式/别墅  美式风格/简约美式台灯30238-73918";
        _titleLable.textColor = RGB(51, 51, 51);
        _titleLable.numberOfLines = 0;
        _titleLable.textAlignment = NSTextAlignmentLeft;
        _titleLable.backgroundColor = [UIColor redColor];
    }
    return _titleLable;
}
- (UILabel *)storeLable
{
    if (_storeLable == nil)
    {
        _storeLable = [[UILabel alloc] init];
        _storeLable.font = [UIFont systemFontOfSize:12];
        _storeLable.text = @"库存：10 件";
        _storeLable.numberOfLines = 0;
        _storeLable.textAlignment = NSTextAlignmentCenter;
        _storeLable.backgroundColor = [UIColor lightGrayColor];
        _storeLable.textColor = RGB(255, 255, 255);
    }
    return _storeLable;
}
- (UIImageView *)logoImageview
{
    if (_logoImageview == nil)
    {
        _logoImageview = [[UIImageView alloc] init];
        _logoImageview.contentMode = UIViewContentModeScaleAspectFit;
        
    }
    return _logoImageview;
}
- (UIImageView *)bigImageView
{
    if (_bigImageView == nil)
    {
        _bigImageView = [[UIImageView alloc] init];
        _bigImageView.contentMode = UIViewContentModeScaleAspectFit;
        _bigImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tagGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bigImageDidAction)];
        [_bigImageView addGestureRecognizer:tagGesture];
    }
    return _bigImageView;
}
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

    }
    return _bottomView;
}
#pragma mark **************** 点击大图响应
- (void)bigImageDidAction
{
    if (self.didSelectedBigImage)
    {
        self.didSelectedBigImage();
    }
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubviewsForHeadView];
        [self addConstraintsForHeadView];
        
    }
    return self;
}
- (void)setModel:(YZGProductDetailModel *)model
{
    _model = model;
    
    [self.bigImageView sd_setImageWithURL:[NSURL URLWithString:[model.path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"logo_del_pro"] options:SDWebImageRetryFailed ];
    [self.logoImageview sd_setImageWithURL:[NSURL URLWithString:[model.logoPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"logo_del_pro"] options:SDWebImageLowPriority | SDWebImageRetryFailed];
  
    self.wholePrice.text = [NSString stringWithFormat:@"批发：￥%0.2f 元",model.dealerPurchasePrice.floatValue];
    self.priceLable.text = [NSString stringWithFormat:@"零售：￥%0.2f 元",model.productPrice.floatValue];
    
    
    //标题高度
    NSString *titleString = [NSString stringWithFormat:@"%@  %@  %@ %@ %@",model.brandName,model.applicableRegion,model.styleLabel,model.productType,model.productNum];
    CGFloat titleHeight = [YZGDataManage getLabelHeightWithText:titleString LabWidth:_titleLable.frame.size.width LabFontSize:14];
    self.titleLable.text = titleString;

    [_titleLable mas_updateConstraints:^(MASConstraintMaker *make){  //更新约束
        make.height.equalTo(@(titleHeight));
    }];
    
    //库存宽度
    NSString *storeString = [NSString stringWithFormat:@"库存：%zd 件",model.stock.integerValue];
    
    CGFloat storeWidth =[storeString sizeWithAttributes:@{NSFontAttributeName:_storeLable.font}].width + 20;
    
    self.storeLable.text = storeString;
    NSLog(@"----%lf",storeWidth);
    NSLog(@"----%lf",_titleLable.frame.size.width);

    [_storeLable mas_updateConstraints:^(MASConstraintMaker *make){  //更新约束
        make.width.equalTo(@(storeWidth));
    }];
    
}


#pragma mark ************** 添加子控件
- (void)addSubviewsForHeadView
{
    //顶部
    [self addSubview:self.topBgView];
    [self.topBgView addSubview:self.bigImageView];
    [self.topBgView addSubview:self.logoImageview];
    [self.topBgView addSubview:self.storeLable];
    [self.topBgView addSubview:self.grayView];

    //尾部
    [self addSubview:self.bottomView];
    [self.bottomView addSubview:self.titleLable];
    [self.bottomView addSubview:self.priceLable];
    [self.bottomView addSubview:self.wholePrice];
   
}
#pragma mark ************** 添加约束
- (void)addConstraintsForHeadView
{
    [_topBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.equalTo(@(SCREEN_WIDTH));
    }];
   
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topBgView.bottom);
        make.left.right.equalTo(self);
        make.height.equalTo(@(80));
    }];
    //顶部
    [_bigImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_topBgView);
        make.width.height.equalTo(@260);
    }];
    [_logoImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(_topBgView).offset(5);
        make.height.width.equalTo(@(60));
    }];
    [_storeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(_topBgView);
        make.height.equalTo(@20);
        make.width.equalTo(@100);
    }];
    [_grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(_topBgView);
        make.height.equalTo(@(0.5));
    }];
    
    //尾部
    [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(_bottomView).offset(10);
        make.right.equalTo(_bottomView).offset(-10);
        make.height.equalTo(@50);
    }];
    [_priceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_bottomView);
        make.right.equalTo(_bottomView).offset(-10);
        make.height.equalTo(@30);
        make.width.equalTo(@((SCREEN_WIDTH-20)/2));
    }];
    [_wholePrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_bottomView);
        make.left.equalTo(_bottomView).offset(10);
        make.height.equalTo(@30);
        make.width.equalTo(_priceLable);
    }];
    
    

    
}

@end
