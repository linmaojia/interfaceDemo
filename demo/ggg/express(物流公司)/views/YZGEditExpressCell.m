//
//  YZGMineTableOrderCell.m
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGEditExpressCell.h"
#import "YZGAddressModel.h"
@interface YZGEditExpressCell()

@property (nonatomic, strong) UIView *topBgView;    /**< 顶部背景view */
@property (nonatomic, strong) UIView *bottomView;    /**< 底部背景view */
@property (nonatomic, strong) UILabel *nameLab;        /**< 公式名 */
@property (nonatomic, strong) UILabel *phoneLab;       /**< 电话号码 */
@property (nonatomic, strong) UIView *lineView;       /**< 线 */
@property (nonatomic, strong) UIButton *defaultBtn;    /**< 默认按钮 */
@property (nonatomic, strong) UIButton *deleteBtn;    /**< 删除按钮 */
@property (nonatomic, strong) UIButton *editBtn;     /**< 编辑按钮 */



@end
@implementation YZGEditExpressCell


#pragma mark ************** 懒加载控件
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
    }
    return _bottomView;
}
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
        
        
        [self addSubViewsForEditExpressCell];
        [self addConstraintsForEditExpressCell];

      

    }
    return self;
}
- (void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
}


- (void)setModel:(YZGExpressModel *)model{
    
    _model = model;
    self.nameLab.text = [NSString stringWithFormat:@"%@",model.logisticsName];
    if([model.logisticsPhone isEqualToString:@""])
    {
        self.phoneLab.text = @"无联系电话";
    }
    else
    {
        self.phoneLab.text = model.logisticsPhone;

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
    
   
}
#pragma mark ************** 添加视图
- (void)addSubViewsForEditExpressCell
{
    [self.contentView addSubview:self.topBgView];
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.bottomView];
    
    [self.topBgView addSubview:self.nameLab];
    [self.topBgView addSubview:self.phoneLab];
    
    [self.bottomView addSubview:self.defaultBtn];
    [self.bottomView addSubview:self.deleteBtn];
    [self.bottomView addSubview:self.editBtn];

    
    
    
}
#pragma mark ************** 添加约束
- (void)addConstraintsForEditExpressCell
{
    
    [_topBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
        make.height.equalTo(@(50));
    }];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_topBgView.bottom);
        make.left.right.equalTo(self.contentView);
        make.height.equalTo(@(0.5));
    }];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lineView.bottom);
        make.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
    }];
    
    //顶部
    [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topBgView).offset(20);
        make.centerY.equalTo(_topBgView);
        make.width.equalTo(@(100));
        make.height.equalTo(@(30));
    }];
    [_phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_topBgView);
        make.left.equalTo(_nameLab.right);
        make.right.equalTo(_topBgView).offset(-10);
        make.height.equalTo(@(30));
    }];

    //底部
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
}

@end
