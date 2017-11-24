//
//  ViewController.m
//  ZDroppableView
//
//  Created by zhwx on 15/5/4.
//  Copyright (c) 2015年 zhenwanxiang. All rights reserved.
//

#import "ViewController.h"
#import "PreDroScrollView.h"


@interface ViewController ()<PreDroScrollViewDelegate>
{
    IBOutlet UIImageView *o_targetImageView;
    IBOutlet PreDroScrollView *o_preScrollView;
}

@property (nonatomic,strong) NSMutableArray* o_imageDatas;//（url）类型数组

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    _o_imageDatas = [NSMutableArray arrayWithObjects:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1511539684005&di=02e96382cb5f2dc45f6c156eaa3bc923&imgtype=0&src=http%3A%2F%2Fb.hiphotos.baidu.com%2Fimage%2Fpic%2Fitem%2Fd1a20cf431adcbef77b523d7a6af2edda2cc9f59.jpg",
                     @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1511539684005&di=bd64a98335dbcfb613b80b5380eeb4f8&imgtype=0&src=http%3A%2F%2Fd.hiphotos.baidu.com%2Fimage%2Fpic%2Fitem%2F1ad5ad6eddc451dac228b23bbcfd5266d1163207.jpg",
                     @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1511539684600&di=002913adcf7cb0683c7ebcceb8876c5e&imgtype=0&src=http%3A%2F%2Fe.hiphotos.baidu.com%2Fimage%2Fpic%2Fitem%2Fd058ccbf6c81800aa53059e4bb3533fa838b4707.jpg",
                     @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1511539684597&di=8fa40d72f6e31f0e3347d3792ff9ed29&imgtype=0&src=http%3A%2F%2Fe.hiphotos.baidu.com%2Fimage%2Fpic%2Fitem%2Fc75c10385343fbf276730692ba7eca8065388f20.jpg",
                     @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1511539779562&di=55ddf8bed0a2115d96a746f0346b2235&imgtype=0&src=http%3A%2F%2Fd.hiphotos.baidu.com%2Fimage%2Fcrop%253D0%252C0%252C640%252C904%2Fsign%3D389ad0cade0735fa85bf14f9a3612383%2Fd50735fae6cd7b890dd34852052442a7d8330ea7.jpg",nil];
    
    
    [self initCommonView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)initCommonView{
    
    o_preScrollView.o_delegate = self;
    o_preScrollView.o_targetView = o_targetImageView;
    o_preScrollView.o_regionView = self.view;
    o_preScrollView.o_imageDatas = _o_imageDatas;

}


#pragma mark- PreDroScrollViewDelegate
-(void) addNewView:(ZDropScrollView *)scrollView
{
    
    NSLog(@"new _o_imageDatas = %@",o_preScrollView.o_imageDatas);
    
    
    
    NSMutableArray* newArray = [NSMutableArray arrayWithArray:o_preScrollView.o_imageDatas];
    [newArray addObject:_o_imageDatas[arc4random()%5]];

    o_preScrollView.o_imageDatas = newArray;

}

-(void) didSelectWithIndex:(NSInteger)index userInfo:(id)userInfo
{
    NSLog(@"select index=%ld,userInfo=%@",(long)index,userInfo);
 
}

@end
