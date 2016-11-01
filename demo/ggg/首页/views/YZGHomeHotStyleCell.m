

#import "YZGHomeHotStyleCell.h"
@interface YZGHomeHotStyleCell ()
@property (nonatomic, strong) UIImageView *titleImg;         /**<  图片 */

@end


@implementation YZGHomeHotStyleCell

#pragma ******************* init
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
        
        [self addSubviewsForCell];
        
  
    }
    return self;
}

- (UIImageView *)titleImg {
    if (!_titleImg) {
        _titleImg = [[UIImageView alloc] init];
        _titleImg.image = [UIImage imageNamed:@"logo_del_pro"];
        _titleImg.backgroundColor = [UIColor yellowColor];
        _titleImg.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleImgClick:)];
        [_titleImg addGestureRecognizer:tap];
        
    }
    return _titleImg;
}

#pragma mark ************** 个人背景被点击
-(void)titleImgClick:(UITapGestureRecognizer *)sender
{
}
- (void)setModel:(NSDictionary *)model
{
    _model = model;
    
    //去编码
    NSString *imgUrl = model[@"picUri"];
    imgUrl = [imgUrl stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:[[imgUrl stringByAppendingString:@"@!product-list"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [_titleImg sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"logo_del_pro"] options:SDWebImageLowPriority | SDWebImageRetryFailed];
    
}
#pragma mark ************** 添加子控件
- (void)addSubviewsForCell
{
    [self.contentView addSubview:self.titleImg];
    
    [_titleImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
}




@end
