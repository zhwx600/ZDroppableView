//
//  ZDropScrollView.m
//  DroppableViewTest
//
//  Created by zhwx on 15/4/16.
//
//

#import "ZDropScrollView.h"
#import "ZDroppableView.h"
#import "ZDeleteRegionView.h"


// setup view vars
static CGFloat sDROPVIEW_MARGIN = 5.0; //view间隔
static CGFloat sDROPVIEW_SIZE  = 97.0; //view 大小


@interface ZDropScrollView ()<ZDroppableViewDelegate>
{
    CGPoint mLastPosition;
}

@property (nonatomic,strong) UIButton* o_addButton;
@property (nonatomic,strong) ZDeleteRegionView* o_deleteTargetView;

@end


@implementation ZDropScrollView

@synthesize o_imageDatas=_o_imageDatas;

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

-(void) awakeFromNib
{
    [super awakeFromNib];
    
    [self setupData];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupData];
    }
    return self;
}

-(void) setupData{
    self.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
    sDROPVIEW_SIZE = ([[UIScreen mainScreen] bounds].size.width - 2*10 - 3*5)/4;
    
    _o_maxCount = 9;
    _o_isHideAddBtn = NO;
}

#pragma mark-

-(NSMutableArray*) o_imageDatas
{
    NSMutableArray* tempArray = [NSMutableArray array];
    for (ZDroppableView* zView in self.subviews) {
        
        if ([zView isKindOfClass:[ZDroppableView class]]) {
            [tempArray addObject:zView];
        }
        
    }
    
    //排序
    NSArray* sortArray = [tempArray sortedArrayUsingSelector:NSSelectorFromString(@"compareZDroppableViewIndex:")];
    
    NSMutableArray* newObjs = [NSMutableArray array];
    for (ZDroppableView* zView in sortArray) {
        [newObjs addObject:zView.o_userInfo];
    }
    
    return newObjs;
}



-(void) setO_imageDatas:(NSArray *)o_imageDatas
{
    _o_imageDatas = [NSMutableArray arrayWithArray:o_imageDatas];
    
}

- (void) addLastButton
{
    CGSize size = CGSizeMake(sDROPVIEW_SIZE, sDROPVIEW_SIZE);
    
    if (!_o_addButton) {
        UIButton * addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        addButton.frame = CGRectMake(mLastPosition.x, mLastPosition.y, size.width, size.height);
        
        [addButton addTarget:self action:@selector(addNewImage:) forControlEvents:UIControlEventTouchUpInside];
        [addButton setImage:[UIImage imageNamed:@"bg_add_imgshow@2x.png"] forState:UIControlStateNormal];
        
        _o_addButton = addButton;
    }
    
    _o_addButton.frame = CGRectMake(mLastPosition.x, mLastPosition.y, size.width, size.height);
    
    [self addSubview: _o_addButton];
    [self relayout];
    
}

-(ZDeleteRegionView*) o_deleteTargetView
{
    if (!_o_deleteTargetView) {
        _o_deleteTargetView = [[ZDeleteRegionView alloc] init];
    }
    return _o_deleteTargetView;
}


#pragma mark-

- (void) addViewWithIndex:(NSInteger)index
{
    //    CGFloat contentWidth  = self.frame.size.width  - self.contentInset.left - self.contentInset.right;
    //    CGFloat contentHeight = self.frame.size.height - self.contentInset.top;
    CGSize size = CGSizeMake(sDROPVIEW_SIZE, sDROPVIEW_SIZE);
    
    ZDroppableView * dropview = [[ZDroppableView alloc] initWithScrollView:self target:self.o_deleteTargetView regionView:_o_regionView];
    dropview.o_userInfo = _o_imageDatas[index];
    dropview.frame = CGRectMake(mLastPosition.x, mLastPosition.y, size.width, size.height);
    dropview.o_index = index;
    dropview.o_delegate = self;
    dropview.o_isDefaultAnimation = YES;
    [self addSubview: dropview];
    
    
    [self relayout];
    
    UIImageView* tImageVIew = [[UIImageView alloc] init];

    if ([_o_imageDatas[index] isKindOfClass:[NSURL class]]) {
        [tImageVIew sd_setImageWithURL:_o_imageDatas[index] placeholderImage:[UIImage imageNamed:@"default_icon"]];
    }else if ([_o_imageDatas[index] isKindOfClass:[NSString class]]) {
        [tImageVIew sd_setImageWithURL:[NSURL URLWithString:_o_imageDatas[index]] placeholderImage:[UIImage imageNamed:@"default_icon"]];
    }else if ([_o_imageDatas[index] isKindOfClass:[UIImage class]]) {
        [tImageVIew setImage:_o_imageDatas[index]];
    }else{
        [tImageVIew setImage:[UIImage imageNamed:@"default_icon"]];
    }
    
    tImageVIew.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    tImageVIew.contentMode = UIViewContentModeScaleAspectFill;
    tImageVIew.clipsToBounds = YES;
    tImageVIew.frame = CGRectMake(0, 0, dropview.frame.size.width, dropview.frame.size.height);
    [dropview addSubview:tImageVIew];
    
}

- (void) relayout
{
    // cancel all animations
    [self.layer removeAllAnimations];
    for (UIView* subview in self.subviews)
        [subview.layer removeAllAnimations];
    
    // setup new animation
    [UIView beginAnimations: @"drag" context: nil];
    
    // init calculation vars
    float posx = 0;
    float posy = 0;
    CGRect frame = CGRectZero;
    mLastPosition = CGPointMake(0, -100);
    CGFloat contentWidth = self.frame.size.width - self.contentInset.left - self.contentInset.right;
    
    
    //先添加 所有的  ZDroppableView
    // iterate through all subviews
    for (UIView* subview in self.subviews)
    {
        // ignore scroll indicators
        if (!subview.userInteractionEnabled) {
            continue;
        }
        
        if ([subview isKindOfClass:[UIButton class]]) {
            continue;
        }
        
        // create new position
        frame = subview.frame;
        frame.origin.x = posx;
        frame.origin.y = posy;
        
        // update frame (if it did change)
        if (frame.origin.x != subview.frame.origin.x ||
            frame.origin.y != subview.frame.origin.y) {
            subview.frame = frame;
        }
        
        // save last position
        mLastPosition = CGPointMake(posx, posy);
        
        // add size and margin
        posx += frame.size.width + sDROPVIEW_MARGIN;
        
        // goto next row if needed
        if (posx > self.frame.size.width - self.contentInset.left - self.contentInset.right)
        {
            posx = 0;
            posy += frame.size.height + sDROPVIEW_MARGIN;
        }
    }
    
    
    //最后添加 UIButton
    // iterate through all subviews
    for (UIView* subview in self.subviews)
    {
        // ignore scroll indicators
        if (!subview.userInteractionEnabled) {
            continue;
        }
        
        if (![subview isKindOfClass:[UIButton class]]) {
            continue;
        }
        
        
        // create new position
        frame = subview.frame;
        frame.origin.x = posx;
        frame.origin.y = posy;
        
        // update frame (if it did change)
        if (frame.origin.x != subview.frame.origin.x ||
            frame.origin.y != subview.frame.origin.y) {
            subview.frame = frame;
        }
        
        // save last position
        mLastPosition = CGPointMake(posx, posy);
        
        // add size and margin
        posx += frame.size.width + sDROPVIEW_MARGIN;
        
        // goto next row if needed
        if (posx > self.frame.size.width - self.contentInset.left - self.contentInset.right)
        {
            posx = 0;
            posy += frame.size.height + sDROPVIEW_MARGIN;
        }
    }
    
    
    
    // fix last posy for correct contentSize
    if (posx != 0) {
        posy += frame.size.height;
    } else {
        posy -= sDROPVIEW_MARGIN;
    }
    
    // update content size
    self.contentSize = CGSizeMake(contentWidth, posy);
    
    [UIView commitAnimations];
    
    if ([_o_delegate respondsToSelector:@selector(contentSizeDidChange:)]) {
        [_o_delegate contentSizeDidChange:self.contentSize];
    }
}


- (void) scrollToBottomAnimated: (BOOL) animated
{
    [self.layer removeAllAnimations];
    
    CGFloat bottomScrollPosition = self.contentSize.height;
    bottomScrollPosition -= self.frame.size.height;
    bottomScrollPosition += self.contentInset.top;
    bottomScrollPosition = MAX(-self.contentInset.top,bottomScrollPosition);
    CGPoint newOffset = CGPointMake(-self.contentInset.left, bottomScrollPosition);
    if (newOffset.y != self.contentOffset.y) {
        [self setContentOffset: newOffset animated: animated];
    }
}


-(void) addNewImage:(id)sender
{
    if ([_o_delegate respondsToSelector:@selector(addNewView:)]) {
        [_o_delegate addNewView:self];
    }
}


-(void) reloadData
{
    
    while (self.subviews.count) {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
    
    for (int i = 0; i < _o_imageDatas.count; i++) {
        [self addViewWithIndex:i];
    }
    
    //显示 添加按钮呢
    if (!_o_isHideAddBtn) {
        if (_o_maxCount > 0) {
            if (_o_imageDatas.count < _o_maxCount) {
                [self addLastButton];
            }
        }else{
            [self addLastButton];
        }
    }
    
    [self scrollToBottomAnimated:YES];
}


#pragma mark- ZDroppableViewDelegate
-(BOOL) shouldAnimateDroppableView:(ZDroppableView *)dropView isDroppedOnTarget:(UIView *)targetView
{
    [self relayout];
    [self flashScrollIndicators];
    
    NSInteger index = dropView.o_index;
    [_o_imageDatas removeObjectAtIndex:index];
    
    if ([_o_delegate respondsToSelector:@selector(removeIndex:)]) {
        [_o_delegate removeIndex:index];
    }
    
    [self reloadData];
    
    return YES;
}


-(void) droppableView:(ZDroppableView *)dropView exchangeWithOthers:(NSArray *__autoreleasing *)otherDropViews
{
    *otherDropViews = self.subviews;
}

-(void) droppableView:(ZDroppableView *)dropView exchangeOtherDropView:(ZDroppableView *)otherView
{
    [_o_imageDatas exchangeObjectAtIndex:dropView.o_index withObjectAtIndex:otherView.o_index];
    
    if ([_o_delegate respondsToSelector:@selector(exchangeIndex:otherIndex:)]) {
        [_o_delegate exchangeIndex:dropView.o_index otherIndex:otherView.o_index];
    }
}

-(void) droppableViewDidSelected:(ZDroppableView *)dropView
{
    if ([_o_delegate respondsToSelector:@selector(didSelectWithIndex:userInfo:)]) {
        [_o_delegate didSelectWithIndex:dropView.o_index userInfo:dropView.o_userInfo];
    }
    
}


/**
 * 拖动开始、结束时 对拖动控件【dropView】的操作
 */
- (void) droppableViewBeganDragging:(ZDroppableView*)dropView
{
    [self.o_deleteTargetView showInView:_o_regionView];
}
- (void) droppableViewEndedDragging: (ZDroppableView*)dropView
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.o_deleteTargetView hide];
    });
    
}


/**
 * 拖动控件【dropView】 进入、离开 目标控件【targetView】的操作
 */
- (void) droppableView:(ZDroppableView*)dropView enterTarget:(UIView*)targetView
{
    [self.o_regionView addSubview:targetView];
    [self.o_regionView bringSubviewToFront:dropView];
    
    [self.o_deleteTargetView setStatusIsIn:YES];
    
}
- (void) droppableView:(ZDroppableView*)dropView leaveTarget:(UIView*)targetView
{
    [self.o_deleteTargetView setStatusIsIn:NO];
}


#pragma mark- 重写方法

- (BOOL)touchesShouldBegin:(NSSet *)touches withEvent:(UIEvent *)event inContentView:(UIView *)view
{
    //    NSLog(@"用户点击了scroll上的视图%@,是否开始滚动scroll",view);
    //返回yes 是不滚动 scroll 返回no 是滚动scroll
    return YES;
}
- (BOOL)touchesShouldCancelInContentView:(UIView *)view
{
    
    //    NSLog(@"用户点击的视图 %@",view);
    
    //NO scroll不可以滚动 YES scroll可以滚动
    return NO;
}


@end

