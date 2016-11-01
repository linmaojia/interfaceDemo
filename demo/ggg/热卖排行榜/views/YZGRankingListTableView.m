//
//  YZGShopProduductTableView.m
//  YZGShopInformation
//
//  Created by 李超 on 16/6/9.
//  Copyright © 2016年 lichao. All rights reserved.
//

#import "YZGRankingListTableView.h"
#import "YZGProductListCell.h"
@interface YZGRankingListTableView ()<UITableViewDelegate,UITableViewDataSource>


@end
@implementation YZGRankingListTableView

#pragma ******************* init
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style])
    {
        self.delegate = self;
        self.dataSource = self;
        
        [self registerClass:[YZGProductListCell class] forCellReuseIdentifier:@"ListTableViewCell"];

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
    
    return 130;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YZGProductListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListTableViewCell" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    return cell;
    
}
#pragma ******************* UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ProductDetail *productDetail = self.dataArray[indexPath.row];
    NSString *productId = productDetail.seqid;
    
    if(self.cellClickBlack)
    {
        self.cellClickBlack(productId);
    }
}
@end
