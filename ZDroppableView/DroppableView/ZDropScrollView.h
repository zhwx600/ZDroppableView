//
//  ZDropScrollView.h
//  DroppableViewTest
//
//  Created by zhwx on 15/4/16.
//
//

#import <UIKit/UIKit.h>

@class ZDropScrollView;
@protocol ZDropScrollViewDelegate <NSObject>

-(void) addNewView:(ZDropScrollView*)scrollView;

-(void) didSelectWithIndex:(NSInteger)index userInfo:(id)userInfo;

@end


@interface ZDropScrollView : UIScrollView

@property (nonatomic,assign) id<ZDropScrollViewDelegate> o_delegate;

@property (nonatomic,strong) UIView* o_targetView;//拖动消失区域视图
@property (nonatomic,strong) UIView* o_regionView;//拖动区域视图

//NSString  数组 (可以自定义)
@property (nonatomic,strong) NSMutableArray* o_imageDatas;
//是否显示 添加按钮, 默认为NO
//YES 为隐藏， NO 显示。 权限高于个数限制
@property (nonatomic,assign) BOOL o_isHideAddBtn;
//默认是9。0为无限制。
//1、>=9不显示添加按钮，<9显示添加按钮。 2、0情况下看 由o_isHideAddBtn 决定按钮是否显示。
@property (nonatomic,assign) NSUInteger o_maxCount;

//刷新数据
-(void) reloadData;


@end
