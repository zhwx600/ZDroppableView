//
//  ZDeleteRegionView.h
//  ZDroppableView
//
//  Created by zwx on 2018/3/14.
//  Copyright © 2018年 zhenwanxiang. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 删除区域View
 */
@interface ZDeleteRegionView : UIView

@property (nonatomic,strong) UIImageView* o_imgView;
@property (nonatomic,strong) UILabel* o_textLabel;


//设置是否进入 到删除区域
-(void) setStatusIsIn:(BOOL)isIn;

//显示删除view
-(void) showInView:(UIView*)inView;
//隐藏
-(void) hide;


@end
