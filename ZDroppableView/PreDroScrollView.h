//
//  PreDroScrollView.h
//  TinySeller
//
//  Created by zhwx on 15/4/16.
//  Copyright (c) 2015年 zhenwanxiang. All rights reserved.
//

#import "ZDropScrollView.h"

@protocol PreDroScrollViewDelegate <NSObject>

-(void) addNewView:(ZDropScrollView*)scrollView;

-(void) didSelectWithIndex:(NSInteger)index userInfo:(id)userInfo;

@end


@interface PreDroScrollView : ZDropScrollView


@property (nonatomic,assign) id<PreDroScrollViewDelegate> o_delegate;

@property (nonatomic,strong) UIView* o_targetView;
@property (nonatomic,strong) UIView* o_regionView;

//NSString  数组 (可以自定义)
@property (nonatomic,strong) NSMutableArray* o_imageDatas;




-(id) initWithFrame:(CGRect)frame imageDatas:(NSMutableArray*)datas target:(UIView*)targetView regionView:(UIView*)regionView;

@end
