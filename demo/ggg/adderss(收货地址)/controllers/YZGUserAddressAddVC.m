//
//  YZGUserSettingViewController.m
//  yzg
//
//  Created by LXY on 16/6/2.
//  Copyright © 2016年 AVGD. All rights reserved.

#import "YZGUserAddressAddVC.h"
#import "JKTextField.h"
#import "JKPlaceholderTextView.h"
#import "YZGAdderssPickerView.h"
#import "SVHTTPClient+AddReceivingAddress.h"
#import "SVHTTPClient+EditReceivingAddress.h"
static float const TEXT_HEIGHT = 50;  /**< 文本框高度 */
@interface YZGUserAddressAddVC ()
{
    
    BOOL isEdit;    /**< 是否编辑状态 */
}

@property(nonatomic, strong)UIButton *saveButton;   /**< 保存 */
@property (nonatomic, strong)UIScrollView *scroll;    /**< Scrollow视图 */
@property(nonatomic, strong) JKTextField *companyTF;   /** 公司名称 */
@property(nonatomic, strong) JKTextField *nameTF;   /** 姓名 */
@property(nonatomic, strong) JKTextField *phoneTF;   /** 联系电话 */
@property(nonatomic, strong) UIView *areaView;   /** 所在地区view */
@property(nonatomic, strong) UILabel *areaTF;     /** 所在地区 */
@property(nonatomic, strong) UILabel *areaTextTF;     /** 所在地区文本 */

@property (nonatomic, strong) UIImageView *bracketImg;    /**< 右边尖括号图片 */
@property(nonatomic, strong) UIView *detailsView;   /** 详细地区view */
@property(nonatomic, strong) UILabel *detailsLab;
@property (nonatomic, strong) JKPlaceholderTextView *addressTextView; /**< 详细地址textFied */
@property (nonatomic, strong) NSMutableDictionary *textDic;             /**< 记录输入文本 */
@property (strong, nonatomic) NSArray *cityArray;            /**< 城市列表 */

@end

@implementation YZGUserAddressAddVC

#pragma mark ************** 懒加载控件
- (UILabel *)areaTextTF {
    if (!_areaTextTF) {
        _areaTextTF = [[UILabel alloc] init];
        _areaTextTF.textColor = [UIColor blackColor];
        _areaTextTF.textAlignment = NSTextAlignmentLeft;
        _areaTextTF.font = [UIFont systemFontOfSize:14];
        _areaTextTF.text = @"";
    }
    return _areaTextTF;
}
- (NSMutableDictionary *)textDic {
    if (!_textDic) {
        _textDic = [NSMutableDictionary dictionary];
    }
    return _textDic;
}
- (NSArray *)cityArray
{
    if(!_cityArray)
    {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"];
        NSDictionary *dictionry = [NSDictionary dictionaryWithContentsOfFile:plistPath];
        NSArray *array = dictionry[@"cityList"];
        _cityArray = [NSArray arrayWithArray:array];
    }
    return _cityArray;
}
- (UILabel *)areaTF {
    if (!_areaTF) {
        _areaTF = [[UILabel alloc] init];
        _areaTF.textColor = [UIColor blackColor];
        _areaTF.textAlignment = NSTextAlignmentLeft;
        _areaTF.font = [UIFont systemFontOfSize:14];
        _areaTF.text = @"  所在地区:";
    }
    return _areaTF;
}
- (UILabel *)detailsLab {
    if (!_detailsLab) {
        _detailsLab = [[UILabel alloc] init];
        _detailsLab.textColor = [UIColor blackColor];
        _detailsLab.textAlignment = NSTextAlignmentLeft;
        _detailsLab.font = [UIFont systemFontOfSize:14];
        _detailsLab.text = @"  详细地区:";
    }
    return _detailsLab;
}
- (JKPlaceholderTextView *)addressTextView {
    if (!_addressTextView) {
        _addressTextView = [[JKPlaceholderTextView alloc] init];
        _addressTextView.backgroundColor = [UIColor whiteColor];
        _addressTextView.font = [UIFont boldSystemFontOfSize:14];
        _addressTextView.returnKeyType = UIReturnKeyDone;
        _addressTextView.placehoderTextLabelTextColor = RGB(201, 201, 201);
        //_addressTextView.placehoderText = @"街道门牌信息";
        
    }
    return _addressTextView;
}
- (UIImageView *)bracketImg {
    if (!_bracketImg) {
        _bracketImg = [[UIImageView alloc] init];
        _bracketImg.image = [UIImage imageNamed:@"right_back"];
    }
    return _bracketImg;
}
- (UIView *)areaView {
    if (!_areaView) {
        _areaView = [[UIView alloc] init];
        _areaView.backgroundColor = [UIColor whiteColor];
        _areaView.layer.borderWidth = 0.5;
        _areaView.layer.borderColor = RGB(227, 229, 230).CGColor;
        _areaView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(areaViewClick:)];
        [_areaView addGestureRecognizer:tap];
    }
    return _areaView;
}
- (UIView *)detailsView {
    if (!_detailsView) {
        _detailsView = [[UIView alloc] init];
        _detailsView.backgroundColor = [UIColor whiteColor];
        _detailsView.layer.borderWidth = 0.5;
        _detailsView.layer.borderColor = RGB(227, 229, 230).CGColor;
    }
    return _detailsView;
}
- (JKTextField *)phoneTF
{
    if(!_phoneTF)
    {
        _phoneTF = [[JKTextField alloc]init];
        _phoneTF.backgroundColor = [UIColor whiteColor];
        _phoneTF.font = [UIFont systemFontOfSize:14];
        _phoneTF.keyboardType = UIKeyboardTypeNumberPad;//设置为数字
        _phoneTF.clearButtonMode=YES;
        _phoneTF.layer.borderWidth = 0.5;
        _phoneTF.layer.borderColor = RGB(227, 229, 230).CGColor;
        //左侧文字
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, TEXT_HEIGHT)];
        label.text = @"收货人手机:";
        label.font = [UIFont systemFontOfSize:14];
        _phoneTF.leftViewMode = UITextFieldViewModeAlways;
        _phoneTF.leftView = label;
        
    }
    return _phoneTF;
}
- (JKTextField *)nameTF
{
    if(!_nameTF)
    {
        _nameTF = [[JKTextField alloc]init];
        _nameTF.backgroundColor = [UIColor whiteColor];
        _nameTF.font = [UIFont systemFontOfSize:14];
        _nameTF.clearButtonMode=YES;
        _nameTF.layer.borderWidth = 0.5;
        _nameTF.layer.borderColor = RGB(227, 229, 230).CGColor;
        //左侧文字
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, TEXT_HEIGHT)];
        label.text = @"收货人姓名:";
        label.font = [UIFont systemFontOfSize:14];
        _nameTF.leftViewMode = UITextFieldViewModeAlways;
        _nameTF.leftView = label;
        
    }
    return _nameTF;
}
- (JKTextField *)companyTF
{
    if(!_companyTF)
    {
        _companyTF = [[JKTextField alloc]init];
        _companyTF.backgroundColor = [UIColor whiteColor];
        _companyTF.font = [UIFont systemFontOfSize:14];
        _companyTF.clearButtonMode=YES;
        _companyTF.layer.borderWidth = 0.5;
        _companyTF.layer.borderColor = RGB(227, 229, 230).CGColor;
        //左侧文字
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, TEXT_HEIGHT)];
        label.text = @"别名(公司名称):";
        label.font = [UIFont systemFontOfSize:14];
        _companyTF.leftViewMode = UITextFieldViewModeAlways;
        _companyTF.leftView = label;
        
    }
    return _companyTF;
}
- (UIScrollView *)scroll{
    if(!_scroll){
        _scroll=[[UIScrollView alloc]init];
        _scroll.contentSize=CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-120);
        _scroll.scrollEnabled=YES;
        _scroll.showsHorizontalScrollIndicator=YES;
        _scroll.backgroundColor = RGB(247, 247, 247);
        _scroll.translatesAutoresizingMaskIntoConstraints=NO;
    }
    return _scroll;
}
- (UIButton *)saveButton
{
    if(!_saveButton)
    {
        _saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _saveButton.titleLabel.font = boldSystemFont(14);
        [_saveButton setTitle:@"保存并使用" forState:UIControlStateNormal];
        [_saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _saveButton.backgroundColor = mainColor;
        _saveButton.layer.cornerRadius = 3;
        [_saveButton addTarget:self action:@selector(saveButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _saveButton;
    
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];//设置导航栏
    
    [self addSubviewsForAddressAdd];
    
    [self addConstraintsForAddressAdd];
    
    
}
#pragma mark ************** 设置导航栏
- (void)setNav
{
    self.title = @"新建/编辑收货地址";
    self.view.backgroundColor = RGB(247, 247, 247);
    UIButton  *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.frame = CGRectMake(0, 0, 40, 40);
    [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //将leftItem设置为自定义按钮
    leftBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0);
    UIBarButtonItem  *leftItem =[[UIBarButtonItem alloc]initWithCustomView: leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
}
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)setModel:(YZGAddressModel *)model{
    _model = model;
    
    self.companyTF.text = model.deliverNicName;
    self.nameTF.text = model.deliverName;
    self.phoneTF.text = model.deliverPhone;
    self.areaTextTF.text = model.deliverPCAS;
    self.addressTextView.text = model.deliverAddress;
    
    [self.textDic setValue:model.deliverProvice forKey:@"省编码"];
    [self.textDic setValue:model.deliverCity forKey:@"市编码"];
    [self.textDic setValue:model.deliverArea forKey:@"镇编码"];
    
    isEdit = YES;
    
}

#pragma mark ************** 所在地区点击
-(void)areaViewClick:(UITapGestureRecognizer *)sender
{
    [self.view endEditing:YES];
    ESWeakSelf;
    [YZGAdderssPickerView showAlertViewWithAdderssArray:self.cityArray AdderssBlock:^(ETAreaListModel *province, City *city, Town *town) {
        
        NSString *address = nil;
        address = [NSString stringWithFormat:@"%@",province.name];
        
        if (city) {
            address = [NSString stringWithFormat:@"%@ %@",province.name,city.name];
        }
        if (town) {
            address = [NSString stringWithFormat:@"%@ %@ %@",province.name,city.name,town.name];
        }
        
        __weakSelf.areaTextTF.text = address;
        
        
        [__weakSelf.textDic setValue:@(province.code) forKey:@"deliverProvice"];
        [__weakSelf.textDic setValue:@(city.code) forKey:@"deliverCity"];
        [__weakSelf.textDic setValue:@(town.code) forKey:@"deliverArea"];
        
    }];
    
}

#pragma mark ************** 提醒框
-(void)alert:(NSString *)text
{
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:text message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
#pragma mark ************** 保存点击
- (void)saveButtonClick
{
    
    if ([self.companyTF.text isEqualToString:@""] )
    {
        [self alert:@"请输入别名(公司名称)"];
        return;
    }
    else
    {
        
        if([self.nameTF.text isEqualToString:@""])
        {
            [self alert:@"请输入收货人姓名"];
        }
        else
        {
            if([self.phoneTF.text isEqualToString:@""])
            {
                [self alert:@"请输入收货人联系方式"];
            }
            else
            {
                if (![RegExpValidate validateMobile:self.phoneTF.text]) {
                    [self alert:@"收货人联系方式输入有误"];
                    return;
                }
                if ([self.areaTextTF.text isEqualToString:@""]) {
                    [self alert:@"请选择所在区域"];
                }
                else
                {
                    if ([self.addressTextView.text isEqualToString:@""]) {
                        [self alert:@"请输入详细地址"];
                    }
                    else
                    {
                        [self.textDic setValue:self.model.deliverId forKey:@"deliverId"];
                        [self.textDic setValue:self.companyTF.text forKey:@"deliverNicName"];
                        [self.textDic setValue:self.nameTF.text forKey:@"deliverName"];
                        [self.textDic setValue:self.phoneTF.text forKey:@"deliverPhone"];
                        [self.textDic setValue:self.areaTextTF.text  forKey:@"deliverPCAS"];
                        [self.textDic setValue:self.addressTextView.text forKey:@"deliverAddress"];
                        
                        [self saveAdderss:self.textDic];//执行网络请求
                    }
                }
            }
        }
    }
    
}
#pragma mark ************** 网络请求
- (void)saveAdderss:(NSDictionary *)dic
{
    if(isEdit)
    {
        [SVHTTPClient editReceivingAddressWithParameters:dic CallBack:^(BOOL editReceivingAddressState) {
            if (editReceivingAddressState) {
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }
        }];
    }
    else
    {
        [SVHTTPClient addReceivingAddressWithParameters:dic CallBack:^(BOOL addReceivingAddressState) {
            if (addReceivingAddressState) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [self.navigationController popViewControllerAnimated:YES];
                });
                
            }
        }];
    }
    
}

#pragma mark ************** 添加子控件
- (void)addSubviewsForAddressAdd
{
    [self.view addSubview:self.scroll];
    [self.view addSubview:self.saveButton];
    
    [self.scroll addSubview:self.companyTF];
    [self.scroll addSubview:self.nameTF];
    [self.scroll addSubview:self.phoneTF];
    
    //所在地区
    [self.scroll addSubview:self.areaView];
    [self.areaView addSubview:self.areaTF];
    [self.areaView addSubview:self.areaTextTF];
    [self.areaView addSubview:self.bracketImg];
    
    //详细地区
    [self.scroll addSubview:self.detailsView];
    [self.detailsView addSubview:self.detailsLab];
    [self.detailsView addSubview:self.addressTextView];
    
    
    
    
}
#pragma mark ************** 添加约束
- (void)addConstraintsForAddressAdd
{
    [_saveButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.height.equalTo(@40);
        make.bottom.equalTo(self.view).offset(-10);
    }];
    
    [_scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(@(-60));
        
    }];
    [_companyTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(_scroll);
        make.height.equalTo(@(TEXT_HEIGHT));
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    [_nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_scroll);
        make.top.equalTo(_companyTF.bottom);
        make.height.equalTo(@(TEXT_HEIGHT));
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    [_phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_scroll);
        make.top.equalTo(_nameTF.bottom);
        make.height.equalTo(@(TEXT_HEIGHT));
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    //所在地区
    [_areaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_scroll);
        make.top.equalTo(_phoneTF.bottom).offset(10);
        make.height.equalTo(@(TEXT_HEIGHT));
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    [_bracketImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_areaView).offset(-10);
        make.centerY.equalTo(_areaView);
        make.width.height.equalTo(@(20));
    }];
    [_areaTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_areaView);
        make.width.equalTo(@(75));
        make.top.bottom.equalTo(_areaView);
    }];
    [_areaTextTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_areaTF.right).offset(10);
        make.right.equalTo(_bracketImg.left).offset(-10);
        make.top.bottom.equalTo(_areaView);
    }];
    
    //详细地区
    [_detailsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_scroll);
        make.top.equalTo(_areaView.bottom);
        make.height.equalTo(@(TEXT_HEIGHT));
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    [_detailsLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_detailsView);
        make.width.equalTo(@(80));
        make.top.bottom.equalTo(_detailsView);
    }];
    [_addressTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_detailsLab.right);
        make.top.bottom.equalTo(_detailsView);
        make.right.equalTo(_detailsView);
    }];
    
    
}
@end
