//
//  YZGMineTableOrderCell.m
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGDetailsOrderCell.h"

@interface YZGDetailsOrderCell()
@property (nonatomic, strong) UIView *spaceView;          /**<  顶部空隙 */
@property (nonatomic, strong) UIImageView *productImg;    /**< 商品图片 */
@property (nonatomic, strong) UILabel *productNameLab;    /**< 商品名称 */
@property (nonatomic, strong) UILabel *sizeLab;          /**< 商品规格 */
@property (nonatomic, strong) UILabel *priceLab;        /**< 商品原价 */

@property (nonatomic, strong) UIButton *reimburseBtn;             /**<  退款按钮 */
@property (nonatomic, strong) UIView *lineView;     /**<  备注线 */
@property (nonatomic, strong) UIView *bottomView;    /**< 底部背景view */
@property (nonatomic, strong) UILabel *remarksLab;    /**< 备注文本 */

@end
@implementation YZGDetailsOrderCell

+ (YZGDetailsOrderCell *)mineTableViewWith:(UITableView *)tableView {
    YZGDetailsOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (!cell) {
        cell = [[YZGDetailsOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
    }
    return cell;
}

#pragma mark ************** 懒加载控件
- (UILabel *)remarksLab {
    if (!_remarksLab) {
        _remarksLab = [[UILabel alloc] init];
        _remarksLab.font = [UIFont systemFontOfSize:12];
        _remarksLab.textColor = [UIColor grayColor];
        _remarksLab.backgroundColor = [UIColor whiteColor];
        _remarksLab.text = @"备注:";
    }
    return _remarksLab;
}
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = RGB(227, 229, 230);
        
    }
    return _lineView;
}
- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = hexColor(FFFFFF);
        _bottomView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(remarkClick:)];
        [_bottomView addGestureRecognizer:tap];
    
    }
    return _bottomView;
}
- (UIButton *)reimburseBtn{
    if (!_reimburseBtn) {
        _reimburseBtn=[[UIButton alloc]init];
        [_reimburseBtn setTitle:@"申请退款" forState:UIControlStateNormal];
        [_reimburseBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _reimburseBtn.titleLabel.font = systemFont(14);//标题文字大小
        _reimburseBtn.layer.borderWidth = 0.5;
        _reimburseBtn.layer.borderColor = [UIColor grayColor].CGColor;
        _reimburseBtn.layer.cornerRadius = 2;
        _reimburseBtn.layer.masksToBounds = YES;
        _reimburseBtn.hidden = YES;
        [_reimburseBtn addTarget:self action:@selector(reimburseBtnClick:) forControlEvents:UIControlEventTouchDown];
    }

    return _reimburseBtn;
}
- (UIView *)spaceView {
    if (!_spaceView) {
        _spaceView = [[UIView alloc] init];
        _spaceView.backgroundColor = [UIColor whiteColor];
    }
    return _spaceView;
}
- (UIImageView *)productImg {
    if (!_productImg) {
        _productImg = [[UIImageView alloc] init];
        _productImg.image = [UIImage imageNamed:@"account_highlight"];
        _productImg.layer.borderWidth = 0.5;
        _productImg.layer.borderColor = RGB(227, 229, 230).CGColor;
        _productImg.backgroundColor = [UIColor whiteColor];


    }
    return _productImg;
}

- (UILabel *)productNameLab {
    if (!_productNameLab) {
        _productNameLab = [[UILabel alloc] init];
        _productNameLab.textAlignment = NSTextAlignmentLeft;
        _productNameLab.font = boldSystemFont(15);
        _productNameLab.text = @"失联飞机老地方了圣诞节发";
    }
    return _productNameLab;
}

- (UILabel *)sizeLab {
    if (!_sizeLab) {
        _sizeLab = [[UILabel alloc] init];
        _sizeLab.font = systemFont(12);
        _sizeLab.textColor = [UIColor grayColor];
        _sizeLab.textAlignment = NSTextAlignmentLeft;
        _sizeLab.text = @"规格:W:813 H:640";
    }
    return _sizeLab;
}

- (UILabel *)priceLab {
    if (!_priceLab) {
        _priceLab = [[UILabel alloc] init];
        _priceLab.font = systemFont(12);
        _priceLab.textColor = RGB(38, 66, 136);
        _priceLab.textAlignment = NSTextAlignmentLeft;
        _priceLab.text = @"7739.00元";
    }
    return _priceLab;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = RGB(246, 246, 246);
         [self.contentView addSubview:self.spaceView];
        [self.contentView addSubview:self.productImg];
        [self.contentView addSubview:self.productNameLab];
        [self.contentView addSubview:self.sizeLab];
        [self.contentView addSubview:self.priceLab];
        
        [self.contentView addSubview:self.reimburseBtn];
        
        //备注
        [self.contentView addSubview:self.bottomView];
        [self.bottomView addSubview:self.lineView];
        [self.bottomView addSubview:self.remarksLab];
        
        [self addConstraintsForCell];


    }
    return self;
}
#pragma mark ************** 备注点击
-(void)remarkClick:(UITapGestureRecognizer *)sender
{
 
    if(self.remarkBlack)
    {
        self.remarkBlack(_remarksLab.text);
    }
}
#pragma mark ************** 退款按钮被点击
- (void)reimburseBtnClick:(UIButton *)sender{
    self.reimburseBtnBlack(sender.titleLabel.text,_indexPath);
}

- (void)setIndexPath:(NSIndexPath *)indexPath{
    
    _indexPath = indexPath;
}
- (void)setModel:(YZGNextOhterDetailModel *)model{
    _model = model;
    
    YZGOrderDetailModel *detailModel = model.ezgOrderdetailsArr[_indexPath.row];
    
    //备注
    if([detailModel.remarks isEqualToString:@""] || detailModel.remarks == nil)
    {
        _remarksLab.text = @"商品备注: 无";
    }
    else
    {
       _remarksLab.text = [NSString stringWithFormat:@"商品备注: %@",detailModel.remarks];
    }
    
    
    
    //图片
    Orderdetails *productModel = detailModel.productDetail;
    NSURL *imgUrl = [NSURL URLWithString:[[productModel.path stringByAppendingString:@"@!product-list" ] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [_productImg sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"logo_del_pro"]];

    //名称
    _productNameLab.text = [NSString stringWithFormat:@"%@ %@ %@",productModel.brandName,productModel.style,productModel.productNum];
    
    if([productModel.productType isEqualToString:@"物料"])
    {
        _sizeLab.hidden = YES;
    }
    else
    {
        _sizeLab.text = [NSString stringWithFormat:@"规格:W:%@ H:%@ D:%@",productModel.specWidth,productModel.specHeight,productModel.specLength];
        _sizeLab.hidden = NO;
    }
  
    _priceLab.text = [NSString stringWithFormat:@"%.2lf 元  x %ld", detailModel.productPrice,detailModel.productQty];
    


    
    if(model.isCheckState == 1 || model.isCheckState == 2 || model.isCheckState == 3 || model.isCheckState == 4)
    {
        self.reimburseBtn.hidden = NO;
        if(model.isCheckState == 1 || model.isCheckState == 2)//当状态为待发货时
        {
            [self.reimburseBtn setTitle:@"申请退款" forState:0];
        }
        if(model.isCheckState == 3 || model.isCheckState == 4)//当状态为待收货状态,已完成
        {
            [self.reimburseBtn setTitle:@"申请售后" forState:0];
        }
        
        //存在的情况
        if(detailModel.ezgRefund)
        {
            YZGEzgRefund *ezgRefund = detailModel.ezgRefund;
            if([ezgRefund.status isEqualToString:@"1"])
            {
                [self.reimburseBtn setTitle:@"退款中" forState:0];
            }
            else if([ezgRefund.status isEqualToString:@"2"])
            {
                 [self.reimburseBtn setTitle:@"退款关闭" forState:0];
            }
            //基本不存在该情况
            else if([ezgRefund.status isEqualToString:@"3"])
            {
                [self.reimburseBtn setTitle:@"退款失败" forState:0];
            }
            else if([ezgRefund.status isEqualToString:@"4"])
            {
                [self.reimburseBtn setTitle:@"退款成功" forState:0];
            }
        }
        
       
    }
 
    //已取消
    else if(model.isCheckState == 5  )
    {
        //有某件商品已经退款成功
        if( detailModel.orderDetailNode == 2)
        {
            self.reimburseBtn.hidden = NO;
            [self.reimburseBtn setTitle:@"退款成功" forState:0];
        }
        else
        {
           self.reimburseBtn.hidden = YES;
        }
    }
    
  
    //判断是否为协商支付
    if(model.isPayType == 1)//1-协商支付
    {
        self.reimburseBtn.hidden = YES;
    }
    
    //9月5号前隐藏 1473087600 为  9月5号11 点的时间戳
    NSInteger time = model.addDate;
    if(time/1000 < 1473087600)
    {
        self.reimburseBtn.hidden = YES;
    }

}
#pragma mark ************** 添加约束
- (void)addConstraintsForCell
{
    [_spaceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.contentView);
        make.height.equalTo(@(5));
    }];
    
    [_productImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_spaceView.bottom).offset(10);
        make.left.equalTo(self.contentView).offset(20);
        make.width.height.equalTo(@(60));
    }];
    [_productNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_productImg.top).offset(5);
        make.left.equalTo(_productImg.right).offset(10);
        make.height.equalTo(@(15));
        make.right.equalTo(self.contentView).offset(-5);
    }];
    [_sizeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_productNameLab.bottom).offset(8);
        make.left.equalTo(_productImg.right).offset(10);
        make.height.equalTo(@(10));
        make.right.equalTo(self.contentView).offset(-5);
    }];
    [_priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_sizeLab.bottom).offset(8);
        make.left.equalTo(_productImg.right).offset(10);
        make.height.equalTo(@(10));
        make.right.equalTo(self.contentView).offset(-5);
    }];
    
    [_reimburseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_priceLab.top).offset(-5);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.equalTo(@(20));
        make.width.equalTo(@(60));
    }];
    
    //备注
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
        make.height.equalTo(@(40));
    }];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bottomView);
        make.left.right.equalTo(_bottomView);
        make.height.equalTo(@(0.5));
    }];
    [_remarksLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lineView.bottom);
        make.left.equalTo(_productImg);
        make.right.equalTo(_bottomView).offset(-10);
        make.bottom.equalTo(_bottomView);
    }];
    

}

@end
