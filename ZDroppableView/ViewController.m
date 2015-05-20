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
    
    
    _o_imageDatas = [NSMutableArray arrayWithObjects:@"http://img.vxdcdn.com/system/20150416/2015041610541394.jpg",
                     @"http://img.vxdcdn.com/system/20150310/2015031016552883.jpg",
                     @"http://img.vxdcdn.com/system/20150312/2015031217491550.jpg",
                     @"http://img.vxdcdn.com/system/20150317/2015031717275688.jpg",
                     @"http://img.vxdcdn.com/system/20150331/2015033109575324.jpg",nil];
    
    
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
