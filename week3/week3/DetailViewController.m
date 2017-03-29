//
//  DetailViewController.m
//  week3
//
//  Created by 최원영 on 2017. 3. 29..
//  Copyright © 2017년 최원영. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(afterLoading:) name:@"myModelItem" object:nil];
    
    NSLog(@"itemDic!! %@", _itemDic);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  로딩 후 콜백 메소드
 */
- (void) afterLoading:(NSNotification*)noti {
    _titleLabel.text = [[noti userInfo] objectForKey:@"title"];
    
    NSString* imageName = [[noti userInfo] objectForKey:@"image"];
    _imageView.image = [UIImage imageNamed:imageName];
}

/**
 *  닫기버튼을 터치했을 경우
 */
- (IBAction)closedBtnTouched:(UIButton *)sender {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
