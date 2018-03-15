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

-(void) contentSizeDidChange:(CGSize)contenSize;
//添加按钮 时间
-(void) addNewView:(ZDropScrollView*)scrollView;
//交换数据。 删除数据
-(void) exchangeIndex:(NSInteger)index otherIndex:(NSInteger)otherIndex;
-(void) removeIndex:(NSInteger)index;
//选中某一个
-(void) didSelectWithIndex:(NSInteger)index userInfo:(id)userInfo;

@end


@interface ZDropScrollView : UIScrollView

@property (nonatomic,assign) id<ZDropScrollViewDelegate> o_delegate;

@property (nonatomic,strong) UIView* o_regionView;//拖动区域视图

//NSString  数组 (可以自定义,NSString,UIImage,NSURL)
@property (nonatomic,strong) NSMutableArray* o_imageDatas;
//是否显示 添加按钮, 默认为NO
//YES 为隐藏， NO 显示。 权限高于个数限制
@property (nonatomic,assign) BOOL o_isHideAddBtn;
//默认是9。0为无限制。
//1、>=9不显示添加按钮，<9显示添加按钮。 2、0情况下看 由o_isHideAddBtn 决定按钮是否显示。
@property (nonatomic,assign) NSUInteger o_maxCount;

//刷新数据（赋值完调用此方法刷新）
-(void) reloadData;


@end
