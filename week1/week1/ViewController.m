//
//  ViewController.m
//  week1
//
//  Created by 최원영 on 2017. 3. 15..
//  Copyright © 2017년 최원영. All rights reserved.
//

#import "ViewController.h"
#import "NXPen.h"
#import "NXPenHolder.h"
#import "NXFileMatcher.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *capacityLabel;
@property (weak, nonatomic) IBOutlet UILabel *indexlabel;
@property NXPenHolder *aPenHolder;
@property int capacity;
@property int index;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 *  버튼이나 Stepper 터치
 */

/* 펜홀더의 케파를 지정한다 */
- (IBAction)changeValueByStepper:(UIStepper *)sender {
    _capacity = (int)[sender value];
    [_capacityLabel setText:[NSString stringWithFormat:@"%d", _capacity]];
}

/* 정해진 capacity 크기의 펜 홀더를 만든다 */
- (IBAction)makePenHolderByCapacity:(UIButton *)sender {
    _aPenHolder = [[NXPenHolder alloc] initWithCapacity:_capacity];
    [_aPenHolder printDescription];
}

/* 모나미를 하나 만들어서 aPenHolder에 넣는다. */
- (IBAction)makeMonamiPen:(UIButton *)sender {
    [self makeAndAddPenIntoPenHolder:@"monami"];
    [_aPenHolder printDescription];
}

/* 샤프를 하나 만들어서 aPenHolder에 넣는다. */
- (IBAction)makeSharpPen:(UIButton *)sender {
    [self makeAndAddPenIntoPenHolder:@"sharp"];
    [_aPenHolder printDescription];
}

/* 펜을 날릴 인덱스를 지정한다 */
- (IBAction)targetOfRemovingPen:(UIStepper *)sender {
    _index = (int)[sender value];
    _indexlabel.text = [NSString stringWithFormat:@"%d", _index];
}

/* 펜 홀더의 현황을 살펴본다 */
- (IBAction)descriptOfPenHolder:(UIButton *)sender {
    [_aPenHolder printDescription];
}

/* 특정 펜홀더의 펜을 날린다 */
- (IBAction)removePen:(UIButton *)sender {
    [_aPenHolder remove:_index];
    [_aPenHolder printDescription];
}

/**
 *  내가 만든 메소드(정리용)
 */

/* 특정 브랜드의 펜을 만들어 펜 홀더에 넣는다 */
- (void) makeAndAddPenIntoPenHolder:(NSString*)brand {
    NXPen *aPen = [[NXPen alloc] initWithBrand:brand];
    int r = arc4random_uniform(3);
    
    if(r == 0){
        [aPen setColor:@"red"];
    } else if (r == 1) {
        [aPen setColor:@"blue"];
    } else {
        [aPen setColor:@"black"];
    }
    [aPen setUsage:100];
    [aPen printDescription];
    
    [_aPenHolder add: aPen];
}

@end
