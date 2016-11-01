//
//  YZGMyCollectShopView.m
//  ggg
//
//  Created by LXY on 16/9/7.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGMyCollectShopView.h"
#import "YZGMyCollectShopCell.h"
#import "SVHTTPClient+CollectCancel.h"
@interface YZGMyCollectShopView()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation YZGMyCollectShopView

#pragma ******************* init
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style])
    {
        self.delegate = self;
        self.dataSource = self;
        
        [self registerClass:[YZGMyCollectShopCell class] forCellReuseIdentifier:@"shopCell"];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor colorWithHexColorString:@"f9f9f9"];
        
        
    }
    return self;
}
- (void)setShops:(NSArray *)shops{
    _shops = shops;
    [self reloadData];
}
#pragma ******************* UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.shops.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YZGMyCollectShopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shopCell" forIndexPath:indexPath];
    cell.model = self.shops[indexPath.row];
  
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
//-----------------------   添加删除效果
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ESWeakSelf;
    //删除按钮
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"取消\n关注" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath){
        
        YZGMyCollecShopModel *model =  __weakSelf.shops[indexPath.row];
        
        NSString *favoriteId = model.favoriteId;
        
        NSIndexPath *indexPath_1=[NSIndexPath indexPathForRow:indexPath.row inSection:0];
        NSArray *indexArray=[NSArray arrayWithObject:indexPath_1];
        [tableView reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationNone];
        
        [SVHTTPClient collectCancelOrderType:shopType :favoriteId :^(BOOL state) {
            
            if(state)
            {
                if(__weakSelf.reloadDataClick)
                {
                    __weakSelf.reloadDataClick(NO);//刷新数据
                }
            }
            
        }];
        
    }];
    //返回按钮数组
    return @[deleteRowAction];
}


#pragma ******************* UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if(self.cellClick)
    {
        self.cellClick(indexPath);
    }
    
}
@end
