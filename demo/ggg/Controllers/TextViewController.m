//
//  TextViewController.m
//  ggg
//
//  Created by LXY on 16/9/24.
//  Copyright © 2016年 AVGD. All rights reserved.
/*
 
 //        if(type == EmptyViewTypeNoSignal)
 //        {
 //              NSLog(@"----网络无连接");
 //        }
 //        else if(type == EmptyViewTypeEmptyData)
 //        {
 //               NSLog(@"----空数据");
 //        }
 //        else if(type == EmptyViewTypeNotAuthentication)
 //        {
 //            NSLog(@"----未认证");
 //        }
 //        else if(type == EmptyViewTypesDataError)
 //        {
 //            NSLog(@"----未知错误");
 //        }
 //        else if(type == EmptyViewTypesucceed)
 //        {
 //            NSLog(@"----成功");
 //        }
 //
 
 
 /*
 
 EmptyViewTypeNoSignal = 0,//网络无连接
 EmptyViewTypeEmptyData,//空数据
 EmptyViewTypeNotAuthentication,//未认证
 EmptyViewTypesDataError,//数据错误
 EmptyViewTypesUnknownError,//未知错误
 EmptyViewTypesucceed    //成功
 
 */



#import "TextViewController.h"
#import "YZGOrderButtonView.h"
#import "HMSegmentedControl.h"
@interface TextViewController ()
@property (nonatomic, strong) YZGOrderButtonView *centerView;

@property (nonatomic, strong) HMSegmentedControl *titleControl;    /**< 订单分段控制器 */
@end

@implementation TextViewController
- (HMSegmentedControl *)titleControl {
    
    if (!_titleControl) {
        _titleControl = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(0, 0, 54*2, 40)];
        _titleControl.sectionTitles = @[@"全部", @"待付款"];
        _titleControl.backgroundColor = [UIColor clearColor];
        _titleControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
        _titleControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
        _titleControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        _titleControl.selectionIndicatorColor = RGB(38, 66, 136);
        _titleControl.selectedSegmentIndex = 0;
        _titleControl.segmentEdgeInset = UIEdgeInsetsMake(0, 0, 0, 0);
        [_titleControl setTitleFormatter:^NSAttributedString *(HMSegmentedControl *segmentedControl, NSString *title, NSUInteger index, BOOL selected) {
            NSAttributedString *attString = nil;
            if (selected) {
                attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName : RGB(38, 66, 136),NSFontAttributeName : [UIFont systemFontOfSize:14.0f]}];
            } else {
                attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName : [UIColor blackColor],NSFontAttributeName : [UIFont systemFontOfSize:14.0f]}];
            }
            return attString;
        }];
        [_titleControl addTarget:self action:@selector(orderSegmentedIndexChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _titleControl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)getData
{
   
}
- (void)viewWillAppear:(BOOL)animated
{
    
    self.navigationItem.titleView =self.titleControl;
    
    [self getData];
  
}
- (void)xxxx{
  NSLog(@"----xxxxx");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
