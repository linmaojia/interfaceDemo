//
//  YZGMineTableOrderCell.m
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGUserAdderssSettingCell.h"
#import "YZGAddressModel.h"
@interface YZGUserAdderssSettingCell()


@property (nonatomic, strong) UILabel *nameLab;        /**< 收货人 */
@property (nonatomic, strong) UILabel *phoneLab;       /**< 电话号码 */
@property (nonatomic, strong) UILabel *addressLab;     /**< 收货地址 */
@property (nonatomic, strong) UIView *lineView;       /**< 线 */
@property (nonatomic, strong) UIButton *defaultBtn;    /**< 默认按钮 */
@property (nonatomic, strong) UIButton *deleteBtn;    /**< 删除按钮 */
@property (nonatomic, strong) UIButton *editBtn;     /**< 编辑按钮 */

@property (nonatomic, strong) UIImageView *bottomImg;    /**< 底部彩色图片 */
@property (nonatomic, strong) UIImageView *choosesImg;    /**< 选中打钩图片 */
@property (nonatomic, strong) UIView *topBgView;    /**< 图片背景view */
@property (nonatomic, strong) UIView *bottomView;    /**< 底部背景view */

@end
@implementation YZGUserAdderssSettingCell

- (UIView *)topBgView {
    if (!_topBgView) {
        _topBgView = [[UIView alloc] init];
        _topBgView.backgroundColor = hexColor(FFFFFF);
    }
    return _topBgView;
}
- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = hexColor(FFFFFF);
        _bottomView.layer.borderWidth = 0.5;
        _bottomView.layer.borderColor = RGB(227, 229, 230).CGColor;
        _bottomView.userInteractionEnabled = YES;
    }
    return _bottomView;
}
#pragma mark ************** 懒加载控件
- (UIButton *)defaultBtn {
    if (!_defaultBtn) {
        _defaultBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_defaultBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _defaultBtn.backgroundColor = mainColor;
        _defaultBtn.titleLabel.font = systemFont(15);;
        [_defaultBtn setTitle:@"默认地址" forState:0];
        [_defaultBtn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _defaultBtn;
}
- (UIButton *)deleteBtn {
    if (!_deleteBtn) {
        _deleteBtn =[[UIButton alloc]init];
        [_deleteBtn setTitleColor:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0] forState:UIControlStateNormal];
        _deleteBtn.titleLabel.font = systemFont(15);
        [_deleteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _deleteBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);//标题居中左偏移15
        [_deleteBtn setImage:[UIImage imageNamed:@"icon_del"] forState:UIControlStateNormal];
        [_deleteBtn setTitle:@"删除" forState:0];
        [_deleteBtn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}

- (UIButton *)editBtn {
    if (!_editBtn) {
        
        _editBtn =[[UIButton alloc]init];
        [_editBtn setTitleColor:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0] forState:UIControlStateNormal];
        [_editBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _editBtn.titleLabel.font = systemFont(15);;
        _editBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);//标题居中左偏移15
        [_editBtn setImage:[UIImage imageNamed:@"icon_edit"] forState:UIControlStateNormal];
        [_editBtn setTitle:@"编辑" forState:0];
        [_editBtn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _editBtn;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = RGBA(0, 0, 0, 0.3);
        
    }
    return _lineView;
}

- (UILabel *)nameLab {
    if (!_nameLab) {
        _nameLab = [[UILabel alloc] init];
        _nameLab.textColor = [UIColor blackColor];
        _nameLab.text = @"收货人";
        _nameLab.textAlignment = NSTextAlignmentLeft;
        _nameLab.font = systemFont(15);
        
    }
    return _nameLab;
}
- (UILabel *)phoneLab {
    if (!_phoneLab) {
        _phoneLab = [[UILabel alloc] init];
        _phoneLab.textColor = [UIColor blackColor];
        _phoneLab.text = @"15819953627";
        _phoneLab.textAlignment = NSTextAlignmentLeft;
        _phoneLab.font = systemFont(15);
    }
    return _phoneLab;
}
- (UILabel *)addressLab {
    if (!_addressLab) {
        _addressLab = [[UILabel alloc] init];
        _addressLab.textColor = [UIColor blackColor];
        _addressLab.numberOfLines = 0;
        _addressLab.text = @"河北胜多负少就发上来的积分是雷锋精神洛杉矶福克斯的减肥了来上课就付款塑料袋";
        _addressLab.textAlignment = NSTextAlignmentLeft;
        _addressLab.font = systemFont(15);
        
    }
    return _addressLab;
}
- (UIImageView *)bottomImg {
    if (!_bottomImg) {
        _bottomImg = [[UIImageView alloc] init];
        _bottomImg.backgroundColor = [UIColor yellowColor];
        _bottomImg.hidden = YES;
        _bottomImg.image = [UIImage imageNamed:@"caiLine"];
        
    }
    return _bottomImg;
}
- (UIImageView *)choosesImg {
    if (!_choosesImg) {
        _choosesImg = [[UIImageView alloc] init];
        _choosesImg.hidden = YES;
        _choosesImg.image = [UIImage imageNamed:@"del_address"];
    }
    return _choosesImg;
}
#pragma mark ************** 按钮被点击(传递按钮的标题)
- (void)BtnClick:(UIButton *)sender {
    self.AdderssBtnClick(sender.titleLabel.text,_indexPath);
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = RGBA(0, 0, 0, 0.3).CGColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubviewsForAdderssSetting];
        [self addConstraintsForAdderssSetting];
    }
    return self;
}
- (void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
}

- (void)setIsShowColourPicture:(BOOL )isShowColourPicture{
    
    if(isShowColourPicture)
    {
        self.choosesImg.hidden = NO;
        self.bottomImg.hidden = NO;
        
        //更新约束
        [_nameLab mas_updateConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(_topBgView).offset(35);
            
        }];
    }
    else
    {
        self.choosesImg.hidden = YES;
        self.bottomImg.hidden = YES;
        
        //更新约束
        [_nameLab mas_updateConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(_topBgView).offset(20);
            
        }];
    }

   
}

- (void)setModel:(YZGAddressModel *)model{
    
    _model = model;
    self.nameLab.text = [NSString stringWithFormat:@"%@",model.deliverName];
    self.phoneLab.text = model.deliverPhone;
    if(model.deliverAddress != nil)
    {
        self.addressLab.text = [NSString stringWithFormat:@"%@%@",model.deliverPCAS, model.deliverAddress];//deliverPCAS

    }
    else
    {
        self.addressLab.text = [NSString stringWithFormat:@"%@",model.deliverPCAS];//
    }
    
    //设置按钮样色
    if([model.isDefault isEqualToString:@"1"])
    {
       [_defaultBtn setTitle:@"默认地址" forState:0];
        _defaultBtn.backgroundColor = mainColor;
    }
    else if([model.isDefault isEqualToString:@"0"])
    {
        
       [_defaultBtn setTitle:@"设为默认" forState:0];
        _defaultBtn.backgroundColor = [UIColor grayColor];

    }
    
    //隐藏设置按钮
    if(self.isChooseAdderss)
    {
        if([model.isDefault isEqualToString:@"0"])
        {
           _defaultBtn.hidden = YES;
        }
        else if([model.isDefault isEqualToString:@"1"])
        {
           _defaultBtn.hidden = NO;
        }
       
    }
   
}



#pragma mark ************** 添加子控件
- (void)addSubviewsForAdderssSetting
{
    [self.contentView addSubview:self.topBgView];
    [self.contentView addSubview:self.bottomView];
    //顶部
    [self.topBgView addSubview:self.nameLab];
    [self.topBgView addSubview:self.phoneLab];
    [self.topBgView addSubview:self.addressLab];
    [self.topBgView addSubview:self.lineView];
    [self.topBgView addSubview:self.choosesImg];
    //尾部
    [self.bottomView addSubview:self.defaultBtn];
    [self.bottomView addSubview:self.editBtn];
    [self.bottomView addSubview:self.deleteBtn];
    [self.bottomView addSubview:self.bottomImg];

}
#pragma mark ************** 添加约束
- (void)addConstraintsForAdderssSetting
{
    [_topBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
        make.height.equalTo(@(100));
    }];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topBgView.bottom);
        make.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
    }];
    
    //顶部
    [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topBgView).offset(20);
        make.top.equalTo(_topBgView).offset(15);
        make.width.equalTo(@(100));
        make.height.equalTo(@(30));
    }];
    [_phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLab.top);
        make.left.equalTo(_nameLab.right);
        make.width.equalTo(@(100));
        make.height.equalTo(@(30));
    }];
    [_addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLab.bottom);
        make.left.equalTo(_nameLab.left);
        make.right.equalTo(_topBgView).offset(-10);
        make.bottom.equalTo(_topBgView).offset(-5);
    }];
    [_choosesImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topBgView).offset(10);
        make.centerY.equalTo(_topBgView);
        make.height.width.equalTo(@(15));
    }];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_topBgView);
        make.left.right.equalTo(_topBgView);
        make.height.equalTo(@(0.5));
    }];
    
    //尾部
    [_defaultBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_bottomView);
        make.left.equalTo(_bottomView).offset(10);
        make.height.equalTo(@(25));
        make.width.equalTo(@(70));
    }];
    [_deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_bottomView);
        make.right.equalTo(_bottomView).offset(-5);
        make.height.equalTo(@(30));
        make.width.equalTo(@(75));
    }];
    [_editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_bottomView);
        make.right.equalTo(_deleteBtn.left);
        make.height.equalTo(@(30));
        make.width.equalTo(@(75));
    }];
    
    [_bottomImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_bottomView);
        make.bottom.equalTo(_bottomView);
        make.height.equalTo(@(3));
    }];
}

@end
