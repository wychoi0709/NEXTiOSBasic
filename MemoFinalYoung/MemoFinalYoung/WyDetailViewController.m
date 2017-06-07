//
//  WyDetailViewController.m
//  MemoFinalYoung
//
//  Created by 최원영 on 2017. 6. 7..
//  Copyright © 2017년 최원영. All rights reserved.
//

#import "WyDetailViewController.h"


@interface WyDetailViewController ()

@property (weak, nonatomic) IBOutlet UITextField *memoContentTextField;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;

@end

@implementation WyDetailViewController{
    MemoManager *memoManager;
    Boolean enterFromCellTouched;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _closeBtn.hidden = YES;
    enterFromCellTouched = NO;
    
    memoManager = [MemoManager getMemoManagerObject];
    
    // 넘겨받은 memo가 있다면 TextField에 입력한다.
    if ( _aMemo ){
        _memoContentTextField.text = _aMemo.content;
        _closeBtn.hidden = NO;
        enterFromCellTouched = YES;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)completeBtnTouched:(UIButton *)sender {
    
    NSDateFormatter *today = [[NSDateFormatter alloc] init];
    [today setDateFormat:@"yyyy-MM-dd-hh-mm-ss"];
    
    Memo *aMemo = [[Memo alloc] init];
    
    aMemo.time = [today stringFromDate:[NSDate date]];
    aMemo.content = _memoContentTextField.text;
    
    if( enterFromCellTouched ){
        
        [memoManager updateMemo:_aMemo withTime:[today stringFromDate:[NSDate date]] withContent:_memoContentTextField.text];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } else{
        [memoManager addMemo:aMemo];
    }
    
}

- (IBAction)closeBtnTouched:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


@end
