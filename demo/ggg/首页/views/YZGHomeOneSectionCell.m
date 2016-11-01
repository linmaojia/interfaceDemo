

#import "YZGHomeOneSectionCell.h"
#import "YZGScrollerView.h"
@interface YZGHomeOneSectionCell ()

@property (nonatomic, strong) YZGScrollerView *scrollerView;
@end


@implementation YZGHomeOneSectionCell

#pragma ******************* init
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
        
        [self addSubviewsForCell];
        
  
    }
    return self;
}
- (void)setModel:(YZGHomeClassifiesModel *)model
{
    _model = model;
    
    if(model)
    {
        NSMutableArray *array = [NSMutableArray array];
        [array addObject:model.hot];
        [array addObject:model.types];
        [array addObject:model.spaces];
        [array addObject:model.styles];
        
        _scrollerView.titleArray = array;
    }
   
    
}
#pragma mark ************** 添加子控件
- (void)addSubviewsForCell
{
    
    _scrollerView = [[YZGScrollerView alloc]initWithFrame:self.contentView.frame];
    
    [self.contentView addSubview:_scrollerView];

}




@end
