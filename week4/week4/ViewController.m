//
//  ViewController.m
//  week4
//
//  Created by 최원영 on 2017. 4. 5..
//  Copyright © 2017년 최원영. All rights reserved.
//

#import "ViewController.h"

//뷰 클래스들
#import "GoBoardView.h"
#import "GoStoneView.h"
#import "GoGraphView.h"

//뷰모델 클레스들
#import "GoBoardModel.h"
#import "GoStoneModel.h"
#import "GoGraphModel.h"

//그냥 모델 클레스
#import "GoCoordinate.h"

@interface ViewController (){
    
    GoBoardModel *goBoardModel;
    
}


@property (weak, nonatomic) IBOutlet GoBoardView *goBoardView;
@property (weak, nonatomic) IBOutlet GoStoneView *goStoneView;
@property (weak, nonatomic) IBOutlet GoGraphView *goGraphView;

@end

@implementation ViewController


- (void)viewWillAppear:(BOOL)animated{
    

    

}

- (void)viewDidLoad {
    [super viewDidLoad];

    //뷰를 그리기 전에 모델을 초기화해서 뷰에 보내주고, 모델에서 View로 신호를 보낸다.
    goBoardModel = [[GoBoardModel alloc] initWithTotalWidth:[UIScreen mainScreen].bounds.size.width];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
