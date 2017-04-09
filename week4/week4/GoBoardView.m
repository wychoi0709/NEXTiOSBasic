//
//  GoBoardView.m
//  week4
//
//  Created by 최원영 on 2017. 4. 9..
//  Copyright © 2017년 최원영. All rights reserved.
//

#import "GoBoardView.h"
#import "GoBoardModel.h"

@implementation GoBoardView{
    
    GoBoardModel *goBoardModel;
    
}


- (void)drawRect:(CGRect)rect {
    
    //배경을 그린다.
    [self drawBackground];
    
    //라인을 그린다.
    for( int i = 0; i < 11; i ++ ) {
        [self drawLineWithStartXY: goBoardModel.coordinatePositionArray[0][i] withEndXY: goBoardModel.coordinatePositionArray[10][i]];
    }
    
    for( int i = 0; i < 11; i ++ ) {
        [self drawLineWithStartXY:goBoardModel.coordinatePositionArray[i][0] withEndXY:goBoardModel.coordinatePositionArray[i][10]];
    }
}

/**
 *  좌표에 따라 라인을 그린다.
 */
- (void) drawLineWithStartXY:(NSArray*)startCoordinate withEndXY:(NSArray*)endCoordinate {
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGPoint startPoint = CGPointMake([startCoordinate[0] floatValue], [startCoordinate[1] floatValue]);
    [path moveToPoint:startPoint];
    CGPoint nextPoint = CGPointMake([endCoordinate[0] floatValue], [endCoordinate[1] floatValue]);
    [path addLineToPoint:nextPoint];
    [path setLineWidth:1.0];
    [path stroke];
    
}

/**
 *  배경을 그린다.
 */
- (void) drawBackground {
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGRect oakRect = CGRectMake(0.0, 0.0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    UIImage *image = [UIImage imageNamed:@"oak.png"];
    CGContextDrawImage(c, oakRect, image.CGImage);
}

/**
 * 로딩 이후 노티를 추가한다.
 */
- (void)awakeFromNib{
    [super awakeFromNib];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reDrawAfterGetModel:) name:@"renewBoardView" object:nil];
    
}

- (void)reDrawAfterGetModel:(NSNotification*)noti{
    
    //모델을 갱신하고 뷰를 다시 그린다.
    goBoardModel = [[noti userInfo] objectForKey:@"newGoBoardModel"];
    [self setNeedsDisplay];
    
}

@end
