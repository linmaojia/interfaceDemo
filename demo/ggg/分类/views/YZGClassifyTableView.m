//
//  YZGShopProduductTableView.m
//  YZGShopInformation
//
//  Created by 李超 on 16/6/9.
//  Copyright © 2016年 lichao. All rights reserved.
//

#import "YZGClassifyTableView.h"
#import "YZGClassifyTableCell.h"
@interface YZGClassifyTableView ()<UITableViewDelegate,UITableViewDataSource>


@end
@implementation YZGClassifyTableView

#pragma ******************* init
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style])
    {
        self.delegate = self;
        self.dataSource = self;
        
        [self registerClass:[YZGClassifyTableCell class] forCellReuseIdentifier:@"YZGClassifyTableCell"];

        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor colorWithHexColorString:@"f9f9f9"];
        
    }
    return self;
}

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    
    YZGClassifylModel *firstModel = _dataArray[0];
    firstModel.isSelect = YES;
    
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
    
    return 45;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YZGClassifyTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YZGClassifyTableCell" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    return cell;
    
}
#pragma ******************* UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    for(YZGClassifylModel *model in _dataArray)
    {
        model.isSelect = NO;
    }
    YZGClassifylModel *model = _dataArray[indexPath.row];
    model.isSelect = YES;
    
    [self reloadData];
    
    if(self.cellClickBlack)
    {
        self.cellClickBlack(indexPath.row);
    }
  
}
@end
