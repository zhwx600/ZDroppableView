//
//  ViewController.m
//  ZDroppableView
//
//  Created by zhwx on 15/5/4.
//  Copyright (c) 2015年 zhenwanxiang. All rights reserved.
//

#import "ViewController.h"
#import "ZDropScrollView.h"


@interface ViewController ()<ZDropScrollViewDelegate>
{
    IBOutlet UIImageView *o_targetImageView;
    IBOutlet ZDropScrollView *o_preScrollView;
}

@property (nonatomic,strong) NSMutableArray* o_imageDatas;//（url）类型数组

@property (nonatomic,copy) NSString* o_grilImg;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    _o_imageDatas = [NSMutableArray arrayWithObjects:@"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3588772980,2454248748&fm=27&gp=0.jpg",
                     @"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=1944805937,3724010146&fm=27&gp=0.jpg",
                     @"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=1046983545,2051560208&fm=27&gp=0.jpg",
                     @"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1983968240,1065183412&fm=27&gp=0.jpg",
                     @"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=122378782,224856546&fm=27&gp=0.jpg",
                     @"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=594559231,2167829292&fm=27&gp=0.jpg",
                     @"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=889120611,3801177793&fm=27&gp=0.jpg",
                     @"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=4204984068,3896675956&fm=27&gp=0.jpg",
                     @"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2239146502,165013516&fm=27&gp=0.jpg",nil];
    
    _o_grilImg = @"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1491526660,745456600&fm=27&gp=0.jpg";
    
    
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
    
//    o_preScrollView.o_maxCount = 0;
//    o_preScrollView.o_isHideAddBtn = YES;
    
    [o_preScrollView reloadData];
    
    
}


#pragma mark- PreDroScrollViewDelegate
-(void) addNewView:(ZDropScrollView *)scrollView
{
    
    NSLog(@"new _o_imageDatas = %@",o_preScrollView.o_imageDatas);
    
    NSString* girl = [NSMutableString stringWithFormat:@"%@",_o_grilImg];
    
    NSMutableArray* newArray = [NSMutableArray arrayWithArray:o_preScrollView.o_imageDatas];
    [newArray addObject:@"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1491526660,745456600&fm=27&gp=0.jpg"];
    
    
    o_preScrollView.o_imageDatas = newArray;
    
    [o_preScrollView reloadData];
}

-(void) didSelectWithIndex:(NSInteger)index userInfo:(id)userInfo
{
    NSLog(@"select index=%ld,userInfo=%@",(long)index,userInfo);
 
}

@end
