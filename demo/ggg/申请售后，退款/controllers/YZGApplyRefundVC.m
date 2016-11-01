//  Created by LXY on 16/6/2.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGApplyRefundVC.h"
#import "JKCustomTextField.h"
#import "YZGBottomAlertView.h"
#import "SVHTTPClient+DrawbackRequset.h"
#import "SVHTTPClient+RefundModify.h"
#import "RefuldViewController.h"
@interface YZGApplyRefundVC ()


@property (nonatomic, strong) JKCustomTextField *moneyTextField;    /**< 退款金额 */
@property (nonatomic, strong) JKCustomTextField *nameTextField;    /**< 联系人 */
@property (nonatomic, strong) JKCustomTextField *phoneTextField;    /**< 联系方式 */
@property (nonatomic, strong) UIButton * refundBtn;      /**< 申请退款按钮 */

@property (nonatomic, strong) UIView *reasonView;        /**< 退款原因 */
@property (nonatomic, strong) UIImageView *rightImg ;         /**<  右边图片 */
@property (nonatomic, strong) UILabel *leftLab;             /**<  左边标题 */
@property (nonatomic, strong) UILabel *centerLab;             /**<  中间标题 */


@end

@implementation YZGApplyRefundVC


#pragma mark - 懒加载控件
- (UILabel *)leftLab {
    if (!_leftLab) {
        _leftLab = [[UILabel alloc] init];
        _leftLab.textAlignment = NSTextAlignmentLeft;
        _leftLab.font = systemFont(14);
        _leftLab.text = @"退款原因";
        
    }
    return _leftLab;
}
- (UILabel *)centerLab {
    if (!_centerLab) {
        _centerLab = [[UILabel alloc] init];
        _centerLab.textAlignment = NSTextAlignmentLeft;
        _centerLab.font = systemFont(14);
        _centerLab.text = @"协商一致退款";
        _centerLab.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(centerLabClick:)];
        [_centerLab addGestureRecognizer:tap];
    }
    return _centerLab;
}
- (UIImageView *)rightImg {
    if (!_rightImg) {
        _rightImg = [[UIImageView alloc] init];
        _rightImg.image = [UIImage imageNamed:@"right_back"];
       
        
    }
    return _rightImg;
}
- (UIView *)reasonView {
    if (!_reasonView) {
        _reasonView = [[UIView alloc] init];
        _reasonView.backgroundColor = [UIColor whiteColor];
        
    }
    return _reasonView;
}
- (JKCustomTextField *)moneyTextField {
    if (!_moneyTextField) {
        _moneyTextField = [[JKCustomTextField alloc] init];
        _moneyTextField.backgroundColor = [UIColor whiteColor];
        _moneyTextField.rkType = UIReturnKeyDone;
        _moneyTextField.placeholderFont = systemFont(14);
        _moneyTextField.userInteractionEnabled = NO;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 2.5, 85, 40)];
        label.text = @" 订单金额";
        label.font = [UIFont systemFontOfSize:14];
        
        _moneyTextField.textFieldLeftView = label;
    }
    return _moneyTextField;
}
- (JKCustomTextField *)nameTextField {
    if (!_nameTextField) {
        _nameTextField = [[JKCustomTextField alloc] init];
        _nameTextField.backgroundColor = [UIColor whiteColor];
        _nameTextField.rkType = UIReturnKeyDone;
        _nameTextField.placeholder = @"";
        _nameTextField.placeholderFont = systemFont(14);
         _nameTextField.userInteractionEnabled = NO;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 85, 40)];
        label.text = @" 退款联系人";
        label.font = [UIFont systemFontOfSize:14];
        _nameTextField.textFieldLeftView = label;
    }
    return _nameTextField;
}
- (JKCustomTextField *)phoneTextField {
    if (!_phoneTextField) {
        _phoneTextField = [[JKCustomTextField alloc] init];
        _phoneTextField.backgroundColor = [UIColor whiteColor];
        _phoneTextField.rkType = UIReturnKeyDone;
        _phoneTextField.placeholderFont = systemFont(14);
        _phoneTextField.userInteractionEnabled = NO;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 85, 40)];
        label.text = @" 联系方式";
        label.font = [UIFont systemFontOfSize:14];
        _phoneTextField.textFieldLeftView = label;
    }
    return _phoneTextField;
}
- (UIButton *)refundBtn
{
    if(!_refundBtn)
    {
        _refundBtn = [[UIButton alloc]init];
        _refundBtn.titleLabel.font = boldSystemFont(14);
        [_refundBtn setTitle:@"申请退款" forState:0];
        _refundBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);//标题居中左偏移15
        [_refundBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _refundBtn.backgroundColor = RGB(38, 66, 136);
        _refundBtn.layer.cornerRadius = 2;
        [_refundBtn addTarget:self action:@selector(refundBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _refundBtn;
    
}

#pragma mark - 系统方法
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setNav];//设置导航栏
    [self addConstraintsForView];//控件布局
}
#pragma mark ************** 退款按钮
- (void)refundBtnClick:(UIButton *)sender
{
    
    YZGOrderDetailModel *detailModel = self.model.ezgOrderdetailsArr[self.indexPath.row];
     Orderdetails *product =   detailModel.productDetail;
    NSString *count = [NSString stringWithFormat:@"%ld",detailModel.productQty];
    
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    [dataDic setObject:_centerLab.text forKey:@"refundReason"];
    [dataDic setObject:_moneyTextField.placeholder forKey:@"refundMoney"];
    [dataDic setObject:_centerLab.text forKey:@"refundRemark"];
    [dataDic setObject:detailModel.orderDetailId forKey:@"orderDetailId"];
    [dataDic setObject:product.brandName forKey:@"brandName"];
    [dataDic setObject:detailModel.productID forKey:@"productId"];
    [dataDic setObject:count forKey:@"productQty"];
    
    
    //判断是否有申请过退款
    YZGEzgRefund *ezgRefund = detailModel.ezgRefund;
   
    if(ezgRefund)
    {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:ezgRefund.refundId forKey:@"refundId"];
        [dic setObject:_centerLab.text forKey:@"refundReason"];

        ESWeakSelf;
        //修改退款申请
        [SVHTTPClient refundModifyWithParameters:dic callBack:^(BOOL state) {
            if(state)
            {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [__weakSelf.navigationController popViewControllerAnimated:YES];
                });
                
            }
        }];
         
    }
    else
    {
        ESWeakSelf;
        //提交退款申请
        [SVHTTPClient drawbackRequsetWithParameters:dataDic callBack:^(BOOL state, NSDictionary *dic) {
            
            if(state)
            {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    RefuldViewController *VC = [[RefuldViewController alloc]init];
                    VC.type = 1;
                    VC.indexPath = __weakSelf.indexPath;
                    VC.orderDetailId = __weakSelf.model.orderCode;
                    [__weakSelf.navigationController pushViewController:VC animated:YES];
                    
                });
                
               
            }
            
        }];
    }
    
}
#pragma mark ************** 更好退款原因
-(void)centerLabClick:(UITapGestureRecognizer *)sender{
    
    NSArray *titleArray = @[@"协商一致退款",@"未按约定时间确定订单",@"拍错/多拍/不想要",@"缺货",@"其他"];
    ESWeakSelf;
    YZGBottomAlertView *alertView = [[YZGBottomAlertView alloc]initWithTitle:titleArray];
    alertView.alertTitleBlock = ^(NSString *title){
        __weakSelf.centerLab.text = title;
    };
    
}
#pragma mark - 自定义方法
- (void)setNav{
    self.title = @"申请退款";
    self.view.backgroundColor = RGB(235, 235, 241);
    
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
#pragma mark ************** 方法
- (void)setModel:(YZGNextOhterDetailModel *)model
{
    _model = model;
    
    //判断是否存在公司名称
    if([model.deliverName rangeOfString:@"("].location == NSNotFound )
    {
        NSLog(@"不存在");
         self.nameTextField.placeholder = model.deliverName;
    }
    else
    {
        NSLog(@"存在");
        //取出用户名称
        NSRange theRange=[model.deliverName rangeOfString:@"("];
        NSString *name = [model.deliverName substringWithRange:NSMakeRange(0,theRange.location)];
        self.nameTextField.placeholder = name;
    }
   
    self.phoneTextField.placeholder = model.deliverPhone;
   
    YZGOrderDetailModel *detailModel = model.ezgOrderdetailsArr[self.indexPath.row];

    CGFloat price = detailModel.productQty * detailModel.productPrice;
    self.moneyTextField.placeholder = [NSString stringWithFormat:@"%.2lf",price];
 
    //如果存在退款明细，赋值原因
    YZGEzgRefund *ezgRefund = detailModel.ezgRefund;
    if(ezgRefund)
    {
        YZGEzgRefund *ezgRefund = detailModel.ezgRefund;
        
        self.centerLab.text = ezgRefund.refundReason;
    }

}


#pragma mark - 控件布局
- (void)addConstraintsForView {
    
    [self.view addSubview:self.moneyTextField];
    
    [self.view addSubview:self.reasonView];
    [self.reasonView addSubview:self.leftLab];
    [self.reasonView addSubview:self.centerLab];
    [self.reasonView addSubview:self.rightImg];
    
    [self.view addSubview:self.nameTextField];
    [self.view addSubview:self.phoneTextField];
    [self.view addSubview:self.refundBtn];
    
    [_moneyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self.view);
        make.top.equalTo(self.view);
        make.height.equalTo(@(45));
    }];
    [_reasonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self.view);
        make.top.equalTo(_moneyTextField.bottom);
        make.height.equalTo(@(45));
    }];
    [_leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_reasonView).offset(15);
        make.top.bottom.equalTo(_reasonView);
        make.width.equalTo(@(80));
        
    }];
    [_rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_reasonView).offset(-10);
        make.centerY.equalTo(_reasonView);
        make.height.width.equalTo(@(20));
    }];
    [_centerLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftLab.right);
        make.top.bottom.equalTo(_reasonView);
        make.right.equalTo(_rightImg.left);
    }];
    
    
    [_nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self.view);
        make.top.equalTo(_reasonView.bottom).offset(-1);
        make.height.equalTo(@(45));
    }];
    [_phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self.view);
        make.top.equalTo(_nameTextField.bottom).offset(-1);
        make.height.equalTo(@(45));
    }];
    
    [_refundBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-20);
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(_phoneTextField.bottom).offset(10);
        make.height.equalTo(@(40));
    }];
}

@end
