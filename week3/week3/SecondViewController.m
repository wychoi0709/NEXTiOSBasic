//
//  SecondViewController.m
//  week3
//
//  Created by 최원영 on 2017. 3. 29..
//  Copyright © 2017년 최원영. All rights reserved.
//

#import "SecondViewController.h"
#import "MyModel.h"
#import "DetailViewController.h"

@interface SecondViewController ()

@property MyModel* myModel;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //텍스트를 가져온 뒤 모델을 만들어둔다.
    NSString *path = [[NSBundle mainBundle] pathForResource:@"jsonString" ofType:@"txt"];
    NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"%@", content);
    
    _myModel = [[MyModel alloc] initWithJSONString: content];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  랜덤 버튼 터치
 */
- (IBAction)randomButtonTouched:(UIButton *)sender {
    
    //랜덤한 숫자를 만들어서 아이템을 뽑는다.
    int r = arc4random_uniform(4);
    NSDictionary *item = [_myModel itemAtIndex:r];

    //VC를 띄운다.
    DetailViewController *detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"detailViewController"];
    [self presentViewController:detailViewController animated:YES completion:nil];
    
    //노티를 날린다.
    [[NSNotificationCenter defaultCenter] postNotificationName:@"myModelItem" object:self userInfo:item];

}

@end
