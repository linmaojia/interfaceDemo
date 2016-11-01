//
//  YZGMineTableOrderCell.m
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGWeiBoTableVIewCell.h"
#import "SDPhotoBrowser.h"
@interface YZGWeiBoTableVIewCell()<SDPhotoBrowserDelegate>
{
    CGFloat ImgHeight;
}
@property (nonatomic, strong) UIImageView *leftImg;         /**<  产品图片 */
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *centerView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UILabel *titleLab;      /**<  标题 */
@property (nonatomic, strong) UIImageView *userImg;         /**<  图片 */
@property (nonatomic, strong) NSArray *imgUrlArray;  /**<  图片数组 */
@property (nonatomic, strong) UIImage *selectImg;  /**<  选中图片 */

@end
@implementation YZGWeiBoTableVIewCell
- (UIImageView *)userImg {
    if (!_userImg) {
        _userImg = [[UIImageView alloc] init];
        _userImg.image = [UIImage imageNamed:@"user"];
        _userImg.layer.cornerRadius = 35/2;
        _userImg.layer.masksToBounds = YES;
    }
    return _userImg;
}


- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.font = systemFont(16);
        _titleLab.text = @"查看详情";
        _titleLab.backgroundColor =[UIColor whiteColor];
        _titleLab.numberOfLines = 0;
    }
    return _titleLab;
}
#pragma mark ************** 懒加载控件
- (UIView *)centerView {
    if (!_centerView) {
        _centerView = [[UIImageView alloc] init];
        _centerView.backgroundColor = [UIColor whiteColor];
        _centerView.userInteractionEnabled = YES;
     
    }
    return _centerView;
}
- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIImageView alloc] init];
        _bottomView.backgroundColor = [UIColor yellowColor];
    }
    return _bottomView;
}
- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIImageView alloc] init];
        _topView.backgroundColor =  [UIColor whiteColor];
    }
    return _topView;
}
- (UIImageView *)leftImg {
    if (!_leftImg) {
        _leftImg = [[UIImageView alloc] init];
        _leftImg.image = [UIImage imageNamed:@"account_highlight"];
        [_leftImg setContentMode:UIViewContentModeScaleAspectFit];
        
    }
    return _leftImg;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = RGB(241, 241, 241);
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        [self addSubviewsForCell];
        
        [self addConstraintsForCell];
        
        [self creatImgs];
        
        
    }
    return self;
}
#pragma mark **************** 创建图片数组
- (void)creatImgs
{
    CGFloat space = 10;
    CGFloat img_W = (self.frame.size.width - space *4)/3;
    int index = 0;
    for(int j = 0;j<3;j++)
    {
        for(int i = 0;i<3;i++)
        {
            CGRect frame = CGRectMake(space +i*(img_W +space), space + j*(img_W +space), img_W, img_W);
            UIImageView *titleImg = [[UIImageView alloc] initWithFrame:frame];
            titleImg.image = [UIImage imageNamed:@"logo_del_pro"];
            titleImg.backgroundColor = [UIColor grayColor];
            titleImg.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleImgClick:)];
            [titleImg addGestureRecognizer:tap];
            titleImg.tag = 100+index;
            [_centerView addSubview:titleImg];
            index++;
      
            
        }
    }
}

#pragma mark ************** 设置cell 内容
- (void)setModel:(YZGWeiBoModel *)model{
    _model = model;
    
    self.imgUrlArray = model.urls;
    NSInteger ImgCount = self.imgUrlArray.count;

    for(int i = 0 ;i<9;i++)
    {
        UIImageView *titleImg = (UIImageView *)[_centerView viewWithTag:100+i];
        if(i <  ImgCount)
        {
            titleImg.hidden = NO;
            NSURL *imgUrl = [NSURL URLWithString:self.imgUrlArray[i]];
            [titleImg sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"logo_del_pro"] options:SDWebImageLowPriority | SDWebImageRetryFailed];
        }
        else
        {
            titleImg.hidden = YES;
        }
       
    }
    
    //计算text高度
    NSString *text = model.textString;
    
    CGFloat textHeight = [text HeightWithText:text constrainedToWidth:SCREEN_WIDTH -20 LabFont:[UIFont systemFontOfSize:16]];//计算文字高度

    _titleLab.text = text;
    
    [_titleLab updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(textHeight + 5));
    }];
}
#pragma mark ************** 个人背景被点击
-(void)titleImgClick:(UITapGestureRecognizer *)sender
{
    
    UIImageView *imageView = (UIImageView *)sender.view;
    NSInteger index = imageView.tag - 100;
    self.selectImg = imageView.image;
    

    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    browser.sourceImagesContainerView = _centerView; // 原图的父控件
    browser.imageCount = self.imgUrlArray.count; // 图片总数
    browser.currentImageIndex = index;
    browser.delegate = self;
    [browser show];
    
    
}
#pragma ******************* SDPhotoBrowser Delegate
#pragma ******************* 返回临时占位图片（即原来的小图）
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    return self.selectImg;
}


#pragma ******************* 返回高质量图片的url
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    
    return [NSURL URLWithString:self.imgUrlArray[index]];
}
#pragma mark **************** 添加子控件
- (void)addSubviewsForCell
{
    
    
    [self.contentView addSubview:self.topView];
    [self.contentView addSubview:self.titleLab];
    [self.contentView addSubview:self.bottomView];
    [self.contentView addSubview:self.centerView];

    //顶部
    [self.topView addSubview:self.userImg];

}
#pragma mark **************** 约束
- (void)addConstraintsForCell
{
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(self.contentView);
        make.height.equalTo(@50);
    }];
   
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self.contentView);
        make.bottom.equalTo(@(-10));
        make.height.equalTo(@40);
    }];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(_topView.bottom);
        make.height.equalTo(@50);
    }];
    [_centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLab.bottom);
        make.bottom.equalTo(_bottomView.top);
        make.right.left.equalTo(self.contentView);
    }];
   
    //顶部
    [_userImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_topView);
        make.left.equalTo(_topView).offset(10);
        make.width.height.equalTo(@35);
    }];

}
@end
