//
//  YZGShopProduductTableView.m
//  YZGShopInformation
//
//  Created by 李超 on 16/6/9.
//  Copyright © 2016年 lichao. All rights reserved.
//

#import "YZGAllBrandTableView.h"
#import "YZGAllBrandCell.h"
@interface YZGAllBrandTableView ()<UITableViewDelegate,UITableViewDataSource>


@end
@implementation YZGAllBrandTableView

#pragma ******************* init
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style])
    {
        self.delegate = self;
        self.dataSource = self;
        
        [self registerClass:[YZGAllBrandCell class] forCellReuseIdentifier:@"AllBrandCell"];

        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor colorWithHexColorString:@"f9f9f9"];
        
    }
    return self;
}

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    
    [self reloadData];
}

#pragma mark ************** UITableView 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  self.dataArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 100;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YZGAllBrandCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AllBrandCell" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    return cell;
    
}
#pragma ******************* UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    ProductDetail *productDetail = self.dataArray[indexPath.row];
//    NSString *productId = productDetail.seqid;
//    
//    if(self.cellClickBlack)
//    {
//        self.cellClickBlack(productId);
//    }
}
@end
