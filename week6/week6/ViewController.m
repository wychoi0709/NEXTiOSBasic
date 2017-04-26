//
//  ViewController.m
//  week6
//
//  Created by 최원영 on 2017. 4. 24..
//  Copyright © 2017년 최원영. All rights reserved.
//

#import "ViewController.h"
#import "CardDeck.h"
#import "Card.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self applyNotification];
    
    CardDeck *cardDeck = [[CardDeck alloc] init];
    [cardDeck randomize];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  모든 노티를 등록한다.
 */
- (void)applyNotification{
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    
    [defaultCenter addObserver:self selector:@selector(afterGetThreeRandomCards:) name:@"sendThreeRandomCards" object:nil];
    
}


/**
 *  카드 세장을 받고 난 이후 메소드
 */
- (void) afterGetThreeRandomCards:(NSNotification*)noti{
    
}
@end
