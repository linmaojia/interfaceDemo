//
//  ETMyServiceController.m
//  ETao
//
//  Created by AVGD－Mai on 16/4/14.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "YZGMyServiceController.h"
@interface YZGMyServiceController ()
@property (nonatomic, strong) UIImageView *imageView;    /**< 图片1 */
@property (nonatomic, strong) UIImageView *imageView_tow;    /**< 图片2 */
@property (nonatomic, strong) UIImageView *imageView_three;    /**< 图片3 */
@end

@implementation YZGMyServiceController


- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.image = [UIImage imageNamed:@"logo_del_pro"];
        [_imageView setContentMode:UIViewContentModeScaleAspectFit];
    }
    return _imageView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"平台介入";
    
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
    
    
    
    self.view.backgroundColor = hexColor(FAFAFA);
    
    [self.view addSubview:self.imageView];
    
    [self addConstraintsView];
    ESWeakSelf;
    
    [SVProgressHUD show];
    [[SVHTTPClient sharedClient] setGlobalHeaderField];
    
    [SVHTTPClient sharedClient].sendParametersAsJSON = YES;
    [[SVHTTPClient sharedClient] GET:APIIntervention parameters:nil completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        [SVProgressHUD dismiss];
        
        NSDictionary *dic = response[@"customer"];
        
        [__weakSelf showImg:dic[@"picUri"]];
        
        
    }];
    
}
- (void)showImg:(NSString *)url
{
    ESWeakSelf;
    __block CGFloat viewH = 0;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"logo_del_pro"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if (image)
        {
            //判断图片是否有值，避免出现除以零的情况导致崩溃
            viewH = SCREEN_WIDTH * image.size.height / image.size.width;
            
            [__weakSelf.imageView updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@(viewH));
            }];
            
        }
        
    }];
    

}
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)addConstraintsView {
    
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(self.view);
        make.height.equalTo(@(self.view.frame.size.height));
    }];
    
}



@end
