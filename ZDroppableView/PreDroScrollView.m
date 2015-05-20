//
//  PreDroScrollView.m
//  TinySeller
//
//  Created by zhwx on 15/4/16.
//  Copyright (c) 2015年 zhenwanxiang. All rights reserved.
//

#import "PreDroScrollView.h"
#import "ZDroppableView.h"
#import "EGOImageView.h"

// setup view vars
static CGFloat sDROPVIEW_MARGIN = 5.0; //view间隔
static CGFloat sDROPVIEW_SIZE  = 97.0; //view 大小


@interface PreDroScrollView ()<ZDroppableViewDelegate>
{
    CGPoint mLastPosition;
}


@end


@implementation PreDroScrollView
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
    
    self.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
}


-(id) initWithFrame:(CGRect)frame imageDatas:(NSArray*)datas target:(UIView *)targetView regionView:(UIView *)regionView
{
    if (self = [super initWithFrame:frame]) {
     
        
        
        _o_imageDatas = [NSMutableArray arrayWithArray:datas];
        _o_targetView = targetView;
        _o_regionView = regionView;
        
        for (int i = 0; i < _o_imageDatas.count; i++) {
            
            [self addViewwithIndex:i];
            [self scrollToBottomAnimated:YES];
            
        }
        
        [self addLastButton];
        [self scrollToBottomAnimated:YES];
    }
    
    return self;
}


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
    
    while (self.subviews.count) {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
    
    for (int i = 0; i < _o_imageDatas.count; i++) {
        
        [self addViewwithIndex:i];
        [self scrollToBottomAnimated:YES];
        
    }
    
    [self addLastButton];
    [self scrollToBottomAnimated:YES];
    
}

- (void) addLastButton
{

    CGSize size = CGSizeMake(sDROPVIEW_SIZE, sDROPVIEW_SIZE);
    
    UIButton * addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    addButton.frame = CGRectMake(mLastPosition.x, mLastPosition.y, size.width, size.height);
    
    [addButton addTarget:self action:@selector(addNewImage:) forControlEvents:UIControlEventTouchUpInside];
    
    [addButton setImage:[UIImage imageNamed:@"bg_add_imgshow@2x.png"] forState:UIControlStateNormal];
    

    [self addSubview: addButton];
    [self relayout];
    
}


- (void) addViewwithIndex:(NSInteger)index
{
//    CGFloat contentWidth  = self.frame.size.width  - self.contentInset.left - self.contentInset.right;
//    CGFloat contentHeight = self.frame.size.height - self.contentInset.top;
    CGSize size = CGSizeMake(sDROPVIEW_SIZE, sDROPVIEW_SIZE);
    
    ZDroppableView * dropview = [[ZDroppableView alloc] initWithScrollView:self target:_o_targetView regionView:_o_regionView];
    dropview.o_userInfo = _o_imageDatas[index];
    dropview.frame = CGRectMake(mLastPosition.x, mLastPosition.y, size.width, size.height);
    dropview.o_index = index;
    dropview.o_delegate = self;
    dropview.o_isDefaultAnimation = YES;
    [self addSubview: dropview];
    
    
    [self relayout];
    
    EGOImageView* tImageVIew = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"loading_120px"]];
    
    tImageVIew.imageURL = [NSURL URLWithString:_o_imageDatas[index]];
    
    tImageVIew.autoresizingMask =
    
    UIViewAutoresizingFlexibleLeftMargin |
    UIViewAutoresizingFlexibleWidth |
    UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin |
    UIViewAutoresizingFlexibleHeight |
    UIViewAutoresizingFlexibleBottomMargin ;
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
    CGFloat contentWidth = self.contentSize.width - self.contentInset.left - self.contentInset.right;
    
    
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



#pragma mark- ZDroppableViewDelegate
-(BOOL) shouldAnimateDroppableView:(ZDroppableView *)dropView isDroppedOnTarget:(UIView *)targetView
{
    [self relayout];
    [self flashScrollIndicators];
    
    if (dropView.o_userInfo) {
        [_o_imageDatas removeObject:dropView.o_userInfo];
    }
    
    return YES;
}


-(void) droppableView:(ZDroppableView *)dropView exchangeWithOthers:(NSArray *__autoreleasing *)otherDropViews
{
    *otherDropViews = self.subviews;
}


-(void) droppableViewDidSelected:(ZDroppableView *)dropView
{
    if ([_o_delegate respondsToSelector:@selector(didSelectWithIndex:userInfo:)]) {
        [_o_delegate didSelectWithIndex:dropView.o_index userInfo:dropView.o_userInfo];
    }
    
}

@end
