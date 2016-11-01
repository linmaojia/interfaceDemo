//
//  GetOrderList.m
//  ggg
//
//  Created by LXY on 16/9/24.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGWeiBoManager.h"
#import "YZGWeiBoModel.h"
@interface YZGWeiBoManager ()
@property (nonatomic, strong) NSMutableArray *dataArray; /**< 数据 */
@end
@implementation YZGWeiBoManager
#pragma mark ************** 请求数据
- (NSMutableArray *)getDataArray
{
    //直接读本地数据
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"tableView" ofType:@"plist"];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    NSArray *array = dic[@"picArray"];
    
    //转换模型
    _dataArray = [YZGWeiBoModel mj_objectArrayWithKeyValuesArray:array];
    
    return _dataArray;
    
}
+ (CGFloat )getImgArrayHeightWith:(YZGWeiBoModel *)model
{
    CGFloat height = 0;
    
    CGFloat space = 10;
    
    CGFloat img_W = (SCREEN_WIDTH - space *4)/3;
    
    
    NSInteger imgCount = model.urls.count;
    NSInteger imgLine = 0;
    if(imgCount > 0 && imgCount <= 3 )
    {
        imgLine = 1;
    }
    else if(imgCount >3  && imgCount <= 6 )
    {
        imgLine = 2;
    }
    else if(imgCount >6  && imgCount <= 9 )
    {
        imgLine = 3;
    }
    else
    {
        imgLine = 3;
    }
    //计算图片高度
    CGFloat ImgHeight = imgLine*(img_W+space) + space + 100;
    
    NSString *text = model.textString;
    
    //计算文字高度
    CGFloat textHeight = [text HeightWithText:text constrainedToWidth:SCREEN_WIDTH -20 LabFont:[UIFont systemFontOfSize:16]];
    textHeight = textHeight + 5;
    
    height = ImgHeight +textHeight;
    
    return height;

}

@end
