//
//  YZGMineTableHeadView.m
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGImgWithTitltView.h"
#import "YZGHomeClassifiesModel.h"


@interface YZGImgWithTitltView()
{
    CGFloat self_width,self_height;
    CGFloat view_height,view_width;
}

@end

@implementation YZGImgWithTitltView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor =  [UIColor whiteColor];
        
       
        self_width = self.frame.size.width;
        
        self_height = self.frame.size.height;
       
        view_height = self.frame.size.height/2;
        
        view_width = self.frame.size.width/4;
        
    }
    return self;
}

#pragma mark ************** 创建按钮
- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    
    [self creatBtn];
}
- (void)creatBtn
{
    int index = 0;
    for(int j = 0; j < 2; j++){
        for (int i = 0; i < 4; i++) {
            
            YZGDetailClassifiesModel *model = _dataArray[index];
            
            UIView *view = [[UIView alloc]init];
            view.frame = CGRectMake(i * view_width, j * view_height, view_width, view_height);
            view.backgroundColor = [UIColor whiteColor];
            [self addSubview:view];
            view.tag = 100+index;
            view.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewClick:)];
            [view addGestureRecognizer:tap];
            
            //文本
            UILabel *titleLab = [[UILabel alloc] init];
            titleLab.frame = CGRectMake(0, view_height - 30, view_width, 30);
            titleLab.textAlignment = NSTextAlignmentCenter;
            titleLab.textColor = [UIColor blackColor];
            titleLab.font = systemFont(14);
            titleLab.text = model.name;
            [view addSubview:titleLab];
            
            //图片
            UIImageView *titleImg = [[UIImageView alloc] init];
            titleImg.frame = CGRectMake(0, 0, view_width, view_height - 30);
            
            NSURL *imgUrl = [NSURL URLWithString:[[model.extend1 stringByAppendingString:@"@!product-list"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            [titleImg sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"logo_del_pro"]];
            
            [titleImg setContentMode:UIViewContentModeScaleAspectFit];
            [view addSubview:titleImg];
    
            index++;
            
            if(index == _dataArray.count)
            {
                break;//跳出循环
            }
          
        }
        
    }
    
   
}
#pragma mark ************** 按钮被点击
-(void)viewClick:(UITapGestureRecognizer *)sender{
    
   //传递标题回调
    NSInteger index = sender.view.tag-100;
    if(self.viewWithTagBlack)
    {
        self.viewWithTagBlack(index);
    }
    
}

@end
