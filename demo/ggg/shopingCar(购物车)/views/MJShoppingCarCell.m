//
//  MyShoppingCarCell.m
//  Masonry
//
//  Created by LXY on 16/5/13.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "MJShoppingCarCell.h"

@interface MJShoppingCarCell ()<UITextFieldDelegate>
{
    NSInteger amount;//产品数量
    NSInteger stock;//库存
    
}
@property (nonatomic, strong) UIView *lineView;      /**<  顶部线 */
@property (nonatomic, strong) UIView *topBgView;    /**< 图片背景view */
@property (nonatomic, strong) UIView *centerBgView;    /**< 库存背景view */
@property (nonatomic, strong) UIView *bottomView;    /**< 底部背景view */

@property (nonatomic, strong) UIButton *remarksBtn;    /**< 备注按钮 */
@property (nonatomic, strong) UILabel *remarksLab;    /**< 备注文本 */
@end

@implementation MJShoppingCarCell

#pragma mark ************** 懒加载
- (UIButton *)remarksBtn {
    if (!_remarksBtn) {
        _remarksBtn = [[UIButton alloc]init];
        [_remarksBtn setImage:[UIImage imageNamed:@"icon_edit"] forState:UIControlStateNormal];
        [_remarksBtn addTarget:self action:@selector(remarksBtnClick:) forControlEvents:UIControlEventTouchDown];
    }
    return _remarksBtn;
}
- (UILabel *)remarksLab {
    if (!_remarksLab) {
        _remarksLab = [[UILabel alloc] init];
        _remarksLab.font = [UIFont systemFontOfSize:14];
        _remarksLab.numberOfLines = 0;
        _remarksLab.textColor = [UIColor grayColor];
        _remarksLab.backgroundColor = [UIColor whiteColor];
        _remarksLab.text = @"";
    }
    return _remarksLab;
}
- (UIView *)topBgView {
    if (!_topBgView) {
        _topBgView = [[UIView alloc] init];
        _topBgView.backgroundColor = hexColor(FFFFFF);
        _topBgView.layer.borderWidth = 0.5;
        _topBgView.layer.borderColor = RGB(227, 229, 230).CGColor;
    }
    return _topBgView;
}
- (UIView *)centerBgView {
    if (!_centerBgView) {
        _centerBgView = [[UIView alloc] init];
        _centerBgView.backgroundColor = hexColor(FFFFFF);
        _centerBgView.layer.borderWidth = 0.5;
        _centerBgView.layer.borderColor = RGB(227, 229, 230).CGColor;
        
    }
    return _centerBgView;
}
- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = hexColor(FFFFFF);
        _bottomView.layer.borderWidth = 0.5;
        _bottomView.layer.borderColor = RGB(227, 229, 230).CGColor;
        _bottomView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bottomClick:)];
        [_bottomView addGestureRecognizer:tap];
    }
    return _bottomView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = RGB(227, 229, 230);
        
    }
    return _lineView;
}
- (UIButton *)selectBtn {
    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectBtn setImage:[UIImage imageNamed:@"Unselected"] forState:UIControlStateNormal];
        [_selectBtn setImage:[UIImage imageNamed:@"Selected"] forState:UIControlStateSelected];
        [_selectBtn addTarget:self action:@selector(selectBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _selectBtn.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
    }
    return _selectBtn;
}

- (UIImageView *)productImg {
    if (!_productImg) {
        _productImg = [[UIImageView alloc] init];
        [_productImg setContentMode:UIViewContentModeScaleAspectFit];
        _productImg.layer.borderWidth = 0.5;
        _productImg.layer.borderColor = RGB(227, 229, 230).CGColor;
    }
    return _productImg;
}

- (UILabel *)productNameLab {
    if (!_productNameLab) {
        _productNameLab = [[UILabel alloc] init];
        _productNameLab.font = systemFont(16);
    }
    return _productNameLab;
}

- (UILabel *)sizeLab {
    if (!_sizeLab) {
        _sizeLab = [[UILabel alloc] init];
        _sizeLab.font = systemFont(12);
        _sizeLab.textColor = hexColor(949494);
        _sizeLab.numberOfLines = 0;
    }
    return _sizeLab;
}

- (UILabel *)costPriceLab {
    if (!_costPriceLab) {
        _costPriceLab = [[UILabel alloc] init];
        _costPriceLab.font = systemFont(12);
        _costPriceLab.textColor = RGB(255,0,0);
        _costPriceLab.textAlignment = NSTextAlignmentLeft;
        _costPriceLab.text = @"333.0元";
    }
    return _costPriceLab;
}
- (UILabel *)originalPriceLab {
    if (!_originalPriceLab) {
        _originalPriceLab = [[UILabel alloc] init];
        _originalPriceLab.font = systemFont(12);
        _originalPriceLab.textColor = hexColor(949494);
        _originalPriceLab.textAlignment = NSTextAlignmentLeft;
        _originalPriceLab.text = @"零售价:222.0元";
    }
    return _originalPriceLab;
}


- (UILabel *)stockLab {
    if (!_stockLab) {
        _stockLab = [[UILabel alloc] init];
        _stockLab.font = systemFont(12);
        _stockLab.textColor = [UIColor grayColor];
        _stockLab.textAlignment = NSTextAlignmentRight;
    }
    return _stockLab;
}


- (UIView *)changeQty {
    if (!_changeQty) {
        _changeQty = [[UIView alloc] init];
        _changeQty.layer.borderColor = hexColor(C8C7CC).CGColor;
        _changeQty.layer.borderWidth = 1;
        _changeQty.backgroundColor = [UIColor grayColor];
    }
    return _changeQty;
}


- (UIButton *)addButton {
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addButton setBackgroundImage:[UIImage imageNamed:@"product_detail_add_normal"] forState:UIControlStateNormal];
        [_addButton setBackgroundImage:[UIImage imageNamed:@"product_detail_add_no"] forState:UIControlStateDisabled];
        [_addButton addTarget:self action:@selector(addBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}

- (UIButton *)subtractButton {
    if (!_subtractButton) {
        _subtractButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_subtractButton setBackgroundImage:[UIImage imageNamed:@"product_detail_sub_normal"] forState:UIControlStateNormal];
        [_subtractButton setBackgroundImage:[UIImage imageNamed:@"product_detail_sub_no"] forState:UIControlStateDisabled];
        [_subtractButton addTarget:self action:@selector(subtractBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _subtractButton;
}
- (UITextField *)countTextField {
    if (!_countTextField) {
        _countTextField = [[UITextField alloc] init];
        _countTextField.textAlignment = NSTextAlignmentCenter;
        _countTextField.keyboardType = UIKeyboardTypeNumberPad;
        _countTextField.font = [UIFont systemFontOfSize:14];
        _countTextField.backgroundColor = [UIColor whiteColor];
        _countTextField.text = @"1";
        _countTextField.delegate = self;
        
    }
    return _countTextField;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = hexColor(FAFAFA);
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self addSubViewsForCarCell];
        [self addConstraintsForCarCell];

    }
    return self;
}
- (void)setIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
}
#pragma mark ************** 更新数据
- (void)setModel:(Products *)model {
    
    _model = model;
    
    ProductDetail *productDetailModel =  model.productDetail;
    
    //图片
     NSString *productPicUri = [[productDetailModel.path stringByAppendingString:@"@!product-list" ] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];//转码
    [_productImg sd_setImageWithURL:[NSURL URLWithString:productPicUri] placeholderImage:[UIImage imageNamed:@"logo_del_pro"]];
   
    _productNameLab.text = [NSString stringWithFormat:@"%@%@%@",productDetailModel.brandName,productDetailModel.style,productDetailModel.productType];

    NSString *specWidth = productDetailModel.specWidth ? productDetailModel.specWidth : @"0";
    NSString *specHeight = productDetailModel.specHeight ? productDetailModel.specHeight : @"0";
    NSString *specdd = productDetailModel.specLength ? productDetailModel.specLength : @"0";
    
    if([productDetailModel.productType isEqualToString:@"物料"])
    {
        _sizeLab.hidden = YES;
    }
    else
    {
        _sizeLab.text = [NSString stringWithFormat:@"规格: W:%@ H:%@ D:%@",specWidth,specHeight,specdd];
        _sizeLab.hidden = NO;
    }
    
    //商品备注
    NSString *remarksString = model.productDesc? [NSString stringWithFormat:@"商品备注: %@",model.productDesc] : @"商品备注:";
    _remarksLab.text = remarksString;
    
    _costPriceLab.text = [NSString stringWithFormat:@"批发价:%.2f元",productDetailModel.dealerPurchasePrice];
    
    _originalPriceLab.text = [NSString stringWithFormat:@"零售价:%.2f元",productDetailModel.productPrice];
    
    _countTextField.text = [NSString stringWithFormat:@"%ld",model.productQty];

    if (productDetailModel.stock != 0)//库存

    {
        _stockLab.text = [NSString stringWithFormat:@"库存: %ld",productDetailModel.stock];
        _stockLab.textColor = [UIColor grayColor];
    }
    else
    {
        _stockLab.text = @"库存不足";
        _stockLab.textColor = [UIColor redColor];
    }
    
    //是否选中
    if (model.select)
        
    {
        _selectBtn.selected = YES;
    }
    else
    {
        _selectBtn.selected = NO;
    }
    
}

#pragma mark ************** 备注点击事件
- (void)remarksBtnClick:(UIButton *)sender
{
    
    if(self.delegate && [self.delegate conformsToProtocol:@protocol(CellDelegate)]){
        
        [self.delegate RemarksBtnAction:_indexPath RemarkText:self.remarksLab.text];
    }
}
#pragma mark ************** 选中按钮
- (void)selectBtnAction:(UIButton *)sender
{
    sender.selected = !sender.selected;//修改选中状态
    
    if (self.delegate && [self.delegate conformsToProtocol:@protocol(CellDelegate)])
    {
        [self.delegate CellSelectBtnAction:sender.selected IndexPath:_indexPath];
    }
}
#pragma mark ************** 数量增加
- (void)addBtnAction:(UIButton *)sender{
 
    NSInteger amountString = _model.productQty;//购买量
    ProductDetail *productDetailModel =  _model.productDetail;
    NSInteger stockString = productDetailModel.stock;//库存
    
    amountString++;
    
    if(amountString > stockString)
    {
         amountString = stockString;
        [SVProgressHUD showErrorWithStatus:@"库存不足"];
    }
    else
    {
        if(self.delegate && [self.delegate conformsToProtocol:@protocol(CellDelegate)])
        {
            [self.delegate CellAddBtnAction:amountString IndexPath:_indexPath ];//加减都一样
        }
    }
  

    
}
#pragma mark ************** 数量减少
- (void)subtractBtnAction:(UIButton *)sender{
    
    NSInteger amountString = _model.productQty;//购买量
    
    amountString--;
    if(amountString <= 0)
    {
         amountString = 1;
        [SVProgressHUD showErrorWithStatus:@"至少选择1件商品"];
    }
    else
    {
        //数量增加代理方法
        if(self.delegate && [self.delegate conformsToProtocol:@protocol(CellDelegate)]){
            [self.delegate CellAddBtnAction:amountString IndexPath:_indexPath ];//加减都一样
            
        }
    }
   

}
#pragma mark ************** 文本框代理
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    ProductDetail *productDetailModel =  _model.productDetail;
    NSInteger stockString = productDetailModel.stock;//库存
    
     NSInteger amountString = [textField.text integerValue];
    if(amountString > stockString)
    {
        amountString = stockString;
        
    }
    else if(amountString <= 0)
    {
        
        amountString = 1;
        
    }
    //代理回调
    if(self.delegate && [self.delegate conformsToProtocol:@protocol(CellDelegate)])
    {
        [self.delegate CellCountTfAction:amountString IndexPath:_indexPath];
    }

}
#pragma mark ************** 备注背景
-(void)bottomClick:(UITapGestureRecognizer *)sender
{
    if(self.delegate && [self.delegate conformsToProtocol:@protocol(CellDelegate)]){
        
        [self.delegate RemarksBtnAction:_indexPath RemarkText:self.remarksLab.text];
    }
}
#pragma mark ************** 加载视图
- (void)addSubViewsForCarCell
{
    
    [self.contentView addSubview:self.topBgView];
    [self.contentView addSubview:self.centerBgView];
    [self.contentView addSubview:self.bottomView];
    
    //顶部
    [self.topBgView addSubview:self.selectBtn];
    [self.topBgView addSubview:self.productImg];
    [self.topBgView addSubview:self.productNameLab];
    [self.topBgView addSubview:self.sizeLab];
    [self.topBgView addSubview:self.costPriceLab];
    [self.topBgView addSubview:self.originalPriceLab];
    
    //中部
    [self.centerBgView addSubview:self.changeQty];
    [self.changeQty addSubview:self.addButton];
    [self.changeQty addSubview:self.subtractButton];
    [self.changeQty addSubview:self.countTextField];
    [self.centerBgView addSubview:self.stockLab];
    //尾部 备注
    [self.bottomView addSubview:self.remarksBtn];
    [self.bottomView addSubview:self.remarksLab];
    

}
#pragma mark ************** 添加约束
- (void)addConstraintsForCarCell
{
    
    [_topBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
        make.height.equalTo(@(100));
    }];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topBgView.bottom).offset(-0.5);
        make.left.right.equalTo(self.contentView);
        make.height.equalTo(@(41));
    }];
    [_centerBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bottomView.bottom).offset(-0.5);
        make.left.right.equalTo(self.contentView);
        make.height.equalTo(@(40.5));
    }];
   
    
    //顶部
    [_selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topBgView).offset(10);
        make.height.width.equalTo(@35);
        make.centerY.equalTo(_topBgView);
    }];
    [_productImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_selectBtn.mas_right).offset(8);
        make.centerY.equalTo(_topBgView);
        make.height.width.equalTo(@80);
    }];
    [_productNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topBgView).offset(15);
        make.height.equalTo(@15);
        make.right.equalTo(_topBgView).offset(-5);
        make.left.equalTo(_productImg.mas_right).offset(10);
    }];
    [_sizeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_productNameLab.mas_bottom).offset(6);
        make.left.equalTo(_productNameLab);
        make.height.equalTo(@15);
    }];

    [_originalPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_sizeLab.bottom).offset(6);
        make.left.equalTo(_productNameLab);
        make.height.equalTo(@15);
    }];

    [_costPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_originalPriceLab.bottom).offset(6);
        make.left.equalTo(_productNameLab);
        make.height.equalTo(@15);
    }];
    [_stockLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_changeQty);
        make.right.equalTo(_centerBgView).offset(-10);
        make.height.equalTo(@15);
    }];
    
    //中部库存
    [_changeQty mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@95);
        make.height.equalTo(@25);
        make.left.equalTo(_productNameLab);
        make.centerY.equalTo(_centerBgView);
    }];
    [_subtractButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(_changeQty);
        make.width.equalTo(@25);
    }];
    [_countTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(_changeQty);
        make.width.equalTo(@45);
        make.left.equalTo(_subtractButton.mas_right);
    }];
    [_addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(_changeQty);
        make.width.equalTo(@25);
    }];
 
    //底部
    [_remarksBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_bottomView).offset(-10);
        make.height.equalTo(@30);
        make.width.equalTo(@30);
        make.centerY.equalTo(_bottomView);
        
    }];
    [_remarksLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bottomView).offset(5);
        make.left.equalTo(_selectBtn);
        make.right.equalTo(_remarksBtn.left).offset(-5);
        make.bottom.equalTo(@(-5));
        
    }];

}




@end
