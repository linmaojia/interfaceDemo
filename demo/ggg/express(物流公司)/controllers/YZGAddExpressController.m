//
//  YZGUserSettingViewController.m
//  yzg
//
//  Created by LXY on 16/6/2.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGAddExpressController.h"
#import "JKTextField.h"
#import "YZGAdderssPickerView.h"
#import "SVHTTPClient+ExpressLists.h"
static float const TEXT_HEIGHT = 50;  /**< 文本框高度 */
@interface YZGAddExpressController ()
{
    UISwitch *switchBtn;   /**< 选择按钮 */
    NSInteger isDefault;   /**< 是否选择默认物流 */
    BOOL isEdit;    /**< 是否编辑状态 */
}
@property(nonatomic, strong)UIButton *saveButton;   /**< 保存 */
@property (nonatomic, strong)UIScrollView *scroll;    /**< Scrollow视图 */

@property(nonatomic, strong) UIView *companyView;   /** 公司名称背景 */

@property(nonatomic, strong) JKTextField *companyTF;   /** 公司名称 */
@property(nonatomic, strong) UIView *areaView;   /** 所在地区view */
@property(nonatomic, strong) UILabel *areaTF;   /** 所在地区文本提示 */
@property(nonatomic, strong) UILabel *areaTextTF;     /** 所在地区文本 */

@property (nonatomic, strong) UIImageView *bracketImg;    /**< 右边尖括号图片 */
@property(nonatomic, strong) JKTextField *detailAreaTF;   /** 详细地区 */
//
@property(nonatomic, strong) JKTextField *phoneTF;   /** 联系电话 */
@property(nonatomic, strong) JKTextField *remarkTF;   /** 物流备注 */

@property (strong, nonatomic) UIView *defaultExpressView;  /**< 设置默认物流  */
@property(nonatomic, strong) UILabel *titleLab;   /** 提示 */

@property(nonatomic, strong) UILabel *lab;   /** 必填 */
@property (strong, nonatomic) NSArray *cityArray;            /**< 城市列表 */
@property (nonatomic, strong) NSMutableDictionary *textDic;             /**< 记录输入文本 */




@end

@implementation YZGAddExpressController
#pragma mark ************** 懒加载
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
- (UIView *)companyView {
    if (!_companyView) {
        _companyView = [[UIView alloc] init];
        _companyView.backgroundColor = [UIColor whiteColor];
        _companyView.layer.borderWidth = 0.5;
        _companyView.layer.borderColor = RGB(227, 229, 230).CGColor;
        
    }
    return _companyView;
}
- (UILabel *)lab {
    if (!_lab) {
        _lab = [[UILabel alloc] init];
        _lab.backgroundColor = [UIColor whiteColor];
        _lab.font = systemFont(14);
        _lab.text = @"*必填";
        _lab.textColor = [UIColor redColor];
    }
    return _lab;
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

- (UIImageView *)bracketImg {
    if (!_bracketImg) {
        _bracketImg = [[UIImageView alloc] init];
        _bracketImg.image = [UIImage imageNamed:@"right_back"];
    }
    return _bracketImg;
}
- (JKTextField *)companyTF
{
    if(!_companyTF)
    {
        _companyTF = [[JKTextField alloc]init];
        _companyTF.backgroundColor = [UIColor whiteColor];
        _companyTF.placeholder = @" 如：江浙物流";
        _companyTF.font = [UIFont systemFontOfSize:14];
        _companyTF.clearButtonMode=YES;
        //左侧文字
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 75, TEXT_HEIGHT)];
        label.text = @"公司名称:";
        label.font = [UIFont systemFontOfSize:14];
        _companyTF.leftViewMode = UITextFieldViewModeAlways;
        _companyTF.leftView = label;
        
        
        
    }
    return _companyTF;
}
- (JKTextField *)remarkTF
{
    if(!_remarkTF)
    {
        _remarkTF = [[JKTextField alloc]init];
        _remarkTF.backgroundColor = [UIColor whiteColor];
        _remarkTF.placeholder = @" 备注信息(非必填)";
        _remarkTF.font = [UIFont systemFontOfSize:14];
        _remarkTF.clearButtonMode=YES;
        _remarkTF.layer.borderWidth = 0.5;
        _remarkTF.layer.borderColor = RGB(227, 229, 230).CGColor;
        //左侧文字
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 75, TEXT_HEIGHT)];
        label.text = @"物流备注:";
        label.font = [UIFont systemFontOfSize:14];
        _remarkTF.leftViewMode = UITextFieldViewModeAlways;
        _remarkTF.leftView = label;
        
    }
    return _remarkTF;
}
- (JKTextField *)phoneTF
{
    if(!_phoneTF)
    {
        _phoneTF = [[JKTextField alloc]init];
        _phoneTF.backgroundColor = [UIColor whiteColor];
        _phoneTF.placeholder = @" 接收方或转运站的联系电话(非必填)";
        _phoneTF.font = [UIFont systemFontOfSize:14];
        _phoneTF.clearButtonMode=YES;
        _phoneTF.layer.borderWidth = 0.5;
        _phoneTF.layer.borderColor = RGB(227, 229, 230).CGColor;
        //左侧文字
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 75, TEXT_HEIGHT)];
        label.text = @"联系电话:";
        label.font = [UIFont systemFontOfSize:14];
        _phoneTF.leftViewMode = UITextFieldViewModeAlways;
        _phoneTF.leftView = label;
        
    }
    return _phoneTF;
}
- (JKTextField *)detailAreaTF
{
    
    if(!_detailAreaTF)
    {
        _detailAreaTF = [[JKTextField alloc]init];
        _detailAreaTF.backgroundColor = [UIColor whiteColor];
        _detailAreaTF.placeholder = @" 路/门牌号(非必填)";
        _detailAreaTF.font = [UIFont systemFontOfSize:14];
        _detailAreaTF.clearButtonMode=YES;
        _detailAreaTF.layer.borderWidth = 0.5;
        _detailAreaTF.layer.borderColor = RGB(227, 229, 230).CGColor;
        //左侧文字
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 75, TEXT_HEIGHT)];
        label.text = @"详细地区:";
        label.font = [UIFont systemFontOfSize:14];
        _detailAreaTF.leftViewMode = UITextFieldViewModeAlways;
        _detailAreaTF.leftView = label;
        
    }
    return _detailAreaTF;
}
- (UILabel *)titleLab {
    
    if (!_titleLab) {
        _titleLab= [[UILabel alloc] init];
        _titleLab.font = [UIFont systemFontOfSize:12];
        _titleLab.numberOfLines = 0;
        NSString *tagText = @"重要提示：卖家会尽可能满足您指定物流公司的要求，因工厂所在区域各不相同，请下单后与工厂客服确认物流公司。";
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:tagText];
        [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:[tagText rangeOfString:@"重要提示："]];
        _titleLab.attributedText = attrString;
        
    }
    return _titleLab;
}
- (UIView *)defaultExpressView {
    if (!_defaultExpressView) {
        _defaultExpressView = [[UIView alloc] init];;
        _defaultExpressView.backgroundColor = [UIColor whiteColor];
        _defaultExpressView.layer.borderWidth = 0.5;
        _defaultExpressView.layer.borderColor = RGB(227, 229, 230).CGColor;
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 60, 45)];
        titleLab.font = systemFont(14);
        titleLab.text = @"默认物流";
        [_defaultExpressView addSubview:titleLab];
        UILabel *detailLab = [[UILabel alloc] initWithFrame:CGRectMake(75, 0, 180, 45)];
        detailLab.font = systemFont(12);
        detailLab.textColor = RGB(174, 174, 174);
        detailLab.text = @"(注:每次下单时使用该物流公司)";
        [_defaultExpressView addSubview:detailLab];
        
        switchBtn = [[UISwitch alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-60, 8, 50, 45)];
        switchBtn.onTintColor = mainColor;
        [switchBtn addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        [_defaultExpressView addSubview:switchBtn];
       
        if( [_model.isDefault isEqualToString:@"1"])//修改默认按钮状态
        {
            [switchBtn setOn:YES];
            isDefault = 1;
        }
        else
        {
             isDefault = 0;
        }
        
        
    }
    return _defaultExpressView;
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

#pragma mark ************** 系统方法
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];//设置导航栏
    
    [self addSubViewsForAddExpress];
    
    [self addConstraintsForAddExpress];
    
    
}
#pragma mark ************** 保存点击
- (void)saveButtonClick
{
    if([self.companyTF.text isEqualToString:@""])
    {
        [self alert:@"请输入物流公司"];
    }
    else
    {
       
        [self.textDic setValue:self.companyTF.text forKey:@"logisticsName"];
        [self.textDic setValue:self.phoneTF.text forKey:@"logisticsPhone"];
        [self.textDic setValue:self.areaTextTF.text  forKey:@"logisticsPCAS"];
        [self.textDic setValue:self.detailAreaTF.text forKey:@"logisticsAddress"];
        [self.textDic setValue:self.remarkTF.text forKey:@"logisticsDesc"];
        [self.textDic setValue:@(isDefault) forKey:@"isDefault"];
        
        [self saveAdderss];//数据请求
        
    }
}
- (void)setModel:(YZGExpressModel *)model
{
    _model = model;
    
    self.companyTF.text = model.logisticsName;
    self.phoneTF.text = model.logisticsPhone;
    self.areaTextTF.text = model.logisticsPCAS;
    self.detailAreaTF.text = model.logisticsAddress;
    self.remarkTF.text = model.logisticsDesc;

    [self.textDic setValue:model.logisticsProvince forKey:@"省编码"];
    [self.textDic setValue:model.logisticsCity forKey:@"市编码"];
    [self.textDic setValue:model.logisticsArea forKey:@"镇编码"];

    isEdit = YES;
    
}
#pragma mark ************** 网络请求
- (void)saveAdderss
{
    if(isEdit)
    {
        [self.textDic setValue:self.model.logisticsId forKey:@"logisticsId"];//编辑id
        [SVHTTPClient editExpressWithParameters:self.textDic CallBack:^(BOOL state) {
            if (state) {
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];

                });
            }
        }];
    }
    else
    {
        [SVHTTPClient addExpressWithParameters:self.textDic CallBack:^(BOOL state) {
            if (state) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [self.navigationController popViewControllerAnimated:YES];
                });
                
            }
        }];
    }
    
}
#pragma mark ************** 所在地区点击
-(void)areaViewClick:(UITapGestureRecognizer *)sender
{

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
#pragma mark ************** 点击默认按钮
- (void)switchAction:(UISwitch *)sender
{
    if(sender.isOn)
    {
      isDefault = 1;
  
    }
    else
    {
      isDefault = 0;
    }

   
}
#pragma mark ************** 提醒框
-(void)alert:(NSString *)text
{
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:text message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
#pragma mark ************** 自定义方法
- (void)setNav{
    
    self.title = @"新增/编辑物流公司";
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
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark ************** 添加视图
- (void)addSubViewsForAddExpress
{
    [self.view addSubview:self.scroll];
    [self.view addSubview:self.saveButton];
    [self.scroll addSubview:self.companyView];
    
    [self.companyView addSubview:self.companyTF];
    [self.companyView addSubview:self.lab];
    
    //所在地区
    [self.scroll addSubview:self.areaView];
    [self.areaView addSubview:self.areaTF];
    [self.areaView addSubview:self.areaTextTF];
    [self.areaView addSubview:self.bracketImg];
    
    [self.scroll addSubview:self.detailAreaTF];
    [self.scroll addSubview:self.phoneTF];
    [self.scroll addSubview:self.remarkTF];
    [self.scroll addSubview:self.defaultExpressView];
    [self.scroll addSubview:self.titleLab];
    
    
    
}
#pragma mark ************** 添加约束
- (void)addConstraintsForAddExpress {
    
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
    [_companyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(_scroll);
        make.height.equalTo(@(TEXT_HEIGHT));
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    
    [_companyTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(_companyView);
        make.height.equalTo(@(TEXT_HEIGHT));
        make.width.equalTo(@(SCREEN_WIDTH - 50));
    }];
    
    [_lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_companyView);
        make.left.equalTo(_companyTF.right);
        make.height.equalTo(@(TEXT_HEIGHT));
        make.width.equalTo(@(50));
    }];
    
    
    //所在地区
    [_areaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_scroll);
        make.top.equalTo(_companyView.bottom);
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
    
    
    
    
    
    [_detailAreaTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_scroll);
        make.top.equalTo(_areaView.bottom);
        make.height.equalTo(@(TEXT_HEIGHT));
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    [_phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_scroll);
        make.top.equalTo(_detailAreaTF.bottom);
        make.height.equalTo(@(TEXT_HEIGHT));
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    [_remarkTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_scroll);
        make.top.equalTo(_phoneTF.bottom);
        make.height.equalTo(@(TEXT_HEIGHT));
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    [_defaultExpressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_scroll);
        make.top.equalTo(_remarkTF.bottom).offset(10);
        make.height.equalTo(@(45));
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_scroll).offset(10);
        make.top.equalTo(_defaultExpressView.bottom).offset(10);
        make.height.equalTo(@(TEXT_HEIGHT));
        make.width.equalTo(@(SCREEN_WIDTH-20));
    }];
    
    
    
}


@end
