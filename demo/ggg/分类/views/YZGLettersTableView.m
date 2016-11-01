//
//  YZGShopProduductTableView.m
//  YZGShopInformation
//
//  Created by 李超 on 16/6/9.
//  Copyright © 2016年 lichao. All rights reserved.
//

#import "YZGLettersTableView.h"
#import "YZGClassifyTableCell.h"
@interface YZGLettersTableView ()<UITableViewDelegate,UITableViewDataSource>


@end
@implementation YZGLettersTableView

#pragma ******************* init
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style])
    {
        self.delegate = self;
        self.dataSource = self;
        
        [self registerClass:[YZGClassifyTableCell class] forCellReuseIdentifier:@"LettersCell"];

        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = RGBA(0, 0, 0, 0.3);
        
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
    
    return 40;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *cellIden = @"cell";//普通cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIden];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:cellIden];
    }
    YZGClassifylSubModel *subModel = self.dataArray[indexPath.row];
    cell.textLabel.text = subModel.name;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//去掉点击效果
    if(subModel.isSelect == YES)
    {
        cell.backgroundColor = mainColor;
    }
    else
    {
        cell.backgroundColor = RGBA(0, 0, 0, 0.3);
    }
    return cell;
   
    
}
#pragma ******************* UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    for(YZGClassifylSubModel *model in _dataArray)
    {
        model.isSelect = NO;
    }
    YZGClassifylSubModel *model = _dataArray[indexPath.row];
    model.isSelect = YES;
    
    [self reloadData];
    
    if(self.cellClickBlack)
    {
        self.cellClickBlack(indexPath.row);
    }
  
 [self scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
  
}
@end
