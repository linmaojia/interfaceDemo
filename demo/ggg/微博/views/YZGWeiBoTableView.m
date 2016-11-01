//
//  YZGShopProduductTableView.m
//  YZGShopInformation
//
//  Created by 李超 on 16/6/9.
//  Copyright © 2016年 lichao. All rights reserved.
//

#import "YZGWeiBoTableView.h"
#import "YZGWeiBoTableVIewCell.h"
#import "YZGWeiBoModel.h"
#import "YZGWeiBoManager.h"
#import "SDPhotoBrowser.h"
@interface YZGWeiBoTableView ()<UITableViewDelegate,UITableViewDataSource,SDPhotoBrowserDelegate>

@property (nonatomic, strong) NSArray *selectArray;

@end
@implementation YZGWeiBoTableView

#pragma ******************* init
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style])
    {
        self.delegate = self;
        self.dataSource = self;
        
        [self registerClass:[YZGWeiBoTableVIewCell class] forCellReuseIdentifier:@"YZGWeiBoTableVIewCell"];

        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor colorWithHexColorString:@"f9f9f9"];
        
    }
    return self;
}

- (void)setDataArray:(NSMutableArray *)dataArray
{
    _dataArray = dataArray;
    
    [self reloadData];
}

#pragma mark ************** UITableView 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  _dataArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YZGWeiBoModel *model = self.dataArray[indexPath.row];
    CGFloat height = [YZGWeiBoManager getImgArrayHeightWith:model];
    return height;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ESWeakSelf;
    YZGWeiBoTableVIewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YZGWeiBoTableVIewCell" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    cell.imgClickBlack = ^(NSInteger index)
    {
        NSLog(@"xxx----%ld",index);
        [__weakSelf imgClick:index Row:indexPath.row];
    };
    return cell;
    
}

#pragma ******************* UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
     NSLog(@"gggg----%ld",indexPath.row);
    
//    ProductDetail *productDetail = self.dataArray[indexPath.row];
//    NSString *productId = productDetail.seqid;
//    
//    if(self.cellClickBlack)
//    {
//        self.cellClickBlack(productId);
//    }
}
#pragma ******************* SDPhotoBrowser Delegate
- (void)imgClick:(NSInteger)index Row:(NSInteger)row
{
    
    YZGWeiBoModel *model = self.dataArray[row];
    self.selectArray = model.urls;
    
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    browser.sourceImagesContainerView = self; // 原图的父控件
    browser.imageCount = self.selectArray.count; // 图片总数
    browser.currentImageIndex = index;
    browser.delegate = self;
    [browser show];
}
// 返回临时占位图片（即原来的小图）
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    return [UIImage imageNamed:@"logo_del_pro"];
}


// 返回高质量图片的url
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    
    return [NSURL URLWithString:self.selectArray[index]];
}
@end
