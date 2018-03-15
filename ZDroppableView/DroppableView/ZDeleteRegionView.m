//
//  ZDeleteRegionView.m
//  ZDroppableView
//
//  Created by zwx on 2018/3/14.
//  Copyright © 2018年 zhenwanxiang. All rights reserved.
//

#import "ZDeleteRegionView.h"

#define ZDeleteRegionViewHeight  60.0f

@implementation ZDeleteRegionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubView];
    }
    return self;
}


-(void) setupSubView
{
    CGRect fullBounds = [[UIScreen mainScreen] bounds];
    self.frame = CGRectMake(0, fullBounds.size.height - ZDeleteRegionViewHeight, fullBounds.size.width, ZDeleteRegionViewHeight);
    CGRect myFrame = self.frame;
    
    _o_imgView = [[UIImageView alloc] init];
    _o_imgView.frame = CGRectMake(0, 0, myFrame.size.width, 40);
    _o_imgView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _o_imgView.contentMode = UIViewContentModeCenter;
    
    _o_textLabel = [[UILabel alloc] init];
    _o_textLabel.textAlignment = NSTextAlignmentCenter;
    _o_textLabel.frame = CGRectMake(0, 40, myFrame.size.width, 10);
    _o_textLabel.textColor = [UIColor whiteColor];
    _o_textLabel.font = [UIFont systemFontOfSize:10];
    _o_textLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    
    [self addSubview:_o_imgView];
    [self addSubview:_o_textLabel];
    
    [self setStatusIsIn:NO];
}


-(void) setStatusIsIn:(BOOL)isIn
{
    if (isIn) {
        self.backgroundColor = [UIColor colorWithRed:207/255.0 green:79/255.0 blue:79/255.0 alpha:1];
        _o_imgView.image = [UIImage imageNamed:@"delete_open"];
        _o_textLabel.text = @"松手即可删除";
    }else{
        self.backgroundColor = [UIColor colorWithRed:228/255.0 green:85/255.0 blue:86/255.0 alpha:1];
        _o_imgView.image = [UIImage imageNamed:@"delete_close"];
        _o_textLabel.text = @"拖动到此处删除";
    }
}

-(void) showInView:(UIView*)inView
{
    [self setStatusIsIn:NO];
    
    CGRect vFrame = inView.frame;
    
    self.frame = CGRectMake(0, vFrame.size.height, vFrame.size.width, ZDeleteRegionViewHeight);
    [inView addSubview:self];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.frame = CGRectMake(0, vFrame.size.height-ZDeleteRegionViewHeight, vFrame.size.width, ZDeleteRegionViewHeight);
    } completion:^(BOOL finished) {
        
    }];
    
}
-(void) hide
{
    CGRect vFrame = self.superview.frame;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.frame = CGRectMake(0, vFrame.size.height, vFrame.size.width, ZDeleteRegionViewHeight);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
