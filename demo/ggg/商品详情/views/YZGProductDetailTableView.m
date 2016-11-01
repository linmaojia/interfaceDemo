//
//  YZGShopProduductTableView.m
//  YZGShopInformation
//
//  Created by 李超 on 16/6/9.
//  Copyright © 2016年 lichao. All rights reserved.
//

#import "YZGProductDetailTableView.h"
#import "YZGProductDetailImageCell.h"
#import "YZGProductDetailTitleCell.h"
#import "YZGProductManager.h"
#import "YZGDetailProduductFootView.h"
@interface YZGProductDetailTableView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableDictionary *imgHeightDic;
@property (nonatomic, strong) NSArray *sameArray;  /**< 同类推荐 */

@property (nonatomic, assign) BOOL isShowTitle;  /*是否显示1分区*/
@property (nonatomic, strong) YZGDetailProduductFootView *footView; /**< TableView尾部信息 */
@end
@implementation YZGProductDetailTableView

#pragma ******************* init
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style])
    {
        self.delegate = self;
        self.dataSource = self;
        
        [self registerClass:[YZGProductDetailImageCell class] forCellReuseIdentifier:@"productDetailImageCell"];
        [self registerClass:[YZGProductDetailTitleCell class] forCellReuseIdentifier:@"ProductDetailTitleCell"];

        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor colorWithHexColorString:@"f9f9f9"];
        
    }
    return self;
}
- (YZGDetailProduductFootView *)footView {
    
    if (!_footView) {
        
        ESWeakSelf;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
        layout.minimumInteritemSpacing = 10; //列与列之间的间距
        layout.minimumLineSpacing = 10;//行与行之间的间距
        layout.itemSize = CGSizeMake((SCREEN_WIDTH-30)/2, 240);//cell的大小
        _footView = [[YZGDetailProduductFootView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300) collectionViewLayout:layout];
        _footView.cellClick = ^(NSString *productId){
            __weakSelf.sameCellClick(productId);
            
        };
    }
    return _footView;
}
- (NSMutableDictionary *)imgHeightDic {
    if (!_imgHeightDic) {
        _imgHeightDic = [NSMutableDictionary dictionary];
    }
    return _imgHeightDic;
}
- (void)setModel:(YZGProductDetailModel *)model
{
    _model = model;
    
    self.sameArray = model.similarProduct;
    
    //预估高度
    for(int i = 0; i<model.gintroduce.count ;i++)
    {
        YZGProductIntroduceModel *introduceModel = model.gintroduce[i];
        introduceModel.cellHeight = 500;
    }

    
}
#pragma mark **************** 加载同系列
- (void)setSameArray:(NSArray *)sameArray
{
    _sameArray = sameArray;

    self.footView.hotArray = sameArray;

    [self reloadData];
}
#pragma mark **************** 同类推荐的高度
- (CGFloat)caculateRecomendProductFooterHeight:(NSArray *)recmendArr
{
    NSInteger row = recmendArr.count / 2;
    row += recmendArr.count % 2;
    CGFloat height = row * 240 + (row + 1)*10;
    if (recmendArr.count == 0)
    {
        height = 0;
    }
    return height;
}

#pragma mark ************** 规格参数分区点击事件
-(void)titleImgClick:(UITapGestureRecognizer *)sender
{
    self.isShowTitle = !self.isShowTitle;
    
    [self reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma ******************* UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if(section == 0)
    {
        if(self.isShowTitle == NO)
        {
            return 0;
        }
        else
        {
            return 8;
        }
        
    }
    else if(section == 1)
    {
        return _model.gintroduce.count;
    }
    else
    {
        return 1;
    }

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ESWeakSelf;
    if(indexPath.section == 0)
    {
        YZGProductDetailTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProductDetailTitleCell" forIndexPath:indexPath];
        NSArray *titleArray = [YZGProductManager getOneSectionTitleArray:self.model];
        cell.title = titleArray[indexPath.row];
        cell.indexPath = indexPath;

        return cell;
    }
    else if(indexPath.section == 1)
    {
        YZGProductDetailImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"productDetailImageCell" forIndexPath:indexPath];
        cell.model = _model.gintroduce[indexPath.row];
        cell.cellHeightBlack = ^(CGFloat cellHeight){
            
            NSLog(@"----%lf",cellHeight);
            //[__weakSelf reloadData];
        };
        return cell;
    }
    else
    {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        }
        [cell addSubview:self.footView];
        
        CGFloat height = [self caculateRecomendProductFooterHeight:self.sameArray];
        
        self.footView.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
        
        return cell;
    }

}
/*预估值的cell高度*/
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section == 0)
    {
        return 50;
    }
    else if(indexPath.section == 1)
    {
        return 500.f;
    }
    else
    {
        return 500.0f;
    }
    
}
/*真实值的cell高度*/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.section == 0)
    {
        return 50;
    }
    else if(indexPath.section == 1)
    {
        YZGProductIntroduceModel *introduceModel = _model.gintroduce[indexPath.row];
        return introduceModel.cellHeight;
    }
    else
    {
        CGFloat height = [self caculateRecomendProductFooterHeight:self.sameArray];
        return height;
    }

}
/*分区头部高度*/
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
   
    return 50;

}
/*分区尾部高度*/
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
/*分区头部View*/
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if(section == 0)
    {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = RGB(247, 247, 247);
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 40)];
        lab.text = @"   规格参数";
        lab.textColor = [UIColor blackColor];
        lab.backgroundColor = [UIColor whiteColor];
        [view addSubview:lab];
        
        view.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleImgClick:)];
        [view addGestureRecognizer:tap];
        
        
        return view;
    }
    else if(section == 1)
    {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = RGB(247, 247, 247);
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 40)];
        lab.text = @"上拉查看图文详情";
        lab.textColor = [UIColor blackColor];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.backgroundColor = [UIColor whiteColor];
        [view addSubview:lab];
        return view;
    }
    else
    {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = RGB(247, 247, 247);
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 40)];
        lab.text = @"同系列推荐";
        lab.textColor = [UIColor blackColor];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.backgroundColor = [UIColor whiteColor];
        [view addSubview:lab];
        return view;
     }
   
    
}



#pragma ******************* UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.section == 0)
    {
       
    }
    else
    {
        if(self.procuctImgClickBlack)
        {
            self.procuctImgClickBlack(indexPath);
        }
    }
    

}
#pragma ******************* 偏移量
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    CGFloat tableHeight = self.contentSize.height;
    
    CGFloat offset = scrollView.contentOffset.y;
    
    CGFloat tableHeadHeight = self.tableHeaderView.frame.size.height;//头部高度
    
    CGFloat footheight = [self caculateRecomendProductFooterHeight:self.sameArray];
    
    CGFloat sectionHeight = 0;
    
    if(self.isShowTitle == YES)
    {
        sectionHeight = 9*50;//第一个分区高度
    }
    else
    {
        sectionHeight = 50;
    }
    
    NSInteger index = 0;
    //上下再中间
    if(offset  < tableHeadHeight + sectionHeight)
    {
       
        index = 0;
    }
    else
    {
       
        if(offset >=   tableHeight - footheight -51)
        {
            //NSLog(@"xxxx----xxxxx-----%lf",tableHeight - tableFootHeight -51);
            
          
            index = 2;
        }
        else
        {
            index = 1;
        }
        
    }
//      NSLog(@"xxxx--<<<<<<<<<<<<---%ld",index);
//      NSLog(@"<<<<<<<<<<<<<<<<<<<<<<<<-----%f",scrollView.contentOffset.y);//偏移量
    if(self.titleIndexBlack)
    {
        self.titleIndexBlack(index);
    }
}
#pragma ******************* 滚动到某个区
- (void)scrollToRowAtIndexPath:(NSInteger)index
{
    if(index == 0)
    {
     [self setContentOffset:CGPointMake(0,0) animated:NO];
    }
    else if(index == 1)
    {
        
     [self scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        
    }
    else if(index == 2)
    {
        
        //要点击2次才不会出错，坑, self.contentSize.height 高度不一定，计算出错,因为还没加载完成
      [self scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        
        /*
        //第一个分区高度
        CGFloat oneSectionHeight = 0;
        
        if(self.isShowTitle == YES)
        {
            oneSectionHeight = 9*50;
        }
        else
        {
            oneSectionHeight = 50;
        }
        
        //第图片分区高度
        CGFloat imageHeight = 0;
        for(int i = 0;i<_model.gintroduce.count;i++)
        {
           YZGProductIntroduceModel *introduceModel = _model.gintroduce[i];
            imageHeight = imageHeight + introduceModel.cellHeight;
        }
  
       
        
        CGFloat tableHeadHeight = self.tableHeaderView.frame.size.height;//头部高度
        
        [self setContentOffset:CGPointMake(0,oneSectionHeight + tableHeadHeight + imageHeight + 50) animated:NO];
        
       NSLog(@"xxxx--<<<<<<<<<<<<------%lf----%lf---%lf",oneSectionHeight,tableHeadHeight,imageHeight);
        */
        
    }
    
 
}
@end
