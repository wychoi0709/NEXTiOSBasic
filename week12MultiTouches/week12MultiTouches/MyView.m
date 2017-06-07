//
//  MyView.m
//  week12MultiTouches
//
//  Created by 최원영 on 2017. 5. 29..
//  Copyright © 2017년 최원영. All rights reserved.
//

#import "MyView.h"

@implementation MyView{
    CGFloat standardLength;
    CGPoint startingPoint;
}



/**
 * 로딩 이후, 배경 컬러를 지정한다. // 세로의 절반 길이를 입력해둔다(이걸 기준으로 알파값을 조절)
 */
- (void)awakeFromNib{
    [super awakeFromNib];
    
//    _backgroundColor = [UIColor colorWithRed:12/255.f green:2/255.f blue:201/255.f alpha:1.0];
    standardLength = [UIScreen mainScreen].bounds.size.height/2;
    NSLog(@"standardLength: %f", standardLength);
    
}


/**
 *  터치가 시작되면, 기준을 잡아둔다.
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    startingPoint = [[touches anyObject] locationInView:self];
    
    NSLog(@"touchedBegan x: %f", startingPoint.x);
    NSLog(@"touchedBegan y: %f", startingPoint.y);
    
}

/**
 *  터치가 움직이면, 기준과 얼마나 멀어지는지에 따라서 _backgroundColor의 alpha값을 수정한다.
 */
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //startingPoint와 지금 포인트의 길이를 측정한다.
    CGPoint correntPoint = [[touches anyObject] locationInView:self];
    CGFloat xDist = (correntPoint.x - startingPoint.x);
    CGFloat yDist = (correntPoint.y - startingPoint.y);
    CGFloat distance = sqrt((xDist * xDist) + (yDist * yDist));
    NSLog(@"distance: %f", distance);
    
    //기준 길이보다 멀어지면 알파값을 0으로 만들고, 그 길이가 기준 길이에 가까워질수록 알파값을 줄인다.
    if( distance > standardLength ){
        self.alpha = 0.0f;
    } else {
        self.alpha = 1.0f - distance/standardLength;
    }
    
}

/**
 *  터치가 종료되면, 다시 aplha 값을 되돌린다.
 */
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.alpha = 1.0f;
    
    NSArray<UITouch*>* touchArray = [event.allTouches allObjects];
    
    if ( touchArray.count == 2 ) {
        
        NSLog(@"이때!");
        
    }
    
}
@end
