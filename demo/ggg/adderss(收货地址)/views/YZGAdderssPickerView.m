//
//  YZGPickerView.m
//  Masonry
//
//  Created by LXY on 16/7/7.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGAdderssPickerView.h"
#import "ETAreaListModel.h"
@interface YZGAdderssPickerView () <UIPickerViewDataSource,UIPickerViewDelegate>


@property (strong, nonatomic) NSArray *dataArray;
@property (strong, nonatomic) UIPickerView *pickerView;

@property (strong, nonatomic) UIView *pickerBgView;//背景
@property (strong, nonatomic) NSArray *provinceArray;//省
@property (strong, nonatomic) NSArray *cityArray;//市
@property (strong, nonatomic) NSArray *townArray;//街道

@property (nonatomic, strong) UIButton *confirmBtn;//完成按钮


@property (nonatomic,copy) void(^titleBtnBlock)(ETAreaListModel *province,City *city,Town *town);     /**< 按钮回调 */
@end

@implementation YZGAdderssPickerView

#pragma mark **************** init
#pragma mark 懒加载控件
- (UIButton *)confirmBtn
{
    if(!_confirmBtn)
    {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _confirmBtn.frame = CGRectMake(SCREEN_WIDTH-40, 0, 40, 40);
        [_confirmBtn setBackgroundColor:[UIColor whiteColor]];
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_confirmBtn addTarget:self action:@selector(confirmBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _confirmBtn;
}
- (UIView *)pickerBgView
{
    if(!_pickerBgView)
    {
        _pickerBgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, 250)];
        _pickerBgView.backgroundColor = [UIColor whiteColor];
        
    }
    return _pickerBgView;
}
- (UIPickerView *)pickerView
{
    if(!_pickerView)
    {
        //_pickerView = [[UIPickerView alloc]init]; //不能这样初始化
        //#warning 这里高度和pickerBgView高度 有点问题
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 20, self.frame.size.width, 250)];
        _pickerView.backgroundColor = [UIColor whiteColor];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = RGBA(0, 0, 0, 0);
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        [self addGestureRecognizer:tap];//添加手势
        
    }
    return self;
}
+ (void)showAlertViewWithAdderssArray:(NSArray *)dataArray AdderssBlock:(void(^)(ETAreaListModel *province,City *city,Town *town))titleBtnBlock{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    YZGAdderssPickerView *blackView = [[YZGAdderssPickerView alloc] initWithFrame:keyWindow.frame];//黑色阴影
    [keyWindow addSubview:blackView];
    
    blackView.dataArray = dataArray;
    blackView.titleBtnBlock = titleBtnBlock;
}

- (void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    
    [self getData];//转模型
    
    
    [self addSubview:self.pickerBgView];
    [self.pickerBgView addSubview:self.pickerView];
    [self.pickerBgView addSubview:self.confirmBtn];

    [self show];//显示视图
}



- (void)show{
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = RGBA(0, 0, 0, 0.5);
     
        CGRect frame = _pickerBgView.frame;
        frame.origin.y -= frame.size.height;
        _pickerBgView.frame = frame;
        
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = RGBA(0, 0, 0, 0);
      
        CGRect frame = _pickerBgView.frame;
        frame.origin.y += frame.size.height;
        _pickerBgView.frame = frame;
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark ************** 确定按钮方法
- (void)confirmBtnClick:(UIButton *)sender {
    NSString *address = nil;
    
    ETAreaListModel *prModel = self.provinceArray[[self.pickerView selectedRowInComponent:0]];//第一列选中哪一个
    
    City *city = self.cityArray[[self.pickerView selectedRowInComponent:1]];
    
    Town *town = self.townArray[[self.pickerView selectedRowInComponent:2]];
    
    address = [NSString stringWithFormat:@" 省、市、区：%@",prModel.name];
    
    if (city) {
        address = [NSString stringWithFormat:@" 省、市、区：%@ %@",prModel.name,city.name];
    }
    if (town) {
        address = [NSString stringWithFormat:@" 省、市、区：%@ %@ %@",prModel.name,city.name,town.name];
    }
    
    self.titleBtnBlock(prModel,city,town);
    [self dismiss];
    
}

#pragma mark ************** 转模型
- (void)getData{
    
    self.provinceArray = [ETAreaListModel mj_objectArrayWithKeyValuesArray:self.dataArray]; //转模型 //省数组
    
    ETAreaListModel *provinceModel = [self.provinceArray objectAtIndex:0];//省
    
    self.cityArray = provinceModel.edsAddrList; //市数组
    
    if (self.cityArray.count > 0) {
        
        City *cityModel = [self.cityArray objectAtIndex:0];//市
        
        self.townArray = cityModel.edsAddrList;//区数组
    }
}
#pragma mark ************** pickerView 代理方法
//一共有多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

//第component列一共有多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return self.provinceArray.count;
    } else if (component == 1) {
        return self.cityArray.count;
    } else {
        return self.townArray.count;
    }
}
//第component列第row行显示怎样的view(内容)
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (component == 0) {
        ETAreaListModel *provinceModel = [self.provinceArray objectAtIndex:row];
        return provinceModel.name;
    } else if (component == 1) {
        City *cityModel = [self.cityArray objectAtIndex:row];
        return cityModel.name;
    } else {
        Town *townModel = [self.townArray objectAtIndex:row];
        return townModel.name;
    }
}
//选中了pickerView的第component列第row行
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (component == 0) {
        
        ETAreaListModel *provinceModel = [self.provinceArray objectAtIndex:row];// 省
        
        self.cityArray = provinceModel.edsAddrList; // 市数组
        
        if (self.cityArray.count > 0) {
            
            City *city = [self.cityArray objectAtIndex:0];// 市
            
            self.townArray = city.edsAddrList;// 区数组
        } else {
            self.cityArray = nil;
            self.townArray = nil;
        }
        
        [pickerView reloadComponent:1];//刷新第2列的信息 从0开始
        [pickerView reloadComponent:2];
    }
    if (component == 1) {
        
        
        City *city = [self.cityArray objectAtIndex:row]; // 市
        
        self.townArray = city.edsAddrList; // 区数组
        
        if (self.townArray.count > 0 && self.cityArray.count > 0) {
            
            City *city = [self.cityArray objectAtIndex:row];
            
            self.townArray = city.edsAddrList;
            
        } else {
            self.townArray = nil;
        }
        [pickerView reloadComponent:2];//刷新第3列的信息 从0开始
    }
    
}

@end
