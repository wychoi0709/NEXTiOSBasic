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
    
    //랜덤한 숫자를 만들어서 아이템을 뽑는다.(모델의 역할을 강조하면 더 좋음. 필요한 데이터만 VC끼리 넘기고, 각 VC에서 모델에 요청하는게 더 좋은 방식!)
    int r = arc4random_uniform(4);
    NSDictionary *item = [_myModel itemAtIndex:r];

    //VC를 띄운다.
    DetailViewController *detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"detailViewController"];
    detailViewController.itemDic = item;    //공유용 property
    
    [self presentViewController:detailViewController animated:YES completion:^{
        
        //노티를 날린다. 메시지를 받는 애가 1:N 일 때, 사용한다.
        [[NSNotificationCenter defaultCenter] postNotificationName:@"myModelItem" object:self userInfo:item];
        
    }];
    
}

@end
