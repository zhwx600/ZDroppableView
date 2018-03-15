//
//  ViewController.m
//  ZDroppableView
//
//  Created by zhwx on 15/5/4.
//  Copyright (c) 2015年 zhenwanxiang. All rights reserved.
//

#import "ViewController.h"
#import "ZDropScrollView.h"
#import "ZDeleteRegionView.h"



@interface ViewController ()<ZDropScrollViewDelegate>
{

}

@property (nonatomic,strong) ZDropScrollView* o_scrollView;


@property (nonatomic,strong) NSMutableArray* o_imageDatas;//（url）类型数组
@property (nonatomic,copy) NSString* o_grilImg;




@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    _o_imageDatas = [NSMutableArray arrayWithObjects:@"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3588772980,2454248748&fm=27&gp=0.jpg",
                     [NSURL URLWithString:@"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=1944805937,3724010146&fm=27&gp=0.jpg"],
//                     @"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=1046983545,2051560208&fm=27&gp=0.jpg",
                     @"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1983968240,1065183412&fm=27&gp=0.jpg",
                     @"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=122378782,224856546&fm=27&gp=0.jpg",
                     @"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=594559231,2167829292&fm=27&gp=0.jpg",
                     @"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=889120611,3801177793&fm=27&gp=0.jpg",
                     @"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=4204984068,3896675956&fm=27&gp=0.jpg",[UIImage imageNamed:@"icon_detele"],
                     @"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2239146502,165013516&fm=27&gp=0.jpg",nil];
    
    _o_grilImg = @"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1491526660,745456600&fm=27&gp=0.jpg";
    
    
    [self initCommonView];
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)initCommonView{
    
    _o_scrollView = [[ZDropScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 500)];
    [self.view addSubview:_o_scrollView];
    
    _o_scrollView.o_delegate = self;
    _o_scrollView.o_regionView = self.view;
    _o_scrollView.o_imageDatas = _o_imageDatas;
    
//    _o_scrollView.o_maxCount = 0;
//    _o_scrollView.o_isHideAddBtn = YES;
    
    [_o_scrollView reloadData];
    
}


#pragma mark- PreDroScrollViewDelegate
-(void) addNewView:(ZDropScrollView *)scrollView
{
    
//    NSLog(@"new _o_imageDatas = %@",_o_scrollView.o_imageDatas);

    NSMutableArray* newArray = [NSMutableArray arrayWithArray:_o_scrollView.o_imageDatas];
    [newArray addObject:_o_grilImg];
    
    //重新赋值，刷新
    _o_scrollView.o_imageDatas = newArray;
    [_o_scrollView reloadData];
}

-(void) didSelectWithIndex:(NSInteger)index userInfo:(id)userInfo
{
    NSLog(@"select index=%ld,userInfo=%@",(long)index,userInfo);
 
}

-(void) contentSizeDidChange:(CGSize)contenSize
{
    NSLog(@"size:%@",NSStringFromCGSize(contenSize));
}


@end
